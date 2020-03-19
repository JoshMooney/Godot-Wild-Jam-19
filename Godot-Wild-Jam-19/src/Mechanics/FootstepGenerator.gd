extends Node2D

var time = 0
var footNode = load("res://src/Mechanics/FootStep.tscn")
var foot = []
var step = []
var max_steps = 10.0

func _ready():
	for i in range(max_steps):
		foot.append(footNode.instance())
		add_child(foot[i])
		step.append([Vector2(-32,-32), 0])
	set_process(true)
	pass 

func _process(delta):
	time += delta
	if time > 0.25:
		var pos = get_global_position()
		print("Foot position" + str(pos))
		print("Hunter position from foot" + str(get_parent().get_global_position()))
		var name = get_parent().get_name()
		step.push_front([pos, get_parent().get_rotation()])
		step.pop_back()
		for i in range(max_steps):
			foot[i].set_position(step[i][0])
			#foot[i].set_rotation(step[i][1])
			foot[i].modulate = Color(1, 1, 1, ((max_steps-i)/max_steps))
		time = 0
	pass
