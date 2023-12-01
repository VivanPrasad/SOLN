extends Polygon2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	scale.x += (500.0/scale.x)*delta+0.8;	scale.y += (500.0/scale.y)*delta+0.8;
	modulate.a -= 1.5 * delta
	if scale > Vector2(60,60):
		queue_free()
