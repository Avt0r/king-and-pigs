extends Node

var camera
var map 

func _ready() -> void:
	_load_map(1)

func _load_map(num:int):
	
	add_child(load("res://Scenes/Levels/LevelMap-"+str(num)+".tscn").instantiate())
	
	map = $TileMap
	
	camera = Camera2D.new()
	add_child(camera)
	camera.zoom.x = 1.5
	camera.zoom.y = 1.5
