extends CharacterBody2D

const SPEED = 100.0
const JUMP_VELOCITY = -350.0

@onready var anim = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and (is_on_floor() || is_on_wall()):
		velocity.y = JUMP_VELOCITY
		
		if is_on_wall() && !is_on_floor():
			if Input.is_action_pressed("Left"): 
				velocity.x = (JUMP_VELOCITY / 2.1)
			elif Input.is_action_pressed("Right"):
				velocity.x = -(JUMP_VELOCITY / 2.1)

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if velocity.y >= 0:
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if !direction:
		anim.play("Idle")
	elif direction && is_on_floor_only():
		anim.play("Run")
	elif velocity.y > 0:
		anim.play("Jump")
	elif velocity.y < 0:
		anim.play("Fall")
	

	if Input.is_action_pressed("Right"):
		anim.flip_h = true
		anim.offset.x = -15
	elif Input.is_action_pressed("Left"):
		anim.flip_h = false
		anim.offset.x = 0
	
	move_and_slide()
