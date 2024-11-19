extends Control

@onready var anim = $Door

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim.play("Idle")

func _on_mouse_entered():
	anim.play("Opening")
	
func _on_mouse_exited():
	anim.play("Closing")
