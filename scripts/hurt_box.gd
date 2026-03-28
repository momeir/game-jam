class_name HurtBox
extends Area2D

@export var health_component : HealthComponent
@export var invincibility_delay : float = 0.1

var is_invincible : bool = false
var invincible_timer : SceneTreeTimer = null

func _ready() -> void:
	area_entered.connect(_on_area_entered)

func _on_area_entered(area : Area2D) -> void:
	if area is HitBox and not is_invincible:
		health_component.deal_damage(area.damage)
		is_invincible = true
		invincible_timer = get_tree().create_timer(invincibility_delay)
