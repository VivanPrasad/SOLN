extends CharacterBody2D

var explosive
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not explosive:
		move_and_collide(2*velocity*delta)
		if global_position > Vector2(1200,675) or global_position < Vector2(0,0):
			queue_free()
func _on_area_2d_area_entered(area):
	if not str(area.name).contains("Player") and $Bullet.priority == 0:
		queue_free()
	elif $Bullet.priority == 1 and str(area.name).contains("Player"): 
		queue_free()

func update():
	$Bullet.priority = 1
	scale = Vector2(2,2)
	$AnimationPlayer.speed_scale = -0.5
	
