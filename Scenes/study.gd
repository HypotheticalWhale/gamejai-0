extends Control
@onready var dialog = get_tree().current_scene.get_node("CanvasLayer/Dialog")

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		dialog.visible = true
		dialog.text = Globals.dialog_data["CLUE 1"]
		

func _on_area_2d_2_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		dialog.visible = true
		dialog.text = Globals.dialog_data["CLUE 2"]
		


func _on_area_2d_3_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		dialog.visible = true
		dialog.text = Globals.dialog_data["CLUE 3"]
		
