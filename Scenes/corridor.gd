extends Control

@onready var dialog = get_tree().current_scene.get_node("CanvasLayer/Dialog")

func _ready() -> void:
	Globals.corridor_count += 1
	if Globals.tier_4_activated:
		Globals.tier_4_corridor_count += 1
		
	print("t4corr: ", Globals.tier_4_corridor_count)
	
	# first time in corridor
	if Globals.corridor_count == 1:
		dialog.visible = true
		dialog.text = Globals.dialog_data["CORRIDOR DIALOGUE (NECESSARY, TO SET SCENE FOR TIER 2)"]
		await get_tree().create_timer(6).timeout
		dialog.visible = false
		return
	
	# didnt solve anything
	if (!Globals.is_picture_unscrambled and !Globals.is_phone_solved):
		dialog.visible = true
		dialog.text = Globals.dialog_data["CORRIDOR DIALOGUE (UPON ENTERING CORRIDOR FOR SECOND TIME, CALL INCOMPLETE– HINT!)"]
		await get_tree().create_timer(6).timeout
		dialog.visible = false
		return
		
	# havent solved picture
	if (!Globals.is_picture_unscrambled and Globals.is_phone_solved):
		dialog.visible = true
		dialog.text = Globals.dialog_data["CORRIDOR DIALOGUE (NECESSARY, TO SET SCENE FOR TIER 3)"]
		await get_tree().create_timer(6).timeout
		dialog.visible = false
		
		await get_tree().create_timer(3).timeout
		
		dialog.visible = true
		dialog.text = Globals.dialog_data["CORRIDOR DIALOGUE (UPON ENTERING CORRIDOR FOR SECOND TIME, CALL INCOMPLETE– HINT!)"]
		await get_tree().create_timer(6).timeout
		dialog.visible = false
		return

	# havent solved phone
	if (Globals.is_picture_unscrambled and !Globals.is_phone_solved):
		dialog.visible = true
		dialog.text = Globals.dialog_data["CORRIDOR DIALOGUE (NECESSARY, TO SET SCENE FOR TIER 3)"]
		await get_tree().create_timer(6).timeout
		dialog.visible = false
		
		await get_tree().create_timer(3).timeout
		
		dialog.visible = true
		dialog.text = Globals.dialog_data["CORRIDOR DIALOGUE (UPON ENTERING CORRIDOR FOR SECOND TIME, PICTURE INCOMPLETE– HINT!)"]
		await get_tree().create_timer(6).timeout
		dialog.visible = false
		return

	# solved both, enter tier 4
	if (Globals.is_picture_unscrambled and Globals.is_phone_solved):
		dialog.visible = true
		dialog.text = Globals.dialog_data["CORRIDOR DIALOGUE (NECESSARY, TO SET SCENE FOR TIER 4)"]
		await get_tree().create_timer(6).timeout
		dialog.visible = false
		Globals.tier_4_activated = true
		return
	
		# solved both, enter tier 4
	if (Globals.is_picture_unscrambled and Globals.is_phone_solved and Globals.tier_4_corridor_count == 0):
		dialog.visible = true
		dialog.text = Globals.dialog_data["CORRIDOR DIALOGUE (NECESSARY, TO SET SCENE FOR TIER 4)"]
		await get_tree().create_timer(6).timeout
		dialog.visible = false
		Globals.tier_4_activated = true
		return
	
	# tier 4 first loop
	if Globals.tier_4_corridor_count == 1:
		dialog.visible = true
		dialog.text = Globals.dialog_data["DIALOGUE 1 (TRIGGERED BY ENTERING CORRIDOR SECOND TIME)"]
		await get_tree().create_timer(6).timeout
		dialog.visible = false
		return

	# tier 4 second loop
	if Globals.tier_4_corridor_count == 2:
		dialog.visible = true
		dialog.text = Globals.dialog_data["DIALOGUE 2 (TRIGGERED BY ENTERING CORRIDOR THIRD TIME)"]
		await get_tree().create_timer(6).timeout
		dialog.visible = false
		return

	# tier 4 third loop
	if Globals.tier_4_corridor_count == 3:
		dialog.visible = true
		dialog.text = Globals.dialog_data["DIALOGUE 3 (TRIGGERED BY ENTERING CORRIDOR FOURTH TIME)"]
		await get_tree().create_timer(6).timeout
		dialog.visible = false
		return
