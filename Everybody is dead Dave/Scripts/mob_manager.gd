extends Node

var total_mobs_spawned = 0

const SAVE_FILE = "user://leaderboard.save"
var leaderboard_entries = []

func add_leaderboard_entry(time: String, mobs: int):
	var entry = {
		"time": time,
		"mobs": mobs,
		"timestamp": Time.get_unix_time_from_system()
	}
	leaderboard_entries.append(entry)
	save_leaderboard()
	
func save_leaderboard():
	var file = FileAccess.open(SAVE_FILE, FileAccess.WRITE)
	if file:
		file.store_var(leaderboard_entries)
		file.close()
		print("leaderboard saved!")
		
func load_leaderboard():
	if FileAccess.file_exists(SAVE_FILE):
		var file= FileAccess.open(SAVE_FILE, FileAccess.READ)
		if file:
			leaderboard_entries = file.get_var()
			file.close()
			print("Leaderboard loaded: ", leaderboard_entries.size(), " entries")
	else:
		print("No save file found, starting fresh")
		
func get_top_entries(count: int = 10):
	# Sort by mobs killed (descending), then by time survived
	var sorted = leaderboard_entries.duplicate()
	sorted.sort_custom(func(a, b): 
		if a.mobs != b.mobs:
			return a.mobs > b.mobs
		return a.time > b.time
	)
	return sorted.slice(0, count)

func _ready():
	load_leaderboard()
