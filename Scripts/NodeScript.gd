extends Node

# Экземпляр класса WebBus
var web_bus = null

func _ready():
	# Загружаем ассет WebBus
	web_bus = $"/root/WebBus"
	
	# Устанавливаем обработчики событий
	web_bus.connect("connected", self, "_on_connected")
	web_bus.connect("disconnected", self, "_on_disconnected")
	web_bus.connect("error", self, "_on_error")
	web_bus.connect("received_message", self, "_on_received_message")
	
	# Подключаемся к серверу
	web_bus.start_connection("ws://localhost:8080/")

# Обработчик успешного подключения
func _on_connected():
	print("Подключились к серверу!")

# Обработчик отключения
func _on_disconnected():
	print("Отключены от сервера.")

# Обработчик ошибки
func _on_error(error):
	print("Ошибка: ", error)

# Обработчик получения сообщения от сервера
func _on_received_message(data):
	var json_parser = JSON.new()
	var json_result = json_parser.parse(data)
	var json_data
	
	if json_result.error == OK:
		json_data = json_result.result
		print("Получили сообщение: ", json_data["type"], ": ", json_data["message"])
	else:
		printerr("Не удалось распарсить данные: ", data)
	
	if json_data != null:
		print("Получили сообщение: ", json_data["type"], ": ", json_data["message"])
	else:
		printerr("Не удалось распарсить данные: ", data)

# Функция отправки сообщения на сервер
func send_message(type, message):
	var data = {"type": type, "message": message}
	web_bus.send_message(data.to_json())
