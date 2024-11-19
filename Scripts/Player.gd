extends CharacterBody2D

var hp = 3

const SPEED = 100.0
const JUMP_VELOCITY = -350.0

@onready var anim = $AnimationPlayer
@onready var sprite = $Sprite2D
@onready var attackArea = $Area2D

var alive = true
var out = false
var door_exit 

func _ready() -> void:
	anim.play("In")

func _physics_process(delta: float) -> void:
	if anim.current_animation == "In" or anim.current_animation == "Out": return
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	#двигаемся к двери
	if out:
		if position.x > door_exit.position.x + 1:
			velocity.x = - SPEED
		elif position.x < door_exit.position.x - 1:
			velocity.x = SPEED
		else:
			
			anim.play("Out")
	
	if !alive or out: 
		move_and_slide()
		return

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and (is_on_floor() || is_on_wall()):
		velocity.y = JUMP_VELOCITY
		
		if is_on_wall() && !is_on_floor():
			if Input.is_action_pressed("Left"): 
				velocity.x = -(JUMP_VELOCITY / 2.1)
			elif Input.is_action_pressed("Right"):
				velocity.x = (JUMP_VELOCITY / 2.1)

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("Left", "Right")
	if velocity.y >= 0:
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if Input.is_action_pressed("Attack"):
		anim.play("Attack")
	elif !direction:
		anim.play("Idle")
	elif direction && is_on_floor_only():
		anim.play("Run")
	elif velocity.y > 0:
		anim.play("Jump")
	elif velocity.y < 0:
		anim.play("Fall")

	if Input.is_action_pressed("Left"):
		sprite.flip_h = true
		sprite.offset.x = -15
		attackArea.position.x = -33
	elif Input.is_action_pressed("Right"):
		sprite.flip_h = false
		sprite.offset.x = 0
		attackArea.position.x = 0
	
	move_and_slide()

func _on_anim_finished():
	if anim.current_animation == "Dead":
		LevelManager.current_level.interface._on_dead()
	if anim.current_animation == "In":
		anim.play("Idle")

func _receive_diamond():
	LevelManager.current_level._receive_diamond()

func _on_deal_damage():
	for body in attackArea.get_overlapping_bodies():
		if body.is_in_group("Enemies") || body.is_in_group("Destroyable"):
			body._on_hit()

func _on_hit():
	if anim.current_animation == "In" or anim.current_animation == "Out" or anim.current_animation == "Dead": return
	
	if hp == 1:
		_on_dead()
		return
	
	hp -= 1
	LevelManager.current_level.interface._hit()
	anim.play("Hit")

func _on_heal():
	if anim.current_animation == "In" or anim.current_animation == "Out" or anim.current_animation == "Dead": return
	
	if hp == 3: return
	
	hp += 1
	LevelManager.current_level.interface._heal()

func _on_dead():
	alive = false
	LevelManager.current_level.interface._hit()
	anim.play("Dead")

func _on_out(door):
	out = true
	door_exit = door

func _next_level():
	LevelManager.current_level._next_level()
