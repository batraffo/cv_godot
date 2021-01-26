extends Area2D


var speed = 300

func _process(delta):
	position += transform.x * speed * delta


func _on_VisibilityNotifier2D_viewport_exited(_viewport):
	queue_free()


func _on_Hadoken_body_shape_entered(_body_id, body, _body_shape, _area_shape):
	if (!self.is_queued_for_deletion() && body.is_in_group("baddies")):
		print ("body.call_deferred(nameofafunction)")
	if (!body.is_in_group("player")):
		queue_free()
