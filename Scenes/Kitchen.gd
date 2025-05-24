extends Control

const INPUTS_PER_SET := 3
const TOTAL_SETS := 3

var input_sets := []
var current_input_set := []
var current_set_index := 0
var input_cooldown := 1  # seconds to wait between sets

@onready var possible_buttons = [
	%Button0, %Button1, %Button2,
	%Button3, %Button4, %Button5,
	%Button6, %Button7, %Button8,
	%Button9, %ButtonHash, %ButtonPound
]


func _on_button_pressed(button_name: String) -> void:	
	if current_set_index >= TOTAL_SETS:
		return  # Stop accepting input

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
			%Put.set_deferred("disabled", false)
			
			# Optionally disable permanently or do something else
			
func _set_buttons_enabled():
	for button in possible_buttons:
		button.set_deferred("disabled", false)

func _set_buttons_disabled():
	for button in possible_buttons:
		button.set_deferred("disabled", true)
		
func _ready() -> void:
	for button in possible_buttons:
		button.connect("pressed", _on_button_pressed.bind(button.text))
	_set_buttons_disabled()

func _on_pick_pressed() -> void:
	_set_buttons_enabled()
	%Pick.set_deferred("disabled", true)

func _on_put_pressed() -> void:
	current_input_set = []
	current_set_index = 0
	%Put.set_deferred("disabled", true)
	%Pick.set_deferred("disabled", false	)
	
