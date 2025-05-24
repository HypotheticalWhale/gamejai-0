extends Control

@onready var dialog = get_tree().current_scene.get_node("CanvasLayer/Dialog")

func _ready() -> void:
	Globals.corridor_count += 1
	
	# first time in corridor
	if Globals.corridor_count == 1:
		dialog.visible = true
		dialog.text = Globals.dialog_data["CORRIDOR DIALOGUE (NECESSARY, TO SET SCENE FOR TIER 2)"]
		await get_tree().create_timer(6).timeout
		dialog.visible = false
	
	# first time entering corridor after solving something
	if (!Globals.is_picture_unscrambled and !Globals.is_phone_solved) and Globals.corridor_count > 3:
		dialog.visible = true
		dialog.text = Globals.dialog_data["CORRIDOR DIALOGUE (UPON ENTERING CORRIDOR FOR SECOND TIME, CALL INCOMPLETE– HINT!)"]
		await get_tree().create_timer(6).timeout
		dialog.visible = false
		
	# havent solved picture
	if (!Globals.is_picture_unscrambled and Globals.is_phone_solved) and Globals.corridor_count > 3:
		dialog.visible = true
		dialog.text = Globals.dialog_data["CORRIDOR DIALOGUE (UPON ENTERING CORRIDOR FOR SECOND TIME, CALL INCOMPLETE– HINT!)"]
		await get_tree().create_timer(6).timeout
		dialog.visible = false

	# havent solved phone for 2 rounds
	if (Globals.is_picture_unscrambled and !Globals.is_phone_solved) and Globals.corridor_count > 3:
		dialog.visible = true
		dialog.text = Globals.dialog_data["CORRIDOR DIALOGUE (UPON ENTERING CORRIDOR FOR SECOND TIME, PICTURE INCOMPLETE– HINT!)"]
		await get_tree().create_timer(6).timeout
		dialog.visible = false

	dialog.visible = true
	dialog.text = Globals.dialog_data["CORRIDOR DIALOGUE (UPON ENTERING CORRIDOR FOR SECOND TIME, CALL INCOMPLETE– HINT!)"]
	await get_tree().create_timer(6).timeout
	dialog.visible = false
