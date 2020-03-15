extends KinematicBody2D

export var MAX_SPEED = 500
export var ACCELERATION = 1200
var motion = Vector2.ZERO
var axis = get_input_axis()

func _ready():
	pass

func _physics_process(delta):
	poll_input()
	update_movement(delta)
	update_weapon()
	pass

func get_input_axis():
	var axis = Vector2.ZERO
	axis.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	axis.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	return axis.normalized()
	
func apply_friction(amount):
	if motion.length() > amount:
		motion -= motion.normalized() * amount
	else:
		motion = Vector2.ZERO

func apply_movment(accelation):
	motion += accelation
	motion = motion.clamped(MAX_SPEED)

func poll_input():
	axis = get_input_axis()
	pass
	
func update_weapon():
	pass	

func update_movement(delta):
	if axis == Vector2.ZERO:
		apply_friction(ACCELERATION * delta)
	else:
		apply_movment(axis * ACCELERATION * delta)
	motion = move_and_slide(motion)
	
	pass
	
