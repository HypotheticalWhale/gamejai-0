extends Node2D

@onready var dialog = get_tree().current_scene.get_node("Dialog")

func _ready() -> void:
	dialog.visible = true
	dialog.text = Globals.dialog_data["FINAL DIALOGUE (UPON TURNING BACK)"]
	await get_tree().create_timer(9).timeout
	dialog.visible = false
