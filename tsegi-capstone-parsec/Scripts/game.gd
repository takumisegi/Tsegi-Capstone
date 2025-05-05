extends Node2D

@export var enemy_scenes: Array[PackedScene] = []

@onready var player_spawn_pos = $PlayerSpawnPos
@onready var laser_container = $LaserContainer
@onready var timer = $EnemySpawnTimer
@onready var enemy_container = $EnemyContainer
@onready var hud = $UILayer/HUD
@onready var gos = $UILayer/GameOverScreen
@onready var pb = $ParallaxBackground

var player = null
var score := 0:
	set(value):
		score = value
		hud.score = score
var high_score

var scroll_speed = 200

func _ready():
	var save_file = FileAccess.open("user://save.data",FileAccess.READ)
	if save_file!=null:
		high_score = save_file.get_32()
	else:
		high_score = 0
		save_game()
	
	score = 0
	player = get_tree().get_first_node_in_group("player")
	assert(player!=null)
	player.global_position = player_spawn_pos.global_position
	player.laser_shot.connect(_on_player_laser_shot)
	player.killed.connect(_on_player_killed)
	
	
func save_game():
	var save_file = FileAccess.open("user://save.data",FileAccess.WRITE)
	save_file.store_32(high_score)

func _process(delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	elif Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()
		
		if timer.wait_time > 0.5:
			timer.wait_time -= delta*0.005
		elif timer.wait_time < 0.5:
			timer.wait_time = 0.5
		print(timer.wait_time)
	
	pb.scroll_offset.y += delta*scroll_speed
	#print(pb.scroll_offset.y)
	if pb.scroll_offset.y >= 1080:
		pb.scroll_offset.y = 0
		
func _on_player_laser_shot(laser_scene, location):
	var laser = laser_scene.instantiate()
	laser.global_position = location
	laser_container.add_child(laser)

func _on_enemy_spawn_timer_timeout() -> void:
	var e = enemy_scenes.pick_random().instantiate()
	e.global_position = Vector2(randf_range(50,1900), -50)
	e.killed.connect(_on_enemy_killed)
	enemy_container.add_child(e)
	
func _on_enemy_killed(points):
	score += points
	if score > high_score:
		high_score = score
	print(score)
	
func _on_player_killed():
	gos.set_score(score) 
	gos.set_high_score(high_score)
	save_game()
	await get_tree().create_timer(1).timeout
	gos.visible = true
	

	
