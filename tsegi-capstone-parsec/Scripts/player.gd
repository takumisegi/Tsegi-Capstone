class_name Player extends CharacterBody2D

signal laser_shot(laser_scene, location)
signal killed

@export var speed = 300
@onready var muzzle = $Muzzle

var laser_scene = preload("res://Scenes/laser.tscn")

var shoot_cd := false 

func _process(delta):
	if Input.is_action_just_pressed("shoot"):
	#if Input.is_action_pressed("shoot"):
		if !shoot_cd:
			shoot_cd = true
			shoot()
			await get_tree().create_timer(0.25).timeout
			shoot_cd = false
	

func _physics_process(delta):
	var direction = Vector2(Input.get_axis("ui_left","ui_right"),Input.get_axis("ui_up","ui_down"))
	print(direction)
	velocity = direction * speed
	move_and_slide()
	
	global_position = global_position.clamp(Vector2.ZERO,get_viewport_rect().size)
		
func shoot():
	laser_shot.emit(laser_scene, muzzle.global_position)

func die():
	killed.emit()
	queue_free()
