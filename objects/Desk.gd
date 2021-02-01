extends Area2D



func _on_Desk_body_entered(body):
	if body.is_in_group("player"):
		$AudioStreamPlayer2D.play()
