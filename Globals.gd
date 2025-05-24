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
var is_phone_solved = false
var corridor_count = 0
var tier_4_corridor_count = 0
var tier_4_activated = false
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

# start dialog variables
var dialog_data = {
	"BEGINNING": "I need to move forward.",
	"UPON REACHING BEDROOM": "There’s nowhere to go from here.", 
	"AFTER 30 SECONDS OF BEING IN BEDROOM": "There has to be something I can do…",
	"AFTER OPENING CLOSET":" A secret door… I wonder how long this has been here. ",
	"CORRIDOR DIALOGUE (NECESSARY, TO SET SCENE FOR TIER 2)":" Is it really alright to keep moving forward? I don’t know if I have the right. ",
	"CORRIDOR DIALOGUE (NECESSARY, TO SET SCENE FOR TIER 3)":" There has to be an end to all this. There has to be something I can do to move on.",
	"CORRIDOR DIALOGUE (UPON ENTERING CORRIDOR FOR SECOND TIME, PICTURE INCOMPLETE– HINT!)":" I can’t seem to remember her face… I wish I could see a picture. ",
	"CORRIDOR DIALOGUE (UPON ENTERING CORRIDOR FOR SECOND TIME, CALL INCOMPLETE– HINT!)":" I wish I could hear her voice… then I’d know what to do. ",
	"COMPLETION OF PUZZLE":" That’s what she looked like… we look happy. ",
	"PHONE DIALOGUE 1": "You’ve reached: GLADWELL HOSPITAL. If you have a grievous injury, press 1. If you have medical queries, press 2. If you’d like to make an appointment, press 3. (That’s not it.) ",
	"PHONE DIALOGUE 2":" BZZT. BZZT. LOW, GROWLING SOUNDS. ",
	"PHONE DIALOGUE 3":" BZZT. BZZT. SOBBING, DISTANT. ",
	"PHONE DIALOGUE 4":" (Man’s voice, angry.) Hello? Who is this? Hello? I know you’re there. I don’t ever want you calling this number again, you understand? ",
	"PHONE DIALOGUE 5":" Breathing sounds. Phone hangs up. ",
	"PHONE DIALOGUE 6 (CORRECT) ":" (Woman’s Voice) Hello? Hey, you. It’s good to hear your voice. I’ve got something very important to tell you. (pause) (laughter, clear and bright). Did you think it was really me? (Laughter). Thanks for calling. Leave a message or something. Bye!",
	"CORRIDOR DIALOGUE (NECESSARY, TO SET SCENE FOR TIER 4)": "I don’t know if I want to, but I’m starting to remember. ",
	"DIALOGUE 1 (TRIGGERED BY ENTERING CORRIDOR SECOND TIME)": "How many years did we spend here? How many times did we walk through these rooms? I cannot stop moving forward. I am a stone thrown, arrow fired, a promise set in some distant future.",
	"DIALOGUE 2 (TRIGGERED BY ENTERING CORRIDOR THIRD TIME)":"Is it fair? Is there a world in which I hold her in my arms again, born anew, a slate wiped clean, to meet as if we’d never met, would we play out this same, tragic myth?",
	"DIALOGUE 3 (TRIGGERED BY ENTERING CORRIDOR FOURTH TIME)": "There is no justice, not for something like me. There is no world in which I am allowed to hold. Unborn, filth, to never meet because we had to meet. I know how it ends. I know how it all ends.",
	"UPON ENTERING BEDROOM FOR THE LAST TIME, CORRIDOR LOCKED": "There’s nothing left. There’s nowhere left to go. I know how it ends. I know how it all ends.",
	"FINAL DIALOGUE (UPON TURNING BACK)": "I’m sorry. I’m sorry. I’m sorry. I’m sorry. I’m sorry. I’m sorry."
}
# end dialog variables
