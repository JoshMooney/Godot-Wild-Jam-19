extends Node

var fsm: StateMachine
var IdleState = "IdleState"
onready var Timer = get_parent().get_node("FleeTimer")
onready var StateMachine = get_parent().get_parent().get_node("StateMachine")

func enter():
	Timer.start()
	pass

func exit():
	Timer.stop()
	fsm.back()

func physics_process(delta):
	pass
	
func think():
	var deer = get_parent().get_parent()
	if !deer.shot_heard && !deer.is_uncomfortable && !deer.detected_hunter:
		StateMachine.change_to(IdleState)
	else:
		continue_scared()
	
func flee(dir):
	# Find vector in opposite direction from the shooter
	pass
	
func is_safe():
	return get_parent().get_parent().detected_hunter
	
func continue_scared():
	print("Deer: Is still scared continuing to Flee")
	Timer.start()

func _on_FleeTimer_timeout():
	think()
