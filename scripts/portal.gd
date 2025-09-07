extends Area2D

@export var sceneTeleportedTo: String

var baseDirectory = "res://scenes/"


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		for potion in Inventory.potions:
			Inventory.potions[potion]["numberOfPotions"] = Inventory.potions[potion]["numberOfPotionsThisLevel"]
			Inventory.potions[potion]["numberOfPotionsThisLevel"] = 0
		get_tree().change_scene_to_file(baseDirectory + sceneTeleportedTo + ".tscn")
