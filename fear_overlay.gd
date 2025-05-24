extends TextureRect

func _process(delta: float) -> void:
	var fear_tier = round(Globals.fear/10)
	if fear_tier > 1 and fear_tier < 10:
		%FearOverlay.texture = load("res://Assets/FearOverlay/" + str(int(fear_tier)) + ".png")
		print(%FearOverlay.texture)
