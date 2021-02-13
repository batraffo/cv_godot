extends Area2D


const SCORE_SCENE=preload("res://ui/WritingScore.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_PisaTower_body_entered(body):
	#if(self.get_tree().get_nodes_in_group("score").size() < 1):
		if body.is_in_group("player"):
			#var score = SCORE_SCENE.instance()
			#score.get_node("Label").text= "+ University enrollment"
			#score.get_node("Label").get_font("font").size= 16
			#score.get_node("Label").add_color_override("font_color", Color( 0.39, 0.58, 0.93, 1 ))
			#self.add_child(score)
			body.set_adult()
			$AudioStreamPlayer2D.play()
