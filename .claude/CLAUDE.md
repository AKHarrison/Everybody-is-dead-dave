# Everybody is dead Dave — Claude Context

## What Is This?

A top-down 2D Geordie comedy game built in **Godot 4.5** (GDScript). The player (UtheBomb) navigates North East England streets, hurling insults at AI-driven mobs to survive and top the leaderboard.

**Repo:** `AKHarrison/Everybody-is-dead-dave` on GitHub  
**Game folder:** `Everybody is dead Dave/` — note the space; always quote this path in shell commands  
**Engine:** Godot 4.5, GL Compatibility renderer, 60 FPS cap, 2D pixel-snapped

---

## Architecture

### Autoloads (Singletons)

Always available in GDScript — no need to `$find_child` them:

| Autoload | File | Purpose |
|----------|------|---------|
| `Global` | `Scripts/global.gd` | Legacy scene-switch helpers |
| `LevelManager` | `Scripts/GlobalLevelManager.gd` | Broadcasts TileMap bounds to mobs via signal |
| `GlobalTimer` | `Scripts/global_timer.gd` | Shared countdown timer |
| `scene_manager` | `Scripts/scene_manager.gd` | Scene transitions — persists player node across scenes |
| `MobManager` | `Scripts/mob_manager.gd` | Tracks total mobs spawned |
| `WinManager` | `Scenes/Game/win_manager.gd` | Win/loss condition logic |
| `HudManager` | `GUI/hud_manager.tscn` | Player HUD display |

### Map / Scene Structure

Each playable map is a `.tscn` in `Scenes/Game/`:

- **Main map** (`utb.tscn`) — root script `utb.gd`; contains full UTB street layout with TileMapLayers, buildings, `MobSpawn` node with Marker2D spawn points
- **Sub-scenes** (`tutorial_forest.tscn`, `inside_dreggs.tscn`) — root script `base_scene.gd`; use `EntranceMarkers/any` Marker2D for player positioning on entry
- **All maps share:**
  - `LevelTileMap` node (class `LevelTileMap extends TileMapLayer`) — auto-reports bounds to `LevelManager` in `_ready()`
  - Building instances from `Scenes/Environment/Buildings/`
  - `SceneTrigger` nodes (Area2D) — set `connected_scene` export string to transition to another map filename (no extension)
  - `AudioStreamPlayer` for background music

### Mob AI Pattern

Every mob type has **4 state GDScript files** in `Scripts/`:

```
{type}_wander_state.gd   ← walks randomly, uses RayCast2D to detect player
{type}_idle_state.gd     ← stands still briefly
{type}_chase_state.gd    ← spotted player, navigates via NavigationAgent2D
{type}_home_state.gd     ← lost player, returning to spawn area
```

Driven by: `Scripts/mob_state_machine.gd`  
Mob types: `geordie`, `gran`, `edna`, `tache`  
Mob scenes: `Scenes/Mob/mob_{type}.tscn`  
All mob scenes use `Scenes/Mob/mob_base.gd` as root script.

### Player

- `Scripts/player.gd` — `CharacterBody2D`, cardinal-only movement (diagonals suppressed)
- Insult projectiles in `Scenes/Player/Insults/`: Sorry, Twat, Divvy, Numpty
- Input map: `ui_A` (Z) = insult, `sorry` (X) = sorry, arrow keys = movement, `Pause` (Escape)

### Scene Transitions

`SceneTrigger` (`Scenes/Game/scene_trigger.tscn`) is an Area2D with:

```gdscript
@export var connected_scene: String  # filename without .tscn extension
```

On player body_entered → calls `scene_manager.change_scene(get_owner(), connected_scene)`.  
`scene_manager` detaches the player node, loads the new scene, reattaches player, positions via `EntranceMarkers/any`.

---

## Naming Conventions

| Thing | Convention |
|-------|-----------|
| `.tscn` scene names and `class_name` | PascalCase |
| `.gd` script filenames | snake_case |
| Mob state scripts | `{mob_type}_{state_name}_state.gd` |
| Export variables | snake_case |

---

## Key Files

| File | Notes |
|------|-------|
| `project.godot` | Engine config, autoloads, input map — edit in Godot editor, not by hand |
| `Scripts/scene_manager.gd` | Scene transition + player node persistence — touch carefully |
| `Scripts/mob_spawn.gd` | Spawns random mob at random Marker2D spawn point on timer |
| `Roads.tres` | Road TileSet resource — shared across maps |
| `Scenes/pathandtrees.tres` | Path/tree TileSet — shared across maps |
| `GUI/player_hud.tscn` | HUD scene wired to `HudManager` autoload |

---

## What NOT to Do

- Don't edit `.import` or `.uid` files — Godot auto-generates them; editing breaks the project
- Don't edit `project.godot` directly for autoload/input changes — use the Godot Project Settings editor
- Don't leave `print()` debug statements in committed code
- Don't add new autoloads without registering them in `project.godot` via the editor

---

## Branch Strategy

- `master` — integration target for releases (may not exist yet)
- `feature/*` — all new work; PRs targeting `master` trigger CI
- Existing `main` / `New-Map` branches — untouched by CI/CD workflows

## Commit Convention

This project uses Conventional Commits for automated releases:
`feat:` / `fix:` / `chore:` / `docs:` / `refactor:` / `perf:` / `test:`
