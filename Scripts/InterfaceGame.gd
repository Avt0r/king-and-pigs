extends Control

@onready var hearts = [
	$Container/LiveBar/Heart1,
	$Container/LiveBar/Heart2,
	$Container/LiveBar/Heart3
]

@onready var numbers = [
	$Container/Diamond/Number1,
	$Container/Diamond/Number2
]

var lives_now = 3

func _ready() -> void:
	hearts[0].play("Idle")
	hearts[1].play("Idle")
	hearts[2].play("Idle")
	
	for h in hearts:
		h.animation_finished.connect(self._on_heart_anim_finished)

func _set_diamonds_count(count):
	if count / 10 - 1 < 0: 
		numbers[0].frame = 9
	else:
		numbers[0].frame = count / 10 - 1
	if count % 10 - 1 < 0:
		numbers[1].frame = 9
	else:
		numbers[1].frame = count % 10 - 1
	

func _on_heart_anim_finished():
	if hearts[lives_now].animation == "Hit":
		hearts[lives_now].hide()

func _heal():
	lives_now += 1
	hearts[lives_now-1].show()
	hearts[lives_now-1].play("Idle")

func _hit():
	hearts[lives_now-1].play("Hit")
	lives_now -= 1
