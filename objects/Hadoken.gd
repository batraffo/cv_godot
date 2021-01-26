extends Area2D


var speed = 300

func _process(delta):
	position += transform.x * speed * delta


func _on_VisibilityNotifier2D_viewport_exited(viewport):
	print("goodbye")
	queue_free()


func _on_Hadoken_body_shape_entered(body_id, body, body_shape, area_shape):
	if (!self.is_queued_for_deletion() && body.is_in_group("baddies")):
		print ("body.call_deferred(nameofafunction)")
