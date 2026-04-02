# 💀 Everybody is dead Dave

[![Godot 4.5](https://img.shields.io/badge/Godot-4.5-blue?logo=godot-engine&logoColor=white)](https://godotengine.org/)
[![GDScript](https://img.shields.io/badge/GDScript-100%25-informational?logo=godot-engine&logoColor=white)](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/)
[![CI](https://github.com/AKHarrison/Everybody-is-dead-dave/actions/workflows/ci.yml/badge.svg)](https://github.com/AKHarrison/Everybody-is-dead-dave/actions/workflows/ci.yml)
[![Latest Release](https://img.shields.io/github/v/release/AKHarrison/Everybody-is-dead-dave)](https://github.com/AKHarrison/Everybody-is-dead-dave/releases)

> *A top-down Geordie chaos simulator. Everyone is dead, Dave.*

You are **UtheBomb**. The streets of the North East are crawling with mobs — Gran shuffling toward you with her shopping, Edna on a mission, a Geordie with a tache who's had a few, and your general local divvies — and every single one of them wants a word. Your arsenal? Pure Geordie vocabulary. Your strategy? Leg it.

Survive the streets. Outsmart the mobs. Top the leaderboard. Canny, like.

---

## 🗺️ Maps

| Map | Vibe |
|-----|------|
| **UTB** | The main strip. Ruff terraces, road crossings, Dreggs boozer. Classic. |
| **Tutorial Forest** | Learn the ropes without getting battered. |
| **Inside Dreggs** | You went in the pub. Nowt good comes of this. |
| **Whitley Bay** *(coming soon)* | Spanish City dome, Pablo's Eggs Go Bao, the arcades, Al's Bar. |

---

## 📸 Screenshots

<!-- Add screenshots here -->

---

## 🎮 Controls

| Key | Action |
|-----|--------|
| `← → ↑ ↓` | Move UtheBomb |
| `Z` | Launch an insult |
| `X` | Say sorry (you soft lad) |
| `Escape` | Pause |

---

## 🛠️ Local Setup

You'll need **[Godot 4.5](https://godotengine.org/download/)** — that's genuinely it. No npm. No pip. No Docker. No suffering.

**1. Clone the repo**

```bash
git clone https://github.com/AKHarrison/Everybody-is-dead-dave.git
cd Everybody-is-dead-dave
```

**2. Open in Godot**

- Launch **Godot 4.5**
- Click **Import**
- Navigate to `Everybody is dead Dave/project.godot`
- Click **Open**

**3. Play**

Hit **F5** (or the ▶ Play button). The start screen should load. You're in.

> **Note:** If Godot asks to convert the project, let it. If it screams about missing `.godot/` folder, let it regenerate — that folder is gitignored by design.

---

## 📁 Project Structure

```
Everybody is dead Dave/
├── Scripts/           # GDScript — player, AI states, scene/mob/win management
├── Scenes/
│   ├── Game/          # Maps + game screens (UTB, menus, game over, leaderboard)
│   ├── Mob/           # Mob scene files (Geordie, Gran, Edna, Tache)
│   ├── Player/        # Player scene + insult projectiles (Divvy, Numpty, Twat, Sorry)
│   └── Environment/   # Buildings, trees, bins, lampposts, traffic, shops
├── GUI/               # HUD (score, player status)
├── Audio/             # Background music and SFX
└── Sprites/           # All textures and sprite sheets
```

---

## 🤝 Contributing

This project uses **[Conventional Commits](https://www.conventionalcommits.org/)** — the release workflow reads commit messages to auto-bump the version and write the changelog.

```
feat: add new mob variant
fix: stop gran spawning inside the chippy wall
chore: remove leftover print statements
docs: update README controls table
```

**Workflow:**

```bash
# Branch off with a feature/ prefix
git checkout -b feature/my-cool-thing

# Do your work, commit with conventional messages
git commit -m "feat: add bees"

# Push and open a PR into master
git push origin feature/my-cool-thing
# → CI runs automatically (gdlint + scene validation)
# → On merge to master, a new release is published automatically
```

---

## 🏆 Credits

- **AKHarrison** — mob AI improvements, leaderboard system
- Built with [Godot Engine](https://godotengine.org/) 💙