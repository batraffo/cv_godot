extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	$"MarginContainer/VBoxContainer/VBoxContainer/Start Game".grab_focus()



func _on_Quit_pressed():
	get_tree().quit()


func _on_Start_Game_pressed():
	if get_tree().change_scene("res://World.tscn") != OK:
		print ("An unexpected error occured when trying to switch to the Readme scene")
