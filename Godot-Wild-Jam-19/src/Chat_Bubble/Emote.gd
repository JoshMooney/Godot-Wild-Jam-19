extends Sprite

enum EMOTE {
	HUNGERY,
	TIRED,
	COLD,
	HAPPY,
	LOVE
}

var EMOTE_MAP = {
	EMOTE.HUNGERY: preload("res://assets/default.png"),
	EMOTE.TIRED: preload("res://assets/default.png"),
	EMOTE.COLD: preload("res://assets/default.png"),
	EMOTE.HAPPY: preload("res://assets/default.png"),
	EMOTE.LOVE: preload("res://assets/default.png")
}
var current_emote

func _ready():
	pass#hide()
	
func Set(emote):
	current_emote = emote
	set_texture(EMOTE_MAP[current_emote])
	show()
	#bobble()
