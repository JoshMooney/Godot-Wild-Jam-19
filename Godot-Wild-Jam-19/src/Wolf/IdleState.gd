extends Node

var fsm: StateMachine
var FleeState = "FleeState"
var HuntState = "HuntState"
var active = false

func enter():
	active = true
	pass

func exit():
	active = false
	pass

# Optional handler functions for game loop events
func physics_process(delta):
	think()
	pass
	
func think():
	var wolf = get_parent().get_parent()
	
	if (wolf.shot_heard && wolf.detected_hunter):
		# Flip a coin to decide to flee or not
		
		
		get_parent().change_to(FleeState)

	if wolf.is_aggresive:
		pass

func _on_HeardShotTimer_timeout():
	var wolf = get_parent().get_parent()
	
	if wolf.detected_hunter && active:
		if wolf.DEBUG:
			print("Wolf was angered by gun shot")
		get_parent().change_to(HuntState)
	pass
