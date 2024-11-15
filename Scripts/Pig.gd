extends CharacterBody2D

enum states{
	IDLE,
	WALKING,
	ATTACK,
	DEAD
}

@onready var anim = $AnimatedSprite2D

@onready var raycast_l = $RayCastLeft
@onready var raycast_r = $RayCastRight

var hp = 3
const SPEED = 100.0

var direction := Vector2.RIGHT

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim.play("Idle")
	anim.animation_finished.connect(self._on_anim_ends)

func _physics_process(delta: float) -> void:
	if hp <= 0: return
	
	# гравитация
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Проверяем столкновение
	if is_on_wall() or not (raycast_l.is_colliding() || raycast_r.is_colliding()):
		# Меняем направление движения
		direction.x *= -1
		# Отражаем спрайт, чтобы он смотрел в нужную сторону
		scale.x *= -1
	
	velocity.x = direction.x * SPEED * delta
	# Двигаем врага
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
