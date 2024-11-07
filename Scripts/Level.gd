extends Node

@onready var camera = $Camera2D
@onready var interface = $CanvasLayer/Interface
@onready var player = $Player

var map 

var diamonds = 0

func _ready() -> void:
	_load_map(1)
	LevelManager.current_level = self

func _load_map(num:int):
	
	add_child(load("res://Scenes/Levels/LevelMap-"+str(num)+".tscn").instantiate())
	
	map = $TileMap

func _receive_diamond():
	diamonds += 1
	interface._set_diamonds_count(diamonds)
