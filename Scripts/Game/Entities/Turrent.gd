extends CharacterBody2D

var health = 10
func _ready():
	pass
func _physics_process(_delta):
	move_and_slide()


func _on_timer_timeout():
	$Timer.wait_time = randf_range(0.1,0.5)
	velocity = Vector2(get_parent().get_child(0).position-position) * 0.9
	look_at(get_parent().get_child(0).position)

func _on_area_2d_area_entered(area):
	if str(area.name).contains("Enemy"):
		health -= 1
		if health == 0:
			queue_free()
