extends StaticBody2D

@onready var anim = $AnimatedSprite2D
@onready var area = $Area2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim.play("Idle")
	area.body_entered.connect(self._on_body_entered)
func _process(delta: float) -> void:
	
	pass

func _on_body_entered(body):
	body._receive_diamond()
	self.queue_free()
