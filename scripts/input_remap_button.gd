class_name InputRemapButton extends Button

@export var action: String
@export var action_event_index: int = 0

var mouse_input = false

const CONTROLLER_LABELS: Dictionary = {
	JoyButton.JOY_BUTTON_A: "A",
	JoyButton.JOY_BUTTON_B: "B",
	JoyButton.JOY_BUTTON_X: "X",
	JoyButton.JOY_BUTTON_Y: "Y",
	JoyButton.JOY_BUTTON_LEFT_SHOULDER: "LB",
	JoyButton.JOY_BUTTON_RIGHT_SHOULDER: "RB",
	JoyButton.JOY_BUTTON_LEFT_STICK: "L3",
	JoyButton.JOY_BUTTON_RIGHT_STICK: "R3",
	JoyButton.JOY_BUTTON_DPAD_UP: "↑",
	JoyButton.JOY_BUTTON_DPAD_DOWN: "↓",
	JoyButton.JOY_BUTTON_DPAD_RIGHT: "←",
	JoyButton.JOY_BUTTON_DPAD_LEFT: "→",
	JoyButton.JOY_BUTTON_START: "Start",
	JoyButton.JOY_BUTTON_GUIDE: "Select",
}

func _ready():
	toggle_mode = true
	update_text()

func _toggled(toggled_on: bool):
	print(toggled_on)
	if !action or !InputMap.has_action(action):
		return;
	
	if toggled_on:
		text = "Awaiting Input!"
		return;
	
	if action_event_index >= InputMap.action_get_events(action).size():
		text = "Unassigned!"
		return;
	
	
	var input = InputMap.action_get_events(action)[action_event_index]
	if input is InputEventMouseButton: return;
	if input is InputEventJoypadButton:
		if CONTROLLER_LABELS.has(input.button_index):
			text = CONTROLLER_LABELS[input.button_index]
		else:
			text = "Button " + str(input.button_index)
	elif InputEventKey:
		if input.physical_keycode != 0:
			text = OS.get_keycode_string(input.physical_keycode)
		else:
			text = OS.get_keycode_string(input.keycode)
	
func _unhandled_input(event: InputEvent) -> void:	
	if !InputMap.has_action(action) or !is_pressed():
		return;
	if event.is_pressed() and (event is InputEventKey or event is InputEventJoypadButton):
		map_input_event(event)
		button_pressed = false
		release_focus()

func update_text():
	if InputMap.has_action(action):
		var events : Array[InputEvent] = InputMap.action_get_events(action)
		var input := events[0]

		if input is InputEventJoypadButton:
			if CONTROLLER_LABELS.has(input.button_index):
				text = CONTROLLER_LABELS[input.button_index]
			else:
				text = "Button " + str(input.button_index)
		elif InputEventKey:
			if input.physical_keycode != 0:
				text = OS.get_keycode_string(input.physical_keycode)
			else:
				text = OS.get_keycode_string(input.keycode)
			if text == "W": text = "Z"
			elif text == "Z": text = "W"
			elif text == "Q": text = "A"
			elif text == "A": text = "Q"
			
func map_input_event(event):
	var action_events_list = InputMap.action_get_events(action)
	if action_event_index < action_events_list.size():
		InputMap.action_erase_event(action, action_events_list[action_event_index])
	InputMap.action_add_event(action, event)
	action_event_index = InputMap.action_get_events(action).size()-1
	

func _input(event: InputEvent):
	if event is InputEventMouseButton and is_pressed():
		const mouse_text = ["???", "Left Mouse", "Right Mouse", "Mouse Wheel", "Mouse Wheel Up", "Mouse Wheel Down"]
		if event.button_index >= mouse_text.size(): return;
		text = mouse_text[event.button_index]
		map_input_event(event)
		await get_tree().create_timer(0.1).timeout
		button_pressed = false
		release_focus()
