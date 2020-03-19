extends Node

class_name StateMachine

export var DEBUG = true

var state: Object

var history = []
var history_max_length = 5

func _ready():
	# Set the initial state to the first child node
	state = get_child(0)
	_enter_state()
	
func change_to(new_state):
	if new_state == state.name:
		print(get_parent().get_name() + " tried to change its state to " + new_state + " which it already is!")
		return
	history.append(state.name)
	_exit_state()
	state = get_node(new_state)
	_enter_state()
	if len(history) > history_max_length:
		history.pop_front()

func back():
	if history.size() > 0:
		state = get_node(history.pop_back())
		_enter_state()

func _exit_state():
#	if DEBUG:
#		print("Exiting state: ", state.name)
	state.exit()

func _enter_state():
	if DEBUG:
		print(get_parent().get_name() + " Entering state: ", state.name)
	# Give the new state a reference to this state machine script
	state.fsm = self
	state.enter()

# Route Game Loop function calls to
# current state handler method if it exists
func _physics_process(delta):
	if state.has_method("physics_process"):
		state.physics_process(delta)
