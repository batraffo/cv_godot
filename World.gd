extends Node2D

var hitBlocks = 0

onready var computer = get_node("Computer")
onready var school = get_node("HighSchool")
onready var pisa = get_node("PisaTower")
onready var desk = get_node("Desk")
onready var flag = get_node("Flag")


func hit_all_block():
	hitBlocks+= 1
	if hitBlocks == 12:
		print("Game Finished")
		flag.show()
		$Sounds/AudioStreamPlayer.play()
		flag.connect("body_entered", self, "_finish_game")

# Called when the node enters the scene tree for the first time.
func _ready():
	computer.connect("body_entered", self, "_spawn_headband")
	school.connect("body_entered", self, "_spawn_book")
	pisa.connect("body_entered", self, "_spawn_university")
	desk.connect("body_entered", self, "_spawn_hat")


func _spawn_headband(body):
	print(body)
	if body.is_in_group("player"):
		$Headband.show()
		computer.disconnect("body_entered", self, "_spawn_headband")

func _spawn_book(body):
	if body.is_in_group("player"):
		$Book.show()
		school.disconnect("body_entered", self, "_spawn_book")

func _spawn_university(body):
	if body.is_in_group("player"):
		$AnimationPlayer.play("UniversityFade")
		pisa.disconnect("body_entered", self, "_spawn_university")
		

func _spawn_hat(body):
	if body.is_in_group("player"):
		$GraduateCap.show()
		desk.disconnect("body_entered", self, "_spawn_hat")

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


func _on_GraduateCap_body_entered(body):
	if body.is_in_group("player"):
		$GraduateCap.hide()
		$GraduateCap/AudioStreamPlayer2D.play()
		$Storytelling/Label8.show()
		
func _finish_game(body):
	if body.is_in_group("player"):
		get_tree().quit()
