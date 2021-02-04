extends Control

const CREDIT_SCENE_MAX=4

var creditScene = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("Credits")


func _unhandled_key_input(event):
	if event.is_action_pressed("ui_end"):
		Music.stop()
		if get_tree().change_scene("res://ui/StartScreen.tscn") != OK:
			print("what?")


func _on_AnimationPlayer_animation_finished(_anim_name):
	creditScene+=1
	#if(creditScene>=CREDIT_SCENE_MAX):
		#if get_tree().change_scene("res://ui/StartScreen.tscn") != OK:
			#print("what?")
	match creditScene:
		1:
			$Panel/VBoxContainer/What.text="Art"
			$Panel/VBoxContainer/Who.text ="My beloved Rebecca Buccheri"
			$AnimationPlayer.play("Credits")
		2:
			$Panel/VBoxContainer/What.text="Music"
			$Panel/VBoxContainer/Who.text="TeknoAXE - A Brand New Adventure"
			$AnimationPlayer.play("Credits")
		3:
			$Panel/VBoxContainer/What.text="Special Thanks"
			$Panel/VBoxContainer/Who.text="Open"
			$AnimationPlayer.play("Credits")
		CREDIT_SCENE_MAX:
			$Panel/VBoxContainer/What.add_color_override("font_color", Color( 0.5, 1, 0, 1 ))
			$Panel/VBoxContainer/What.text= "Press ESC to return to the Main Menu"
			$Panel/VBoxContainer/Who.set_self_modulate(Color(1,1,1,0))
			$AnimationPlayer.play("End")
