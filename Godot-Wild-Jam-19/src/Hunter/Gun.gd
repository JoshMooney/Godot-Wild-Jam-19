extends Node2D

var MOUSE_POSITION
var can_shoot = true
export var ROTATION_DRAG = 0.1
var shoot_speed = 1000
var bullet = preload("res://src/Hunter/Bullet.tscn")

func _physics_process(delta):
	MOUSE_POSITION = get_local_mouse_position()
	rotation += MOUSE_POSITION.angle()*ROTATION_DRAG
	
	poll_input()
	pass
	
func poll_input():
	if Input.is_action_pressed("ui_accept") && can_shoot:
		shoot()
		
func shoot():
	# Fire Bullet 
	var new_bullet = bullet.instance()
	#var direction = (get_parent().get_position() - MOUSE_POSITION).normalized()
	var hunter_pos = get_parent().get_position()
	var global_mouse_position = get_global_mouse_position()
	var direction = Vector2(global_mouse_position.x - hunter_pos.x, global_mouse_position.y - hunter_pos.y)
	var normalized_dir = direction.normalized()
	new_bullet.shoot(normalized_dir, shoot_speed)
	get_parent().add_child(new_bullet)
	
	# Play SFX
	$ShotAudioStreamPlayer.play()
	can_shoot = false
	$ShotTimer.start()
	pass


func _on_ShotTimer_timeout():
	can_shoot = true
	pass 
