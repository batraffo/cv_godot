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
		score.get_node("Label").get_font("font").size= 30
		if(!skillBuffa):
			#i know it's bad
			get_parent().get_parent().hit_all_block()
			var player = get_parent().get_parent().get_node("Player")
			var skill=player.get_node("Camera2D/CanvasLayer/Control/Panel/Skills/Skill"+str(skillNumber))
			skill.set_self_modulate(Color(1,1,1,1))
			if(skillNumber==10):
				var skill2=player.get_node("Camera2D/CanvasLayer/Control/Panel/Skill 10 2")
				skill2.set_self_modulate(Color(1,1,1,1))
				score.get_node("Label").text=  "+ Problem solving"
					
			elif(skillNumber==5):
				score.get_node("Label").text=  "+ Android development"
			else:
				score.get_node("Label").text=  skill.text.replace("-","+")
		else:
			score.get_node("Label").add_color_override("font_color", Color( 0.6, 0.2, 0.8, 1 ))
			score.get_node("Label").text= "+ " + skillName 
		self.add_child(score)
