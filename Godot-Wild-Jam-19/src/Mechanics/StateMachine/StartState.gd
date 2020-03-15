extends Node2D

var fsm: StateMachine

func enter():
	print("Hello from StartState!")
	# Exit 2 seconds later
	yield(get_tree().create_timer(2.0), "timeout")
	exit("State1")

func exit(next_state):
	fsm.change_to(next_state)

# Optional handler functions for game loop events
func physics_process(delta):
	return delta
