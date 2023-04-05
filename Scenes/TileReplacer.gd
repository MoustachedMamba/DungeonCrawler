extends TileMap


var floor_tile = Vector2i(1, 3)
@onready var half_cell_size := Vector2(16, 16)
@export var TILE_SCENES := {
	"Wall" = [preload("res://Scenes/Map/Wall.tscn"), [0, 3]],
	"Door_closed" = [preload("res://Scenes/Map/Door.tscn"), [4, 3]],
	"Door_open" = [preload("res://Scenes/Map/Door.tscn"), [5, 3]]
}


func _ready():
	_replace_tiles_with_scenes()


func _replace_tiles_with_scenes(scene_dict: Dictionary = TILE_SCENES):
	for tile_pos in get_used_cells(0):
		var data = get_cell_tile_data(0, tile_pos)
		for key in scene_dict.keys():
			if data and data.get_custom_data(key) == true:
				var obj_scene = scene_dict[key][0]
				_replace_tile_with_object(tile_pos, obj_scene)


func _replace_tile_with_object(tile_pos: Vector2, object_scene: PackedScene, parent: Node = get_tree().current_scene):
	set_cell(0, tile_pos, 1, floor_tile)
	
	if object_scene:
		var obj = object_scene.instantiate()
		var obj_pos = map_to_local(tile_pos)
		
		call_deferred("add_child", obj)
		obj.global_position = to_global(obj_pos)
