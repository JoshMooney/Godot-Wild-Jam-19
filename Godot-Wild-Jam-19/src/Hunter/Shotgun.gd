extends Node2D

var MOUSE_POSITION
var can_shoot = true
export var ROTATION_DRAG = 0.1
var shoot_speed = 1000
var shotgun_shells = 5
var shotgun_spread = 12
var shotgun_damage = 10
var bullet = preload("res://src/Hunter/Bullet.tscn")

func _ready():
	$ShotSoundArea/CollisionShape2D.disabled = true

func _physics_process(delta):
	MOUSE_POSITION = get_local_mouse_position()
	rotation += MOUSE_POSITION.angle()*ROTATION_DRAG
	
	poll_input()
	pass
	
func poll_input():
	if Input.is_action_pressed("ui_accept") && can_shoot:
		shoot()

func rotate_point_by_angle(point, angle):
	var x = point.x * cos(angle) - point.y * sin(angle)
	var y = point.y * cos(angle) + point.x * sin(angle)
	
	x = cos(angle) * (point.x - 0) - sin(angle) * (point.y - 0) + 0
	y = sin(angle) * (point.x - 0) - cos(angle) * (point.y - 0) + 0
	
	return Vector2(x, y)

func spawn_bullet(normalized_dir, shoot_speed):
	var new_bullet = bullet.instance()
	
	#new_bullet.set_position(rotate_point_by_angle($GunBarrelPosition.get_position(), MOUSE_POSITION.angle()*ROTATION_DRAG))
	var direction = normalized_dir
	direction += add_noise_to_normal(normalized_dir,  shotgun_spread)
	new_bullet.shoot(direction, shoot_speed, shotgun_damage)
	get_parent().add_child(new_bullet)

func add_noise_to_normal(normalized_dir,  shotgun_spread):
	var random_noise_x = rand_range(0,shotgun_spread+1)
	var random_noise_y = rand_range(0,shotgun_spread+1)
	
	# Randomly decide to flip x
	if randi() % 2:
		random_noise_x *= -1
	# Randomly decide to flip y
	if randi() % 2:
		random_noise_y *= -1
	
	var noise = Vector2(sin(2 * PI * random_noise_x / 360), sin(2 * PI * random_noise_y / 360))
	
	return noise

func shoot():
	# Fire Bullet 
	var hunter_pos = get_parent().get_position()
	var global_mouse_position = get_global_mouse_position()
	var direction = Vector2(global_mouse_position.x - hunter_pos.x, global_mouse_position.y - hunter_pos.y)
	var normalized_dir = direction.normalized()
	
	for bullet_index in shotgun_shells:
		spawn_bullet(normalized_dir, shoot_speed)
	
	$ShotSoundArea/CollisionShape2D.disabled = false
	
	# Play SFX
	$ShotAudioStreamPlayer.play()
	can_shoot = false
	$ShotTimer.start()
	$ShotSoundTimer.start()
	pass

func _on_ShotTimer_timeout():
	can_shoot = true
	pass 

func _on_ShotSoundArea_body_entered(body):
	body.shot_heard(get_global_position())


func _on_ShotSoundTimer_timeout():
	$ShotSoundArea/CollisionShape2D.disabled = true
