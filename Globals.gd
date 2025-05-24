extends Node

var location_map = {
	Vector2(0,0) : {"scene": "res://Scenes/LivingRoom.tscn", "texture": "res://Screens/Screen.png"},
	Vector2(0,1) : {"scene": "res://Scenes/Kitchen.tscn", "texture": "res://Screens/Screen1.png"},
	Vector2(0,2) : {"scene": "res://Scenes/Study.tscn", "texture": "res://Screens/Screen2.png"},
	Vector2(0,3) : {"scene": "res://Scenes/Bedroom.tscn", "texture": "res://Screens/Screen2.png"},
}

var fear = 0
var base_fear = 0
