extends CharacterBody2D

@onready var bullet = preload("res://Scenes/Game/Entities/Bullet.tscn")
@onready var turrent = preload("res://Scenes/Game/Entities/Turrent.tscn")
@onready var orbit = preload("res://Scenes/Game/Entities/Orbit.tscn")
@onready var scan = preload("res://Scenes/Game/Entities/Scan.tscn")
@onready var destruct =preload("res://Scenes/Game/Entities/Destruct.tscn")
# Called when the node enters the scene tree for the first time.
var shooting :bool = false
var on_cooldown = false
var health = 8
var modes = [["Attack",17,"000000"],["Orbit",10,"00ff00"],["Protect",5,"ff00ff"],["Scan",2,"00ffff"],["Destruct",1,"ff0000"]]
var current_mode = 0
func _ready():
	get_parent().get_child(4).max_value = health
	get_parent().get_child(4).value = health
	update_ammo()
	for x in 5.0:
		print(0.75+(x*(1.00-(0.25 *(x-1)))))
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	position += (get_global_mouse_position()-position) * 0.2
	look_at(Vector2(600,337.5))
	pass
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		shooting = true
	else:
		shooting = false
	if not on_cooldown and shooting:
		shoot()

func _input(_event):
	if Input.is_action_just_released("ui_accept"):
		change_mode()

func change_mode():
	$AnimationPlayer3.speed_scale = 1
	$AnimationPlayer3.play("Mode")
	if current_mode < 4:
		current_mode = current_mode + 1
	else:
		current_mode = 0
	update_ammo()
		#$Ammo.max_value = (-2*current_mode) + 10
		#$Ammo.value = modes[current_mode][1]
		#y = -2x + 10
func shoot():
	on_cooldown = true
	if modes[current_mode][1] < 2:
		$AnimationPlayer3.speed_scale = 1.0 / (0.75+(current_mode*(1.00-(0.25*(current_mode-1)))))
		$AnimationPlayer3.play("Reload")
	modes[current_mode][1] -= 1
	update_ammo()
	$Timer.start()
	if modes[current_mode][1] > -1:
		if current_mode == 0:
			var instance = bullet.instantiate()
			instance.position = position;	instance.rotation = rotation;
			instance.velocity = (Vector2(600,337.5) - position)
			get_parent().add_child(instance)
		elif current_mode == 1:
			var instance = orbit.instantiate()
			instance.position = position;	instance.rotation = rotation;
			get_parent().add_child(instance)
		elif current_mode == 2:
			var instance = turrent.instantiate()
			instance.position = position;	instance.rotation = rotation;
			get_parent().add_child(instance)
		elif current_mode == 3:
			var instance = scan.instantiate()
			instance.position = position
			instance.rotation = rotation;
			get_parent().add_child(instance)
		elif current_mode == 4:
			for i in 2:
				var instance = destruct.instantiate()
				instance.position = position
				get_parent().add_child(instance)

func _on_timer_timeout():
	on_cooldown = false

func _on_player_area_entered(area):
	if not str(area.name).contains("Player"):
		if str(area.name).contains("Enemy") or area.priority == 1:
			if health < 2:
				health -= 1
				get_parent().get_child(4).value = health
				$AnimationPlayer2.play("Die")
			else:
				$AnimationPlayer2.play("Hurt")
				health -= 1
				get_parent().get_child(4).value = health
func game_over():
	get_tree().paused = true
	get_parent().get_child(1).get_child(1).emitting = false

func retry():
	Game.restart()

func update_ammo():
	$Ammo.max_value = (current_mode - 4) * (current_mode - 4) + 1
	$Ammo.value = modes[current_mode][1]
	$Ammo.modulate = Color(modes[current_mode][2])
	$Timer.wait_time = (current_mode/4.0) + 0.10
	get_parent().get_child(5).text = str("Command: " + str(modes[current_mode][0])).capitalize()
	get_parent().get_child(5).modulate = Color(modes[current_mode][2])
func reload():
	modes[current_mode][1] = (current_mode - 4) * (current_mode - 4) + 1
	update_ammo()
