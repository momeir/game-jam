class_name Player
extends CharacterBody2D

@export var speed : float = 200

func _physics_process(delta: float) -> void:
	var direction : Vector2 = Input.get_vector("left","right", "up", "down")
	
	velocity = direction * speed
	
	move_and_slide()
