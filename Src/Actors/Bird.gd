extends KinematicBody2D

const gravity=10
const up = Vector2(0,-1)
const flap = 200
const maxfallspeed = 200
export var turning = 70
var point: = 0
var rot_degree=1
var is_falling = true

onready var anim_player:AnimationPlayer=get_node("AnimationPlayer")

var Wall = preload("res://Src/Levels/Walls.tscn")

var motion = Vector2()

func _ready():
	pass

# warning-ignore:unused_argument
func _physics_process(delta):
	motion.y += gravity
	rot_degree-=1
	is_falling=true
	if motion.y > maxfallspeed:
		motion.y = maxfallspeed
	
	if is_falling == true:
		if rot_degree<0 and rot_degree >-45:
			$FlappyBird.rotation_degrees+=delta*turning
		else:
			rot_degree=0
	if  Input.is_action_just_pressed("boost"):
		motion.y = -flap
		anim_player.play("Boost")
		
	motion = move_and_slide(motion,up)
	get_parent().get_node("RichTextLabel").text=str(point)

func wall_reset():
	var wall_instance = Wall.instance()
	wall_instance.position=Vector2(440,rand_range(-180,60))
	get_parent().call_deferred("add_child",wall_instance)



func _on_Detect_area_entered(area):
	if area.name=="Point":
		point+=1


func _on_Detect_body_entered(body):
	if body.name=="Walls":
		get_tree().reload_current_scene()
	



func _on_Resetter_body_entered(body):
	if body.name== "Walls":
		body.queue_free()
		wall_reset()
