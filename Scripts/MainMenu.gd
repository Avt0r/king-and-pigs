extends Node2D

@onready var window_welcome = $CanvasLayer/MenuWelcome
@onready var window_choose_level = $CanvasLayer/MenuChooseLevel

var levels = {}

func _ready() -> void:
	window_welcome.show()
	window_choose_level.hide()
	
	DataManager._load()
	
	levels = $CanvasLayer/MenuChooseLevel/GridContainer.get_children()
	
	if DataManager.last_completed_level <= 0:
		levels[0].disabled = false
	else:
		for i in DataManager.last_completed_level:
			levels[i].disabled = false
	
	for l in levels.size()-1:
		levels[l].get_child(0).text = str(DataManager.diamonds_collected[l])+"/"+str(DataManager.diamonds_all[l])

func _on_control_gui_input(_event: InputEvent) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		window_welcome.hide()
		window_choose_level.show()

func _on_button_lvl_pressed(extra_arg_0: int) -> void:
	LevelManager.current_level_number = extra_arg_0
	get_tree().change_scene_to_file("res://Scenes/Level.tscn")
