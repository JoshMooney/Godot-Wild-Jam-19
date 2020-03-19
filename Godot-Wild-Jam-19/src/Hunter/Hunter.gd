extends KinematicBody2D

export var MAX_SPEED = 500
export var ACCELERATION = 1200
var motion = Vector2.ZERO
var axis = get_input_axis()

var MAX_HEALTH = 100
var MAX_STRENGTH = 100
var MAX_HUNGER = 100

var hunger_decay = -10
var strength_decay = -10
var step_counter = 0
var step_counter_limit = 60
var step_counter_decay = 0

export var health = 100
export var hunger = 100
export var strength = 100

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

func hit(dmg):
	health -= dmg
	if health <= 0:
		die()
		
func die():
	# Emit hunter death signal
	pass
	
func rest():
	# Play animation
	
	# Sleep while animation is playing
	health = MAX_HEALTH
	
	# Recover hunger
	strength = MAX_STRENGTH
	time_passes()
	
func eat():
	# Play animation
	
	# Sleep while animation is playing
	
	# Recover hunger
	hunger = MAX_HUNGER
	pass
	
func time_passes():
	# Decay the Hunger and Strength here
	
	pass

func poll_input():
	axis = get_input_axis()
	if Input.is_action_just_pressed("ui_select"):
		$ChatBubble.trigger($ChatBubble/Emote.EMOTE.HUNGERY)
	
	pass
	
func decay_strength(amount):
	strength += amount
	print("Hunter lost some strength, current value: " + str(strength))
	if strength <= 0:
		die()
		print("Hunter died from exhaustion")

func update_weapon():
	pass
	
func count_steps(delta):
	var step_value = 10
	step_counter += step_value * delta
	if step_counter > step_counter_limit:
		step_counter = 0
		print("Hunter step counter reset")
		decay_strength(strength_decay)
	pass

func update_movement(delta):
	if axis == Vector2.ZERO:
		apply_friction(ACCELERATION * delta)
	else:
		apply_movment(axis * ACCELERATION * delta)
		count_steps(delta)
	motion = move_and_slide(motion)
	
	pass
	
