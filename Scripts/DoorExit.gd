extends AnimatedSprite2D

func _ready() -> void:
	play("Idle")

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		DataManager._level_complete()
		play("Opening")
		body._on_out(self)
