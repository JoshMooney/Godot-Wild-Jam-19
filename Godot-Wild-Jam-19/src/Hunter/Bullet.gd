extends Area2D
var speed
var direction 
var velocity
var is_shot = false
var damage

func shoot(dir, spd, dmg):
	is_shot = true
	speed = spd
	direction = dir
	damage = dmg

func die():
	$HitAudioStreamPlayer.play()

func _physics_process(delta):
	if is_shot:
		move(delta)

func move(delta):
	var velocity = direction * speed * delta
	position += velocity
	pass

func _on_Bullet_body_entered(body):
	if "Deer" in body.get_name():
		body.hit(damage)
		die()
	pass 


func _on_HitAudioStreamPlayer_finished():
	queue_free()
