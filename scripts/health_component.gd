class_name HealthComponent
extends Node

@export var max_hp : int = 100

var hp : int = max_hp

func deal_damage(damage : int) -> void:
	hp -= damage
