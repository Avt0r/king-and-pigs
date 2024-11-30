extends Node

var levels_count = 5
var diamonds_all = [3,7,23,12,32]

var last_completed_level = 0
var diamonds_collected = [0,0,0,0,0]

# Загрузка сохранённых данных.
func _load():
	var save_file = FileAccess.open("user://savegame.save", FileAccess.READ)
	
	if save_file == null or not save_file.is_open():
		print("Ошибка при открытии файла")
		return
	
	# Получаем данные.
	last_completed_level = save_file.get_var(last_completed_level)
	
	for i in (diamonds_collected.size() - 1):
		diamonds_collected[i] = save_file.get_var(diamonds_collected[i])

# Фиксация завершения уровня и количество собранных алмазов.
func _level_complete() -> void:
	last_completed_level = max(last_completed_level, LevelManager.current_level_number)
	
	diamonds_collected[LevelManager.current_level_number-1] = max(LevelManager.current_level.diamonds,diamonds_collected[LevelManager.current_level_number]-1)
	save_game()

# Функция сохранения прогресса игры.
func save_game() -> void:
	var save_file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	
	if save_file == null or not save_file.is_open():
		print("Ошибка при сохранении файла")
		return
	
	save_file.store_var(last_completed_level)
	
	for i in (diamonds_collected.size() - 1):
		save_file.store_var(diamonds_collected[i])
	
	save_file.close()

func _wipe() -> void:
	DirAccess.remove_absolute("user://savegame.save")
