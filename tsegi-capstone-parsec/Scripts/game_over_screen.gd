extends Control


func _on_button_pressed() -> void:
	get_tree().reload_current_scene()
	
func set_score(value):
	$Panel/SCORE.text = "SCORE: " + str(value)

func set_high_score(value):
	$"Panel/HIGH SCORE".text = "HI-SCORE: " + str(value)
