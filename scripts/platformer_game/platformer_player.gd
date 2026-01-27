class_name PlatformerPlayer extends CharacterBody2D
@export var move_speed := 300.0
@export var gravity := 500.0
@export var jump_power := 300.0

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Space"):
		velocity.y -= jump_power

func _process(delta: float) -> void:
	if Input.is_action_pressed("Left"):
		position.x -= delta * move_speed
	if Input.is_action_pressed("Right"):
		position.x += delta * move_speed

func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	move_and_slide()
