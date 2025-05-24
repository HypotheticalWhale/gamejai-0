extends Node2D

var current_position = Vector2(0,0)
var current_room_string = "res://Scenes/Screen.tscn"
var current_room = null
var first_stage = true
var player_has_key = true
@onready var fear_timer: Timer = %FearTimer
var stage: int = 1  # Start at Stage 1

func move(direction:String):
	Globals.fear = 0
	var offset = get_vector(direction)
	var new_pos = current_position + offset
	# Wrap the position using mod 4
	new_pos.x = int(new_pos.x) % 4
	new_pos.y = int(new_pos.y) % 4
	if player_has_key:
		first_stage = false
		fear_timer.stop()
		fear_timer.start()
	if first_stage and new_pos == Vector2(0,3):
		print("No room here")
		return
	
	if Globals.location_map.has(new_pos):
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

func _ready() -> void:
	var scene_to_load = Globals.location_map[current_position].scene
	var scene = load(scene_to_load).instantiate()
	load_room()
	
func _process(delta: float) -> void:
	%FearMeter.value = Globals.fear
	if Input.is_action_just_pressed("ui_up"):
		move("north")

func _on_fear_timer_timeout() -> void:
	Globals.fear += 1
