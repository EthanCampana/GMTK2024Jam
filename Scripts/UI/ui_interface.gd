extends Control # or Control

# Current highlighted index
var current_stat_index: int = 0  # Start with the first stat highlighted
var num_stats: int = 3  # Total number of stats

func _ready():
	# Ensure CurrentStatHighlight is visible and in the right position
	$Background/StatsContainer/CurrentStatHightlight.visible = true  # Ensure highlight is visible
	update_highlight()  # Update highlight position

func _process(delta):
	# Handle input detection for arrow keys
	if Input.is_action_just_pressed("ui_up"):
		move_highlight(-1)
	elif Input.is_action_just_pressed("ui_down"):
		move_highlight(1)

func move_highlight(direction: int):
	# Update current_stat_index based on input direction
	current_stat_index += direction
	# Clamp the index to the valid range [0, num_stats - 1]
	current_stat_index = clamp(current_stat_index, 0, num_stats - 1)
	update_highlight()  # Update highlight position

func update_highlight():
	# Get the HBoxContainer for the current stat
	var stat_container = $Background/StatsContainer.get_child(current_stat_index )  # +2 to skip TitleLabel and get to the first stat
	
	# Ensure the reference is valid
	if stat_container:
		# Set CurrentStatHighlight to the correct position
		var highlight_position = stat_container.position  # Get the position of the selected stat
		$Background/StatsContainer/CurrentStatHightlight.position = highlight_position
		# Center the highlight on the stat if necessary
		# Assuming you want to center it, you can subtract half of the width of the highlight here if needed
	else:
		print("Error: Stat container not found.")
