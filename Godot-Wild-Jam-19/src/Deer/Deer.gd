extends KinematicBody2D

var FleeState = "FleeState"
var IdleState = "IdleState"
var DeathState = "DeathState"
var is_alive = true
export var MAX_SPEED = 500
export var ACCELERATION = 1200
export var HEALTH = 40
export var DEBUG = true

var flee_from = Vector2.ZERO
var shot_heard = false
var detected_hunter = false
var is_uncomfortable = false
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
		print("Dear: died")
	$StateMachine.change_to(DeathState)
	is_alive = false
	pass
	
func hit(dmg):
	if DEBUG:
		print("Deer: Hit!")
	# Play SFX
	
	HEALTH -= dmg
	if HEALTH <= 0:
		die()
		return
	
	# Play hit SFX
	
	# Run!
	if $StateMachine.state.name != "FleeState":
		$StateMachine.change_to("FleeState")
	pass

func _on_DetectionArea_body_entered(body):
	if DEBUG:
		print("Deer: Detected " + body.name)
	if body.name == "Hunter":
		detected_hunter = true

func _on_DetectionArea_body_exited(body):
	if body.name == "Hunter":
		detected_hunter = false

func _on_ComfortArea_body_entered(body):
	if DEBUG:
		print("Deer: Is getting uncomfortable")
		print("Deer: Detected " + body.get_name())
	is_uncomfortable = false
	pass 

func _on_ComfortArea_body_exited(body):
	if DEBUG:
		print("Deer: Is relaxing")
	is_uncomfortable = false
	pass 
