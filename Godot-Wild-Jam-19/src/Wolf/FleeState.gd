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

func physics_process(delta):
	pass
	
func think():
	var wolf = get_parent().get_parent()
	var shot_heard = wolf.shot_heard
	var detected_hunter = wolf.detected_hunter
	if !shot_heard && !detected_hunter:
		StateMachine.change_to(IdleState)
	else:
		continue_scared()
	
func flee(dir):
	# Find vector in opposite direction from the shooter
	pass
	
func is_safe():
	return get_parent().get_parent().detected_hunter
	
func continue_scared():
	print("Wolf: Is still scared continuing to Flee")
	Timer.start()

func _on_FleeTimer_timeout():
	think()
