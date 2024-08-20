extends Control

var current_stat_index: int = 0  # Start with the first stat highlighted
var num_stats: int = 3  # Total number of stats
var total_stat_points: int = 4

func _ready():
	# Connect signals
	UiController.connect("stat_selection_changed", _on_stat_selection_changed)
	UiController.connect("stat_start", _on_stat_start)
	UiController.connect("stat_changed", _on_stat_changed)
	hide_all_orbs()
	update_highlight()

func move_highlight(direction: int):
	# Update current_stat_index based on input direction
	current_stat_index += direction
	# Clamp the index to the valid range [0, num_stats - 1]
	current_stat_index = clamp(current_stat_index, 0, num_stats - 1)
	update_highlight()  # Update highlight position

func update_highlight():
	# Get the HBoxContainer for the current stat
	var stat_container = $Background/StatsContainer.get_child(current_stat_index)
	
	for node in $Background/StatsContainer.get_children(true):
		if node.get_child_count() == 0:
			continue
		var lab: Label = node.get_child(0)
		lab.add_theme_color_override("font_color", Color.WHITE)
	# Ensure the reference is valid
	if stat_container:
		var label: Label = stat_container.get_child(0)
		label.add_theme_color_override("font_color", Color.YELLOW)
	else:
		print("Error: Stat container not found.")
		
func render_orbs(current_stat_index: int, orb_numbers: int) -> void:
	var stat_container: Node = $Background/StatsContainer.get_child(current_stat_index)
	var remaining = total_stat_points - orb_numbers
	
	for index in range(orb_numbers):
		stat_container.get_child(index + 1).visible = true
		
	for index in range(remaining):
		stat_container.get_child(total_stat_points - index).visible = false
	update_highlight()

func _on_stat_selection_changed(stat_index: int) -> void:
	current_stat_index = stat_index
	update_highlight()
	
func _on_stat_changed(new_value: int) -> void:
	render_orbs(current_stat_index, new_value)
	
func _on_stat_start(stat_values: int) -> void:
	print(stat_values)
		
func hide_all_orbs() -> void:
	var nodes = $Background/StatsContainer.get_children()
	
	for i in range(num_stats):
		var node = nodes[i]
		if node.get_child_count() > 0:
			for j in range(1, 5):
				node.get_child(j).visible = false
