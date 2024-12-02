extends Node2D

@onready var window_welcome = $CanvasLayer/MenuWelcome
@onready var window_choose_level = $CanvasLayer/MenuChooseLevel

var levels = {}

func _ready() -> void:
	window_welcome.show()
	window_choose_level.hide()
	
	#Global.Data._wipe()
	
	Global.Data._load()
	
	levels = $CanvasLayer/MenuChooseLevel/GridContainer.get_children()
	
	if Global.Data.last_completed_level <= 0:
		levels[0].disabled = false
	else:
		for i in Global.Data.last_completed_level:
			levels[i].disabled = false
			
			if i == Global.Data.levels_count - 1: break
			
			levels[i+1].disabled = false
	
	for l in levels.size():
		levels[l].get_child(0).text = str(Global.Data.diamonds_collected[l])+"/"+str(Global.Data.diamonds_all[l])

func _on_control_gui_input(_event: InputEvent) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		window_welcome.hide()
		window_choose_level.show()

func _on_button_lvl_pressed(extra_arg_0: int) -> void:
	LevelManager.current_level_number = extra_arg_0
	get_tree().change_scene_to_file("res://Scenes/Level.tscn")
