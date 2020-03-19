extends Node

var fsm: StateMachine
var FleeState = "FleeState"


func enter():
	pass

func exit():
	get_parent().get_node("HeardShotTimer").stop()
	pass

# Optional handler functions for game loop events
func physics_process(delta):
	think()
	pass
	
func think():
	var deer = get_parent().get_parent()
	
	if (deer.shot_heard && deer.detected_hunter) || deer.is_uncomfortable:
		get_parent().change_to(FleeState)


func _on_HeardShotTimer_timeout():
	var deer = get_parent().get_parent()
	
	if deer.shot_heard && deer.detected_hunter:
		if deer.DEBUG:
			print("Deer was scared off by the gun shot")
		deer.shot_heard = false
		get_parent().change_to(FleeState)
	pass
