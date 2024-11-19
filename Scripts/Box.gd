extends StaticBody2D

@onready var anim = $AnimatedSprite2D
@onready var collision = $CollisionShape2D

func _ready() -> void:
	add_to_group("Destroyable")
	anim.animation_finished.connect(self._on_anim_finished)
	anim.play("Idle")

func _on_anim_finished():
	if anim.animation == "Hit":
		anim.play("Broken")
		collision.queue_free()

func _on_hit():
	anim.play("Hit")
