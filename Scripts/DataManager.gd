extends Node

var last_completed_level = 0
var diamonds_collected = [0,0,0,0,0]

# Загрузка сохранённых данных.
func _load():
	var save_file = FileAccess.open("user://savegame.save", FileAccess.READ)
	
	if save_file == null or not save_file.is_open():
		print("Ошибка при открытии файла")
		return
	
	save_file.get_var(last_completed_level)
	#for i in last_completed_level - 2:
		#save_file.get_var(diamonds_collected[i + 1])

# Фиксация завершения уровня и количество собранных алмазов.
func _level_complete() -> void:
	last_completed_level = max(last_completed_level, LevelManager.current_level_number)
	#if LevelManager.current_level_number in diamonds_collected:
		#diamonds_collected[LevelManager.current_level_number] = max(LevelManager.current_level.diamonds,diamonds_collected[LevelManager.current_level_number])
	#else:
		#diamonds_collected[LevelManager.current_level_number] = LevelManager.current_level.diamonds
	save_game()

# Функция сохранения прогресса игры.
func save_game() -> void:
	var save_file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	
	if save_file == null or not save_file.is_open():
		print("Ошибка при сохранении файла")
		return
	
	save_file.store_var(last_completed_level)
	#for i in diamonds_collected.values():
		#save_file.store_var(i)
	
	#var data_to_save = {
		#"last_completed_level": last_completed_level,
		#"diamonds_collected": diamonds_collected
	#}
	#
	#var json_data = String(var_to_str(data_to_save))
	#
	#save_file.store_line(json_data)
	save_file.close()
