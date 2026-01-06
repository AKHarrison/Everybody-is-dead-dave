extends Control

@onready var leaderboard_container: VBoxContainer = $LeaderboardContainer

func _ready():
	display_leaderboard()

func display_leaderboard():
	# clear existing entried
	for child in leaderboard_container.get_children():
		child.queue_free()
		
	# get top 5 entries
	var top_entries = MobManager.get_top_entries(5)
	
	if top_entries.is_empty():
		var label = Label.new()
		label.text = "No entries yet!"
		leaderboard_container.add_child(label)
		return
		
	# Display each entry
	for i in range(top_entries.size()):
		var entry = top_entries[i]
		var label = Label.new()
		label.text = "%d. Time: %s | Mobs: %d" % [i + 1, entry.time, entry.mobs]
		leaderboard_container.add_child(label)

#need to add feature to display seperate leaderboard for winning and losing
