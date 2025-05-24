extends Control

const INPUTS_PER_SET := 3
const TOTAL_SETS := 3

var input_sets := []
var current_input_set := []
var current_set_index := 0
var input_cooldown := 1  # seconds to wait between sets
var correct_answer = [["9","7","2"],["1","2","3"],["6","8","9"]]
var can_stage = true
var sound_string = "WrongNumber"
@onready var dialog = get_tree().current_scene.get_node("CanvasLayer/Dialog")

@onready var dial_tone = %DialTone
@onready var possible_buttons = [
	%Button0, %Button1, %Button2,
	%Button3, %Button4, %Button5,
	%Button6, %Button7, %Button8,
	%Button9, %ButtonHash, %ButtonPound
]


func _on_button_pressed(button_name: String) -> void:	

	if current_set_index >= TOTAL_SETS:
		return  # Stop accepting input
	%PhoneButtonPress.play()
	await %PhoneButtonPress.finished
	current_input_set.append(button_name)
	if current_input_set.size() == INPUTS_PER_SET:
		input_sets.append(current_input_set.duplicate())
		current_input_set.clear()
		current_set_index += 1
		# Disable all buttons
		_set_buttons_disabled()
		if current_set_index < TOTAL_SETS:
			# Wait a short while before enabling again
			await get_tree().create_timer(input_cooldown).timeout
			_set_buttons_enabled()
		else:
			print("All inputs collected:", input_sets)
			if input_sets == correct_answer:
				dialog.visible = true
				dialog.text = Globals.dialog_data["PHONE DIALOGUE 6"]
				print("you got it")
				get_tree().paused = true
				dial_tone.play()
				await dial_tone.finished
				var wrong_number = get_node("WrongNumber7")
				wrong_number.play()
				await wrong_number.finished
				dial_tone.play()
				await dial_tone.finished
				dialog.visible = false
				get_tree().paused = false
				if can_stage:
					get_parent().stage -= 1
					can_stage = false
				Globals.is_phone_solved = true
			else:
				var aug_sound_string
				if get_correctness_matrix(input_sets) == [0,0,0]:
					aug_sound_string = sound_string + "1"
					dialog.visible = true
					dialog.text = Globals.dialog_data["PHONE DIALOGUE 1"]
				if get_correctness_matrix(input_sets) == [0,0,1]:
					aug_sound_string = sound_string + "2"
					dialog.visible = true
					dialog.text = Globals.dialog_data["PHONE DIALOGUE 2"]
				if get_correctness_matrix(input_sets) == [0,1,0]:
					aug_sound_string = sound_string + "3"
					dialog.visible = true
					dialog.text = Globals.dialog_data["PHONE DIALOGUE 3"]
				if get_correctness_matrix(input_sets) == [0,1,1]:
					aug_sound_string = sound_string + "4"
					dialog.visible = true
					dialog.text = Globals.dialog_data["PHONE DIALOGUE 4"]
				if get_correctness_matrix(input_sets) == [1,0,0]:
					aug_sound_string = sound_string + "5"
					dialog.visible = true
					dialog.text = Globals.dialog_data["PHONE DIALOGUE 5"]
				if get_correctness_matrix(input_sets) == [1,1,0]:
					aug_sound_string = sound_string + "6"
					dialog.visible = true
					dialog.text = Globals.dialog_data["PHONE DIALOGUE 6"]
				input_sets = []
				get_tree().paused = true
				dial_tone.play()
				await dial_tone.finished
				var wrong_number = get_node(aug_sound_string)
				wrong_number.play()
				await wrong_number.finished
				dial_tone.play()
				await dial_tone.finished
				dialog.visible = false
				get_tree().paused = false
				
			%Put.set_deferred("disabled", false)
			
			# Optionally disable permanently or do something else
func get_correctness_matrix(reference_array: Array) -> Array:
	var result: Array = []
	for i in range(correct_answer.size()):
		if i >= reference_array.size():
			break  # Avoid out-of-bounds
		if correct_answer[i] == reference_array[i]:
			result.append(1)
		else:
			result.append(0)
	return result

	
func _set_buttons_enabled():
	for button in possible_buttons:
		button.set_deferred("disabled", false)

func _set_buttons_disabled():
	for button in possible_buttons:
		button.set_deferred("disabled", true)
		
func _ready() -> void:
	if !get_parent().player_has_key:
		%Phone.visible = false
	if Globals.is_phone_solved:
		can_stage = false
	for button in possible_buttons:
		button.connect("pressed", _on_button_pressed.bind(button.text))
	_set_buttons_disabled()

func _on_pick_pressed() -> void:
	get_parent().get_node("Phone").play()
	_set_buttons_enabled()
	%Pick.set_deferred("disabled", true)

func _on_put_pressed() -> void:
	get_parent().get_node("Phone").play()
	current_input_set = []
	current_set_index = 0
	%Put.set_deferred("disabled", true)
	%Pick.set_deferred("disabled", false)
	
