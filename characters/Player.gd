extends KinematicBody2D

var hadoken_scene=load("res://objects/Hadoken.tscn")

var is_left=false

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

func _physics_process(_delta):
	if(animation_finished):
		motion.y+=GRAVITY
		var friction = false
		if Input.is_action_pressed("ui_right"):
			motion.x=min(motion.x+ACCELLERATION,MAX_SPEED)
			$Sprite.flip_h=false
			is_left=false
			$Sprite.play("Run")
		elif Input.is_action_pressed("ui_left"):
			motion.x=max(motion.x-ACCELLERATION,-MAX_SPEED)
			$Sprite.flip_h=true
			is_left=true
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


func _unhandled_key_input(event):
	if(event.is_action_pressed("hadoken")):
		$Sprite.play("Hadoken")
		shoot()

func shoot():
	var hadoken = hadoken_scene.instance()
	var posyplustwenty=position.y+20
	var posxplustwenty
	var rotationHadoken
	if is_left:
		rotationHadoken =PI
		posxplustwenty= position.x-20
	else:
		rotationHadoken =0
		posxplustwenty= position.x+20
	var hadokenpos = Vector2(posxplustwenty,posyplustwenty) #it must start from the hands
	hadoken.transform= Transform2D(rotationHadoken,hadokenpos)
	get_parent().add_child((hadoken))

func _on_Sprite_animation_finished():
	animation_finished= true
	var sprite = get_node("Sprite")
	print("once")
	get_node("AnimationPlayer").play("BornFading")
	get_parent().get_node("Music").play()
	sprite.disconnect("animation_finished",self,"_on_Sprite_animation_finished")
