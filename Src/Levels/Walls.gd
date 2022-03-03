extends StaticBody2D

var point: = 0
onready var global_var=get_node("/root/Gloabl")

func _physics_process(delta):
	if global_var.is_game_started==true:
		position +=Vector2(-3,0)

