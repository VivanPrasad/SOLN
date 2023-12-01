extends Polygon2D

var inverse = false
var speed = 0.5
# Called when the node enters the scene tree for the first time.
func _ready():
	speed =  0.5 + float(20.0/get_parent().get_child(1).health)
	look_at(get_parent().get_child(0).position)
	rotation += int(randi() % 180 - 90)
	if randi() % 2 == 1:
		inverse = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	modulate.a -= 0.8 * delta * speed
	scale.y -= 2.5 * delta * speed
	if modulate.a < 0.1:
		queue_free()
	if inverse:
		rotation -= delta * speed
	else:
		rotation += speed * delta

