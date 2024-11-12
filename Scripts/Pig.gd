extends CharacterBody2D

enum states{
	IDLE,
	WALKING,
	ATTACK,
	DEAD
}

@onready var anim = $AnimatedSprite2D

var hp = 3
const SPEED = 100.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim.play("Idle")
	anim.animation_finished.connect(self._on_anim_ends)

func _physics_process(delta: float) -> void:
	if hp <= 0: return
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	#var collision = move_and_collide(direction * speed * delta)
	#if collision:
		#direction *= -1
		
	move_and_slide()

func _on_hit():
	if hp <= 0: return
	anim.play("Hit")
	hp -= 1

func _on_anim_ends():
	if anim.animation == "Hit":
		if hp > 0:
			anim.play("Idle")
		else:
			anim.play("Dead")
			$CollisionShape2D.queue_free()
