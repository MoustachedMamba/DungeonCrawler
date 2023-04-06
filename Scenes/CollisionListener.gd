extends Node2D


func onCollisionEvent(emitter, reciever, type):
	print("Collision event called")
	reciever.onCollisionEvent(emitter, reciever, type)
