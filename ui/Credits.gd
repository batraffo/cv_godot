extends Control

const CREDIT_SCENE_MAX=4

var creditScene = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in $HBoxContainer/Panel2.get_children():
		i.set_modulate(Color (1,1,1,1))
		i.set_self_modulate(Color (1,1,1,1))
	for i in $HBoxContainer/Panel2/Skills.get_children():
		i.set_modulate(Color (1,1,1,1))
		i.set_self_modulate(Color (1,1,1,1))
	for i in $HBoxContainer/Panel2/GridContainer.get_children():
		i.set_modulate(Color (1,1,1,1))
		i.set_self_modulate(Color (1,1,1,1))
	for i in $HBoxContainer/Panel2/GridContainer2.get_children():
		i.set_modulate(Color (1,1,1,1))
		i.set_self_modulate(Color (1,1,1,1))
	for i in $HBoxContainer/Panel2/GridContainer3.get_children():
		i.set_modulate(Color (1,1,1,1))
		i.set_self_modulate(Color (1,1,1,1))
		
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
			$HBoxContainer/Panel/VBoxContainer/What.text="Art"
			$HBoxContainer/Panel/VBoxContainer/Who.text ="My beloved Rebecca Buccheri"
			$AnimationPlayer.play("Credits")
		2:
			$HBoxContainer/Panel/VBoxContainer/What.text="Music"
			$HBoxContainer/Panel/VBoxContainer/Who.text="TeknoAXE - A Brand New Adventure"
			$AnimationPlayer.play("Credits")
		3:
			$HBoxContainer/Panel/VBoxContainer/What.text="Special Thanks"
			$HBoxContainer/Panel/VBoxContainer/Who.text="Open Pixel Project\ndogchiken - opengameart.org"
			$AnimationPlayer.play("Credits")
		CREDIT_SCENE_MAX:
			$HBoxContainer/Panel/VBoxContainer/What.add_color_override("font_color", Color( 0.5, 1, 0, 1 ))
			$HBoxContainer/Panel/VBoxContainer/What.text= "Press ESC to return to the Main Menu"
			$HBoxContainer/Panel/VBoxContainer/Who.set_self_modulate(Color(1,1,1,0))
			$AnimationPlayer.play("End")
