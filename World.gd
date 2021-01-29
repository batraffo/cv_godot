extends Node2D

onready var computer = get_node("Computer")

# Called when the node enters the scene tree for the first time.
func _ready():
	computer.connect("body_entered", self, "_spawn_headband")


func _spawn_headband(body):
	print(body)
	if body.is_in_group("player"):
		$Headband.show()
		computer.disconnect("body_entered", self, "_spawn_headband")



func _on_Headband_body_entered(body):
	if body.is_in_group("player"):
		$Headband.hide()
		$Headband/AudioStreamPlayer2D.play()
		$AnimationPlayer.play("TutorialFade2")
