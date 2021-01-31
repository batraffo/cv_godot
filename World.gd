extends Node2D

onready var computer = get_node("Computer")
onready var school = get_node("HighSchool")

# Called when the node enters the scene tree for the first time.
func _ready():
	computer.connect("body_entered", self, "_spawn_headband")
	school.connect("body_entered", self, "_spawn_book")


func _spawn_headband(body):
	print(body)
	if body.is_in_group("player"):
		$Headband.show()
		computer.disconnect("body_entered", self, "_spawn_headband")

func _spawn_book(body):
	if body.is_in_group("player"):
		$Book.show()
		school.disconnect("body_entered", self, "_spawn_book")

func _on_Headband_body_entered(body):
	if body.is_in_group("player"):
		$Headband.hide()
		$Headband/AudioStreamPlayer2D.play()
		$AnimationPlayer.play("TutorialFade2")


func _on_Book_body_entered(body):
	if body.is_in_group("player"):
		$Book.hide()
		$Book/AudioStreamPlayer2D.play()
		$AnimationPlayer.play("TutorialFade3")
