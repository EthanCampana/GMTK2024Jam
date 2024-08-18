extends Control

# Define UI elements
@onready var panel = $PanelContainer
@onready var highlight = $PanelContainer/Highlight
@onready var vbox_container = panel.get_node("VerticalBxContainer")


# List of all stat boxes (child nodes of VBoxContainer)
var stat_boxes = []
var sliders = []
var current_index = 0
var total_stat_points = 0

func _ready():
	# Initialize stat boxes array
	 # Initialize stat boxes and sliders arrays
	for i in range(vbox_container.get_child_count()):
		var stat_box = vbox_container.get_child(i)
		#if stat_box.name.begins_with("StatBox"):  # Ensure it's a StatBox node
		stat_boxes.append(stat_box)
		var slider = stat_box.get_node("HSlider")  # Assuming the slider is named "HSlider"
		if slider:
			sliders.append(slider)
	
	# Set total stat value points
	for i in range(len(sliders)):
		total_stat_points = total_stat_points + sliders[i].value
		
	
	# Ensure highlight is initially hidden or set
	highlight.visible = false

	# Set the initial highlight position*
	update_highlight()

func _input(event):
	if event.is_action_pressed("ui_up"):
		move_selection(-1)
	elif event.is_action_pressed("ui_down"):
		move_selection(1)
	elif event.is_action_pressed("ui_right"):
		sliders[current_index].value = sliders[current_index].value+1
	elif event.is_action_pressed("ui_left"):
		sliders[current_index].value = sliders[current_index].value-1
			

func move_selection(direction: int):
	# Update current index based on direction
	current_index = (current_index + direction) % stat_boxes.size()
	
	# Ensure index is within bounds
	if current_index < 0:
		current_index = stat_boxes.size() - 1
		
	# Update highlight to new selection
	update_highlight()

func update_highlight():
	# Hide highlight if no stat box is available
	if stat_boxes.size() == 0:
		highlight.visible = false
		return

	# Get the currently selected stat box
	var selected_box = stat_boxes[current_index]

	# Set highlight size and position
	highlight.color = Color(0.39,0.39,0.39,0.39)
	highlight.position = selected_box.position
	highlight.visible = true
	
func increase_stat():
	if can_increase_stat():
		pass

func can_increase_stat():
	var cur_total = 0
	for i in range(len(sliders)):
		cur_total = cur_total + sliders[i].value
	if cur_total < total_stat_points:
		return true
	return false
		
		
