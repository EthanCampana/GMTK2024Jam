class_name MainMenu
extends Control


"""
TODO:
	- Hookup Buttons to do there respective tasks
	- Exit button should close the application
	- Settings button should open the settings menu
	- Play buttons should start the main scene or whatever scene is the SceneManager says
"""

@onready var version_num : Label = $VBoxContainer/MarginContainer/Label
var settings_menu : PackedScene = preload("res://Scenes/Menus/settings_menu.tscn")

var sd : SaveData



# Called when the node enters the scene tree for the first time.
func _ready():
	SaveData.load_or_create()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_settings_pressed():
	self.visible = false
	var menu = settings_menu.instantiate()
	TransitionManager.transition()
	await TransitionManager.transition_in_finished
	TransitionManager.transition_out()
	get_tree().root.add_child(menu)
	await menu.settings_menu_closed
	self.visible = true



func _on_start_pressed():
	# Load the main_scene from the save data
	pass


func _on_quit_pressed():
	get_tree().quit()
