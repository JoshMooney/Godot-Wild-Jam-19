extends Node

var fsm: StateMachine
var FleeState = "FleeState"

func enter():
	pass

func exit():
	fsm.back()

# Optional handler functions for game loop events
func physics_process(delta):
	think()
	pass
	
func think():
	var deer = get_parent().get_parent()
	if (deer.shot_heard && deer.detected_hunter) || deer.is_uncomfortable:
		get_parent().change_to(FleeState)
