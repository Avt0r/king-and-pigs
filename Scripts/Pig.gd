extends CharacterBody2D

@onready var anim = $AnimatedSprite2D

@onready var raycast = $Raycast

var hp = 1
const SPEED = 50.0

var direction := Vector2.RIGHT

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("Enemies")
	anim.play("Idle")
	anim.animation_finished.connect(self._on_anim_ends)

func _physics_process(delta: float) -> void:
	if hp <= 0: return
	
	# гравитация
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Проверяем столкновение или конец платформы
	if is_on_wall() or not raycast.is_colliding():
		# Меняем направление движения
		direction.x *= -1
		# Отражаем спрайт, чтобы он смотрел в нужную сторону
		scale.x *= -1
	
	velocity.x = direction.x * SPEED
	# Двигаем врага
	move_and_slide()

func _on_hit():
	if hp <= 0: return
	anim.play("Hit")
	hp -= 1

func _on_anim_ends():
	if anim.animation == "Dead":
		$CollisionShape2D.free()
		return
	
	if hp > 0:
		if velocity.x != 0:
			anim.play("Run")
		else:
			anim.play("Idle")
	else:
		anim.play("Dead")


func _on_body_entered(body: Node2D) -> void:
	if anim.animation == "Dead": return
	if body.name == "Player":
		body._on_hit()
