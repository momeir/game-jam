class_name Monster
extends CharacterBody2D

@export var speed : float = 200

@onready var player : Player = get_tree().get_first_node_in_group("player")

func _physics_process(delta: float) -> void:
	var direction : Vector2 = global_position.direction_to(player.global_position)
	
	velocity = direction * speed
	
	move_and_slide()
