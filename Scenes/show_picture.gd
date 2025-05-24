extends Button


func _on_pressed() -> void:
	%ScrambledPicture.visible = true
	Globals.can_move = false
