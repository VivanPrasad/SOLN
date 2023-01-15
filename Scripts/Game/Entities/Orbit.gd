extends Polygon2D

var locked = false
var health = 3
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not locked:		
		position += (get_parent().get_child(0).position - position).normalized() * 3.0
		offset.x -= delta * 10
		$Player.position.x = offset.x
	else:
		#look_at(Vector2(600,337.5))
		position += (Vector2(600,337.5) - position).normalized() * 2.0
		#offset.x -= delta
		#$Player.position.x = offset.x
	rotation += 5.0 * delta
	scale -= Vector2(delta*0.05,delta*0.05)
	if scale < Vector2(0.7,0.7):
		locked = true
func _on_player_area_entered(area):
	if str(area.name).contains("Enemy"):
		if area.priority == 1:
			pass
		locked = true
		health -= 1
		scale -= Vector2(0.1,0.1)
		if health == 0:
			queue_free()
	elif str(area.name).contains("Player"):
		locked = false


func _on_timer_timeout():
	locked = true
