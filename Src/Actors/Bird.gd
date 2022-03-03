extends KinematicBody2D

const gravity=10
const up = Vector2(0,-1)
const flap = 200
const maxfallspeed = 200

var point: = 0
var rot_downward = 1
var turning = 10
var rot_upward = -1

onready var global_var=get_node("/root/Gloabl")

onready var anim_player:AnimationPlayer=get_node("AnimationPlayer")

var Wall = preload("res://Src/Levels/Walls.tscn")

var motion = Vector2()

func _ready():
	pass
# warning-ignore:unused_argument
func _physics_process(delta):
	if global_var.is_game_started == true:
		motion.y += gravity
		if motion.y > maxfallspeed:
			motion.y = maxfallspeed
		if rot_downward > 0 and rot_downward<60:
			rot_downward+=1
			$FlappyBird.rotation+=delta*2
	
	if  Input.is_action_just_pressed("boost"):
			motion.y = -flap
			anim_player.stop()
			anim_player.play("Boost")
			rot_downward=1
			global_var.is_game_started = true
			get_parent().get_parent().get_node("Text").visible=false
	motion = move_and_slide(motion,up)
	get_parent().get_parent().get_node("Point/RichTextLabel").text=str(point)
func wall_reset():
	var wall_instance = Wall.instance()
	wall_instance.position=Vector2(640,rand_range(-180,60))
	get_parent().call_deferred("add_child",wall_instance)
func _on_Detect_area_entered(area):
	if area.name=="Point":
		point+=1
func _on_Detect_body_entered(body):
	if body.name =="Walls":
		global_var.is_game_started=false
		get_parent().get_parent().get_node("Text").visible=true
		get_tree().reload_current_scene()
func _on_Resetter_body_entered(body):
	if body.name == "Walls":
		body.queue_free()
		wall_reset()
func _on_Limiter_area_entered(area):
	if area.name=="Detect":
		global_var.is_game_started=false
		get_parent().get_parent().get_node("Text").visible=true
		get_tree().reload_current_scene()
