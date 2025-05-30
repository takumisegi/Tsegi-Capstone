extends Area2D

@export var speed = 700
@export var damage = 1

func _physics_process(delta):
	global_position.y += -speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_area_entered(area: Area2D) -> void:
	if area is Enemy:
		area.take_damage(1)
		queue_free()

#
#func _on_area_entered(area: Area2D) -> void:
	#if area is Enemy:
		#area.take_damage(1)
		#queue_free
		
