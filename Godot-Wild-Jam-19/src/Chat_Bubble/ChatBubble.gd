extends Sprite

onready var Emote = get_node("Emote")

func _ready():
	hide()
	pass 

func _process(delta):
	pass

func trigger(emote):
	Emote.Set(emote)
	$AnimationPlayer.play("Spawn")
	show()
	pass
	
func _on_EmoteTimer_timeout():
	$AnimationPlayer.play("FadeOut")
	
func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "FadeOut":
		pass
	elif anim_name == "Spawn":
		$EmoteTimer.start()
		pass
