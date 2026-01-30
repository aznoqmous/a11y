class_name PlatformerPlayer extends CharacterBody2D
@export var move_speed := 300.0
@export var gravity := 980.0
@export var jump_power := 600.0
@export var coyote_jump_time := 0.3
var coyote_time := 0.0

@onready var sprite_2d: Sprite2D = $Sprite2D
var is_jumping = true

var access_auto_move_direction_multiplier = 1
var access_auto_move_direction = 0

@export var arrow_container: Node2D
func _ready() -> void:
	arrow_container.visible = false	

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Space") and is_coyote_floored():
		jump()
	if(GameManager.access_platformer_auto_move):
		if(event.is_action_pressed("Up")):
			change_direction()
		if(event.is_action_pressed("Down")):
			stop_direction()
			
func stop_direction():
	arrow_container.visible = false
	access_auto_move_direction = 0
	pass

func change_direction():
	arrow_container.visible = true
	access_auto_move_direction_multiplier *= -1
	print("Direction is ", "left" if access_auto_move_direction_multiplier == -1 else "right") 
	access_auto_move_direction = GameManager.access_platformer_auto_move_value * access_auto_move_direction_multiplier
	arrow_container.scale.x =  access_auto_move_direction_multiplier
	pass


func jump(strength:float = 1):
	var strengthValue = strength 
	if(GameManager.access_platformer_auto_move):
		strengthValue += clamp(1.0/GameManager.access_platformer_auto_move_value * 0.25,0.1,3)
	velocity.y -= jump_power * strengthValue
	coyote_time = 0.0
	
func _process(delta: float) -> void:
	GameManager.set_access_color(sprite_2d, GameManager.Colors.PLAYER)
	if Input.is_action_pressed("Left"):
		position.x -= delta * move_speed
	if Input.is_action_pressed("Right"):
		position.x += delta * move_speed
	if(GameManager.access_platformer_auto_move):
		position.x += delta * move_speed * access_auto_move_direction
		
	
func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	move_and_slide()
	
	if is_on_floor(): coyote_time = coyote_jump_time
	else: coyote_time -= delta

func is_coyote_floored():
	return coyote_time > 0.0
