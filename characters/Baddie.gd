extends KinematicBody2D

const GRAVITY=20
const SPEED = 100
const UP = Vector2(0,-1)

var velocity = Vector2()

var direction = 1 #it's right

func _physics_process(_delta):
	velocity.x=SPEED *direction
	$AnimatedSprite.play("Walk")
	velocity.y += GRAVITY
	
	velocity=move_and_slide(velocity, UP)
	
	if is_on_wall():
		direction= direction * -1
		$AnimatedSprite.flip_h=!$AnimatedSprite.flip_h
		$RayCast2D.position.x = $RayCast2D.position.x * -1
	
	if !$RayCast2D.is_colliding():
		direction= direction * -1
		$AnimatedSprite.flip_h=!$AnimatedSprite.flip_h
		$RayCast2D.position.x = $RayCast2D.position.x * -1

func die(reversed):
	set_physics_process(false)
	$CollisionShape2D.set_disabled(true)
	$HitBox/CollisionShape2D.set_disabled(true)
	$AnimatedSprite.stop()
	$AudioStreamPlayer2D.play()
	if !reversed:
		$AnimationPlayer.play("Die")
	else:
		$AnimationPlayer.play("DieReversed")

func _on_AnimationPlayer_animation_finished(_anim_name):
	queue_free()


func _on_HitBox_body_entered(body):
	if (body.is_in_group("player")):
		body.call_deferred("hit",position.x)
