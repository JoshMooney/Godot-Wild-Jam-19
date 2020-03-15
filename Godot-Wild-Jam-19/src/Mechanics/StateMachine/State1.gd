extends Node2D

var fsm: StateMachine

func enter():
	print("Hello from State 1!")
	yield(get_tree().create_timer(2.0), "timeout")
	exit()

func exit():
	fsm.back()
