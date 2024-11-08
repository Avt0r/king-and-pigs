extends Control

@onready var anim = $Door

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim.play("Idle")
	mouse_entered.connect(self._on_mouse_entered)
	mouse_exited.connect(self._on_mouse_exited)


func _on_mouse_entered():
	anim.play("Opening")
	
func _on_mouse_exited():
	anim.play("Closing")

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_pressed("Lclick"):
		get_tree().change_scene_to_file("res://Scenes/Level.tscn")
