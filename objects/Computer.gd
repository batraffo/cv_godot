extends Area2D


const SCORE_SCENE=preload("res://ui/WritingScore.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Computer_body_entered(body):
	if(self.get_tree().get_nodes_in_group("score").size() < 1):
		if body.is_in_group("player"):
			var score = SCORE_SCENE.instance()
			self.add_child(score)
