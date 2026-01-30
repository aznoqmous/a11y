@tool
extends Label

@export var action: String
@export var action_event_index: int = 0
var last_action : String

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
	update_text()

func _process(delta: float) -> void:
	update_text()
	
func update_text():
	if last_action == action: return;
	print(InputMap.has_action(action))
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
	print("UPDATE TEXT")
	last_action = action
