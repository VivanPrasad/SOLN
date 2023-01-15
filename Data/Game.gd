extends Node

@onready var world = preload("res://Scenes/Game/World.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func restart():
	get_parent().get_child(1).queue_free()
	get_tree().get_root().add_child(world.instantiate())
	get_tree().paused = false
