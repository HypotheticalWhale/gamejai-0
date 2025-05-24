extends Node2D

var current_position = Vector2(0,0)
var current_room_string = "res://Scenes/Screen.tscn"
var current_room = null
var first_stage = true
var player_has_key = false
@onready var fear_timer: Timer = %FearTimer
@onready var footstep_cooldown = %FootstepCooldown
var stage: int = 3  # Start at Stage 1
var basefeat = {
	3 : 0,
	2 : 25,
	1 : 50
}

func move(direction:String):
	print(stage)
	var offset = get_vector(direction)
	var new_pos = current_position + offset
	# Wrap the position using mod 4
	new_pos.x = int(new_pos.x) % 6
	new_pos.y = int(new_pos.y) % 6
	
	if new_pos == Vector2(0,0):
		fear_timer.wait_time = stage
		Globals.fear = basefeat[stage]
		%FearMeter.value = basefeat[stage]
		
	if player_has_key:
		first_stage = false
		fear_timer.stop()
		fear_timer.start()
		
	if first_stage and new_pos == Vector2(0,5):
		print("No room here")
		return
	
	if Globals.location_map.has(new_pos):
		%FootSteps.play()
		footstep_cooldown.start()
		current_position = new_pos
		load_room()

func get_vector(direction:String):
	match direction:
		"north": return Vector2(0,1)
		#"south": Vector2(1,0)
		#"east": return Vector2(1,0)
		#"west": return Vector2(-1,0)
		_: return Vector2(0,0)
		
func load_room():
	if current_room:
		current_room.queue_free()
	var scene_to_load = Globals.location_map[current_position].scene
	var scene = load(scene_to_load).instantiate()
	add_child(scene)

func _on_fear_timer_timeout() -> void:
	Globals.fear += 1
	if Globals.fear >= 25:
		if not %Fear25.playing:
			%Fear25.play()
	if Globals.fear >= 50:
		if %Fear25.playing:
			%Fear25.stop()
		if not %Fear50.playing:
			%Fear50.play()
	if Globals.fear >= 75:
		if %Fear25.playing:
			%Fear25.stop()
		if %Fear50.playing:
			%Fear50.stop()
		if not %Fear75.playing:
			%Fear75.play()
		

func _ready() -> void:
	var scene_to_load = Globals.location_map[current_position].scene
	var scene = load(scene_to_load).instantiate()
	load_room()
	
	await get_tree().create_timer(2).timeout
	%Dialog.visible = true
	%Dialog.text = Globals.dialog_data["BEGINNING"]
	await get_tree().create_timer(3).timeout
	%Dialog.visible = false
	
	
func _process(delta: float) -> void:
	%FearMeter.value = Globals.fear
	if Input.is_action_just_pressed("ui_up") and footstep_cooldown.is_stopped():
		move("north")
