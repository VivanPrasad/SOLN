extends CharacterBody2D

var i
var health = 6
var locked = false
var spawn = Vector2(randi() % 1200,randi() % 675)
func _ready():
	i = randi() % 3 + 1

func _process(_delta):
	if locked:
		look_at(get_parent().get_child(0).position)
		velocity = (get_parent().get_child(0).position - position).normalized() * i * 75
		move_and_slide()
	else:
		look_at(spawn)
		velocity = (spawn - position).normalized() * i * 75
		move_and_slide()

func _on_timer_timeout():
	locked = true

func _on_area_2d_area_entered(area):
	if str(area.name) == "Player":
		$AnimationPlayer.play("Die")
	elif str(area.name).contains("Bullet") and area.priority == 0:
		if health == 1:
			$AnimationPlayer.play("Die")
		else:
			$AnimationPlayer.play("Hurt")
		health -= 1
