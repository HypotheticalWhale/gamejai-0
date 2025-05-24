extends Node

var location_map = {
	Vector2(0,0) : {"scene": "res://Scenes/Livingroom.tscn", "texture": "res://Screens/Screen.png"},
	Vector2(0,1) : {"scene": "res://Scenes/Kitchen.tscn", "texture": "res://Screens/Screen1.png"},
	Vector2(0,2) : {"scene": "res://Scenes/MidCorridor.tscn", "texture": "res://Screens/Screen2.png"},
	Vector2(0,3) : {"scene": "res://Scenes/Study.tscn", "texture": "res://Screens/Screen2.png"},
	Vector2(0,4) : {"scene": "res://Scenes/Bedroom.tscn", "texture": "res://Screens/Screen2.png"},
	Vector2(0,5) : {"scene": "res://Scenes/Corridor.tscn", "texture": "res://Screens/Screen2.png"},
}

var fear = 0
var base_fear = 0
var is_phone_solved = true
var corridor_count = 0
# start unscramble picture variables
var picture_coord2id = {
	Vector2(0,0): 0,
	Vector2(1,0): 1,
	Vector2(2,0): 2,
	Vector2(0,1): 3,
	Vector2(1,1): 4,
	Vector2(2,1): 5,
	Vector2(0,2): 6,
	Vector2(1,2): 8,
	Vector2(2,2): 7,
}

var picture_id2coord = {}

var gap_id: int = 8
var tile_length = 128
var num_rows = 3
var picture_global_position = Vector2(480, 240)
var is_picture_unscrambled = false
# end unscramble picture variables
