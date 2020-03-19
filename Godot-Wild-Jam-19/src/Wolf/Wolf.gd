extends KinematicBody2D

var FleeState = "FleeState"
var IdleState = "IdleState"
var DeathState = "DeathState"
var WanderState = "WanderState"
var HuntState = "HuntState"

var is_alive = true
export var MAX_SPEED = 500
export var ACCELERATION = 1200
export var HEALTH = 60
export var DEBUG = true

var MAX_HUNGER = 100
var hunger_decay = -10
export var hunger = 100

enum ANGER_LEVELS {
	HAPPY = 80,
	HUNGERY = 60,
	AGGRESSIVE = 20,
}
var ANGER_VALUES =  {
	HURT = 20,
	SHOT_HEARD = 20,
	DETECTED_PREY = 30,
}

var flee_from = Vector2.ZERO
var hurt = false
var shot_heard = false
var detected_hunter = false
var is_aggresive = false
var current_state

func _ready():
	pass
	
func _physics_process(delta):
	pass
	
func shot_heard(pos):
	$StateMachine/HeardShotTimer.start()
	shot_heard = true
	flee_from = pos
	
func die():
	if DEBUG:
		print("Wolf: died")
	$StateMachine.change_to(DeathState)
	is_alive = false
	pass
	
func hit(dmg):
	if !hurt:
		hurt = true
	if DEBUG:
		print("Wolf: Hit!")
	# Play SFX
	
	HEALTH -= dmg
	if HEALTH <= 0:
		die()
		return
	
	# Play hit SFX
	
	# Run!
	if $StateMachine.state.name != FleeState:
		$StateMachine.change_to(FleeState)
	pass

func calculate_anger_level():
	pass

func _on_DetectionArea_body_entered(body):
	if body.name == "Hunter":
		detected_hunter = true
		if DEBUG:
			print("Wolf: Detected " + body.name)

func _on_DetectionArea_body_exited(body):
	if body.name == "Hunter":
		detected_hunter = false

func _on_AggressionArea_body_entered(body):
	if DEBUG:
		print("Wolf: Detected " + body.get_name())
		print("Wolf: Is getting aggressive")
	is_aggresive = true
	pass 

func _on_AggressionArea_body_exited(body):
	if DEBUG:
		print("Wolf: Is relaxing")
	is_aggresive = true
	pass 

func _on_HeardShotTimer_timeout():
	shot_heard = false
