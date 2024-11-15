extends Control

@onready var window_game = $GameProcess
@onready var window_menu = $Menu
@onready var window_dead = $Dead

@onready var hearts = [
	$GameProcess/LiveBar/Heart1,
	$GameProcess/LiveBar/Heart2,
	$GameProcess/LiveBar/Heart3
]

@onready var numbers = [
	$GameProcess/Diamond/Number1,
	$GameProcess/Diamond/Number2
]

var lives_now = 3

func _ready() -> void:
	hearts[0].play("Idle")
	hearts[1].play("Idle")
	hearts[2].play("Idle")
	
	for h in hearts:
		h.animation_finished.connect(self._on_heart_anim_finished)
	
	window_game.show()
	window_menu.hide()
	window_dead.hide()

func _set_diamonds_count(count):
	if count / 10 - 1 < 0: 
		numbers[0].frame = 9
	else:
		numbers[0].frame = count / 10 - 1
	if count % 10 - 1 < 0:
		numbers[1].frame = 9
	else:
		numbers[1].frame = count % 10 - 1
	

func _on_heart_anim_finished():
	if hearts[lives_now].animation == "Hit":
		hearts[lives_now].hide()

func _heal():
	lives_now += 1
	hearts[lives_now-1].show()
	hearts[lives_now-1].play("Idle")

func _hit():
	hearts[lives_now-1].play("Hit")
	lives_now -= 1

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_pressed("Menu"):
		if !window_menu.visible:
			window_menu.show()
			get_tree().paused = true
		else:
			window_menu.hide()
			get_tree().paused = false

func _on_resume_pressed() -> void:
	window_menu.hide()
	get_tree().paused = false

func _to_main_menu() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")

func _on_dead():
	window_dead.show()
	get_tree().paused = true

func _on_reload_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
