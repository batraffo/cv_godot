extends KinematicBody2D

const HADOKEN_SCENE=preload("res://objects/Hadoken.tscn")

var is_left=false

const UP=Vector2(0,-1)
const GRAVITY=20
const MAX_SPEED=200
const ACCELLERATION=50
const JUMP_HEIGHT=-450
var motion=Vector2()

var animation_finished =false
var is_hadoken_animation_active=false
var secondJump=true
var canIShotHadoken=false
var playerHit = false

func _ready():
	var sprite = get_node("Sprite")
	sprite.connect("animation_finished",self,"_on_Sprite_animation_finished")

func _physics_process(_delta):
	if(animation_finished):
		
		#hadoken animation finished, maybe there is a better solution
		if $Sprite.animation == "Hadoken" && $Sprite.frame == $Sprite.frames.get_frame_count("Hadoken")-1:
			is_hadoken_animation_active=false
		
		motion.y+=GRAVITY
		var friction = false
		if !playerHit:
			if Input.is_action_pressed("ui_right"):
				motion.x=min(motion.x+ACCELLERATION,MAX_SPEED)
				$Sprite.flip_h=false
				is_left=false
				$RayCastRight2D.set_enabled(true)
				$RayCastLeft2D.set_enabled(false)
				if(!is_hadoken_animation_active):
					$Sprite.play("Run")
			elif Input.is_action_pressed("ui_left"):
				motion.x=max(motion.x-ACCELLERATION,-MAX_SPEED)
				$Sprite.flip_h=true
				is_left=true
				$RayCastRight2D.set_enabled(false)
				$RayCastLeft2D.set_enabled(true)
				if(!is_hadoken_animation_active):
					$Sprite.play("Run")
			else:
				if(!is_hadoken_animation_active):
					$Sprite.play("Idle")
				friction=true
		
		
			if is_on_floor():
				secondJump=true
				if Input.is_action_just_pressed("ui_up"):
					motion.y=JUMP_HEIGHT
					$JumpEffect.play()
				if(friction):
					motion.x=lerp(motion.x,0,0.2)
			else:
				if Input.is_action_just_pressed("ui_up"):
					
					if(secondJump):
						secondJump=false
						motion.y=JUMP_HEIGHT/1.5
						$JumpEffect.play()
				
				#play animation
				if(!is_hadoken_animation_active):
					if(motion.y<0):
						$Sprite.play("Jump")
					else:
						$Sprite.play("Fall")
				
				if(friction):
					motion.x=lerp(motion.x,0,0.05)
		else:
			motion.x= -750
			motion.y= JUMP_HEIGHT*0.7
			playerHit=false
		motion=move_and_slide(motion,UP)
		pass
	else:
		$Sprite.play("EggExit")


func _unhandled_key_input(event):
	if(canIShotHadoken):
		if(event.is_action_pressed("hadoken")):
			if(!($RayCastLeft2D.is_colliding() or $RayCastRight2D.is_colliding())):
				if(get_parent().get_tree().get_nodes_in_group("hadoken").size() < 2):
					$HadokenEffect.play()
					is_hadoken_animation_active=true
					$Sprite.play("Hadoken")
					shoot()

func shoot():
	var hadoken = HADOKEN_SCENE.instance()
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

func hit(enemyPosition):
	if(!playerHit):
		print("hit")
		$AnimationPlayer.stop()
		$AnimationPlayer.play("PlayerHit")
		$Ouch.play()
		playerHit=true

func _on_Sprite_animation_finished():
	animation_finished= true
	var sprite = get_node("Sprite")
	print("once")
	get_node("AnimationPlayer").play("BornFading")
	get_parent().get_node("Sounds/Music").play()
	get_parent().get_node("AnimationPlayer").play("TutorialFade")
	sprite.disconnect("animation_finished",self,"_on_Sprite_animation_finished")


func _on_Headband_body_entered(body):
	if(body.is_in_group("player")):
		canIShotHadoken=true
