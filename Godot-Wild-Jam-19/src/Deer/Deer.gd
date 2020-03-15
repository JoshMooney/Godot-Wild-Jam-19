extends KinematicBody2D

var FleeState = "FleeState"
var IdleState = "IdleState"
export var MAX_SPEED = 500
export var ACCELERATION = 1200
export var HEALTH = 40

var shot_heard = false
var detected_hunter = false
var is_uncomfortable = false
var current_state

func _ready():
	#current_state = $StateMachine.state.name
	pass
	
func _physics_process(delta):
	pass
	
func shot_heard(pos):
	shot_heard = true
	
func die():
	pass
	
func hit(dmg):
	print("Deer: Hit!")
	# Play SFX
	
	HEALTH -= dmg
	if HEALTH >= 0:
		die()
	
	# Run!
	if $StateMachine.state.name != "FleeState":
		$StateMachine.change_to("FleeState")
	pass

func _on_DetectionArea_body_entered(body):
	print(body.name)
	if body.name == "Hunter":
		detected_hunter = true

func _on_DetectionArea_body_exited(body):
	if body.name == "Hunter":
		detected_hunter = false

func _on_ComfortArea_body_entered(body):
	print(body.get_name())
	
	print("Deer: Is getting uncomfortable")
	is_uncomfortable = true
	pass 

func _on_ComfortArea_body_exited(body):
	print("Deer: Is relaxing")
	is_uncomfortable = false
	pass 
