extends Polygon2D

var health = 500
@onready var enemy = preload("res://Scenes/Game/Entities/Enemy.tscn")
@onready var bullet = preload("res://Scenes/Game/Entities/Bullet.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent().get_child(3).max_value = health
	get_parent().get_child(3).value = health
	$GPUParticles2D.speed_scale = (750.0/(health+1.0)) - 0.5
func _on_timer_timeout():
	var e = enemy.instantiate()
	e.position = position
	get_parent().add_child(e)
	var s = bullet.instantiate()
	s.update()
	s.position = position;	s.rotation = position.angle_to_point(owner.get_child(0).position);
	s.velocity = (owner.get_child(0).position - position) * 0.8
	get_parent().add_child(s)
	
	randomize()
	$Timer.wait_time = float(health / 500.0) + randf_range(0.00,0.50)

func _on_area_2d_area_entered(area):
	if str(area.name).contains("Bullet") or str(area.name).contains("Player"):
		if area.priority == 0:
			$AnimationPlayer2.play("Hurt")
			health -= 1
			get_parent().get_child(3).value = health
			$GPUParticles2D.speed_scale = (750/(health+1)) - 0.5
	if health == 0:
		get_tree().paused = true
		$GPUParticles2D.emitting = false
		$AnimationPlayer.stop()
		#Game.restart()
		owner.get_child(6).visible = true
		queue_free()
