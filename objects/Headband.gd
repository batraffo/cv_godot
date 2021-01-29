extends Area2D


func _ready():
	$AnimationPlayer.play("LittleHighLittleLow")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_AudioStreamPlayer2D_finished():
	queue_free()
