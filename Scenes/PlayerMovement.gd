extends Node2D


signal collision_event(actor, type)

@onready var ray = $RayCast2D

var tile_size = 32
var animation_speed = 3
var moving = false
var inputs = {
	"right": Vector2.RIGHT,
	"left": Vector2.LEFT,
	"up": Vector2.UP,
	"down": Vector2.DOWN
}


func _ready():
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size / 2
	
	var main_node = get_node("/root/Main")
	collision_event.connect(main_node.onCollisionEvent)


func _unhandled_input(event):
	for dir in inputs.keys():
		if event.is_action_pressed(dir):
			move(dir)


func move(dir):
	ray.target_position = inputs[dir] * tile_size
	ray.force_raycast_update()
	if !ray.is_colliding():
		position += inputs[dir] * tile_size
		print("Moving")
	else:
		var obj = ray.get_collider()
		collision_event.emit(self, obj, "walk_in")
		print("Not moving")
