extends Node2D


func _ready():
	pass


func _process(delta):
	pass


func _onCollisionEvent(emitter, reciever, type):
	if reciever.is_inside_tree():
		print("hi")
