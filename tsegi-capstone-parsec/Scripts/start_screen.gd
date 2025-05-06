extends Control

var scroll_speed = 200

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene_to_file("res://Scenes/Game.tscn")
	

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")


func _on_story_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Story.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
