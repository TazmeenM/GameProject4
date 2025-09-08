class_name Killzone extends Area2D

@onready var respawn_timer: Timer = $RespawnTimer
@export var level: Level

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		Inventory.decreaseHealth(100)
		print("Player killed")
