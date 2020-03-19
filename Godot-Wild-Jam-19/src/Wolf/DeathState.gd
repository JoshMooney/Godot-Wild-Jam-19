extends Node

var fsm: StateMachine
var DeathState = "DeathState"

func enter():
	think()
	pass

func exit():
	print("??? Hunter exited Death state ???")
	
func think():
	var deer = get_parent().get_parent()
	
	deer.get_node("CollisionShape2D").call_deferred("set_disabled", true)
	deer.get_node("ComfortArea/CollisionShape2D").call_deferred("set_disabled", true)
	deer.get_node("AggressionArea/CollisionShape2D").call_deferred("set_disabled", true)
	
	# Set death animation
	
	# Play death SFX
	
	pass
