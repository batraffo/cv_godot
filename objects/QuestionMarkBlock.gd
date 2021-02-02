extends StaticBody2D

const SCORE_SCENE=preload("res://ui/WritingBlockScore.tscn")

export (bool) var skillBuffa
export (int) var skillNumber
export (String) var skillName

onready var area= get_node("Area2D")

# Called when the node enters the scene tree for the first time.
func _ready():
	area.connect("body_entered", self, "_show_skill")


func _show_skill(body):
	if body.is_in_group("player"):
		area.disconnect("body_entered", self, "_show_skill")
		$AnimationPlayer.play("BlockHit")
		if(!skillBuffa):
			$AudioStreamPlayer2D.play()
		else:
			$AudioStreamPlayer2DBuffo.play()
		var score = SCORE_SCENE.instance()
		score.get_node("Label").text= "+ " + skillName 
		score.get_node("Label").get_font("font").size= 16
		self.add_child(score)
