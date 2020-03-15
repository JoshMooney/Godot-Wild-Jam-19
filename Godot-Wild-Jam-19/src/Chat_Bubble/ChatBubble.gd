extends Sprite

onready var Emote = get_node("Emote")

func _ready():
	hide()
	pass 

func _process(delta):
	pass

func trigger(emote):
	show()
	$EmoteTimer.start()
	Emote.Set(emote)
	pass
	
func _on_EmoteTimer_timeout():
	Emote.hide()
	hide()
	
