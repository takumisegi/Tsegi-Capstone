class_name Enemy extends Area2D

signal killed

@export var speed = 100
@export var hp = 1
@export var points = 100

func _physics_process(delta):
	global_position.y += speed * delta

func die():
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.die()
		die()
	
func take_damage(amount):
	hp -= amount
	if hp <= 0:
		killed.emit()
		die()
	
