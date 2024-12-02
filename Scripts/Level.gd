extends Node

@onready var interface = $CanvasLayer/Interface
var map 
var player

var diamonds = 0

func _ready() -> void:
	_load_map()
	LevelManager.current_level = self

func _load_map():
	var e = ResourceLoader.exists("res://Scenes/Levels/LevelMap-"+str(LevelManager.current_level_number)+".tscn")
	
	var m
	if e:
		m = load("res://Scenes/Levels/LevelMap-"+str(LevelManager.current_level_number)+".tscn")
	else:
		m = load("res://Scenes/Levels/LevelMap-1.tscn")
		LevelManager.current_level_number = 1
	
	add_child(m.instantiate())
	map = $TileMap
	player = map.get_node("Player")

func _receive_diamond():
	diamonds += 1
	interface._set_diamonds_count(diamonds)

func _next_level():
	LevelManager.current_level_number += 1
	get_tree().reload_current_scene()
