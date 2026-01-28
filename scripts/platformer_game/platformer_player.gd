class_name PlatformerPlayer extends CharacterBody2D
@export var move_speed := 300.0
@export var gravity := 980.0
@export var jump_power := 600.0
@export var coyote_jump_time := 0.3
var coyote_time := 0.0

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Space") and is_coyote_floored():
		velocity.y -= jump_power
		coyote_time = 0.0
		
	
func _process(delta: float) -> void:
	if Input.is_action_pressed("Left"):
		position.x -= delta * move_speed
	if Input.is_action_pressed("Right"):
		position.x += delta * move_speed
		

func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	move_and_slide()
	
	if is_on_floor(): coyote_time = coyote_jump_time
	else: coyote_time -= delta

func is_coyote_floored():
	return coyote_time > 0.0
