extends KinematicBody2D

const UP=Vector2(0,-1) #la direzione su
const GRAVITY=20
const MAX_SPEED=200
const ACCELLERATION=50
const JUMP_HEIGHT=-450
var motion=Vector2()

var animation_finished =false

func _ready():
	var sprite = get_node("Sprite")
	sprite.connect("animation_finished",self,"_on_Sprite_animation_finished")

func _physics_process(delta):
	if(animation_finished):
		motion.y+=GRAVITY
		var friction = false
		if Input.is_action_pressed("ui_right"):
			motion.x=min(motion.x+ACCELLERATION,MAX_SPEED)
			$Sprite.flip_h=false
			$Sprite.play("Run")
		elif Input.is_action_pressed("ui_left"):
			motion.x=max(motion.x-ACCELLERATION,-MAX_SPEED)
			$Sprite.flip_h=true
			$Sprite.play("Run")
		else:
			$Sprite.play("Idle")
			friction=true
		
		if is_on_floor():
			if Input.is_action_just_pressed("ui_up"):
				motion.y=JUMP_HEIGHT
				$JumpEffect.play()
			if(friction):
				motion.x=lerp(motion.x,0,0.2)
		else:
			if(motion.y<0):
				$Sprite.play("Jump")
			else:
				$Sprite.play("Fall")
			if(friction):
				motion.x=lerp(motion.x,0,0.05)
		
		motion=move_and_slide(motion,UP)
		pass
	else:
		$Sprite.play("EggExit")


func _on_Sprite_animation_finished():
	animation_finished= true
	var sprite = get_node("Sprite")
	print("once")
	get_node("AnimationPlayer").play("BornFading")
	get_parent().get_node("Music").play()
	sprite.disconnect("animation_finished",self,"_on_Sprite_animation_finished")
