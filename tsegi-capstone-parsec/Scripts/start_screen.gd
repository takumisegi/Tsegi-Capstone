extends Control

var scroll_speed = 200

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene_to_file("res://Scenes/Game.tscn")
	
