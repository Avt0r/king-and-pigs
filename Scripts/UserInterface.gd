extends Control

@onready var diamondsLabel = $DiamondsCount

func _set_diamonds_count(count:int):
	diamondsLabel.text = str(count)
