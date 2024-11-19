extends Node2D

@onready var window_welcome = $CanvasLayer/MenuWelcome
@onready var window_choose_level = $CanvasLayer/MenuChooseLevel

func _ready() -> void:
	window_welcome.show()
	window_choose_level.hide()

func _on_control_gui_input(_event: InputEvent) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		window_welcome.hide()
		window_choose_level.show()

func _on_button_lvl_pressed(extra_arg_0: int) -> void:
	LevelManager.current_level_number = extra_arg_0
	get_tree().change_scene_to_file("res://Scenes/Level.tscn")
