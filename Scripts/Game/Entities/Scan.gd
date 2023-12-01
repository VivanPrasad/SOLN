extends Polygon2D

var locked = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.wait_time = randf_range(0.5,2.0)
	$Timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if locked:
		$AnimationPlayer.play("Flash")
		modulate.a -= 0.8*delta
		#look_at(Vector2(600,338))
	position = get_parent().get_child(0).position


func _on_timer_timeout():
	if not locked:
		$AnimationPlayer.stop()
		#look_at(Vector2(600,338))
		locked = true
		$Timer.wait_time = 1.5
		$Timer.start()
	else:
		queue_free()
