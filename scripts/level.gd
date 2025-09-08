class_name Level extends Node2D

@export var player: Player
@export var respawn_timer: Timer
@export var fireball: Area2D


var isResetting = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if InventoryPanel.slotSelected == 0:
		if Input.is_action_just_pressed("usePotion") and Inventory.potions["speedPotion"]["numberOfPotions"] > 0 and player.potionAffecting == false:
			speedPotionUsed()
	elif InventoryPanel.slotSelected == 1:
		if Input.is_action_just_pressed("usePotion") and Inventory.potions["healthPotion"]["numberOfPotions"] > 0:
			healthPotionUsed()
	if Inventory.health == 0 and !isResetting:
		respawn_timer.start()
		fireball.movement_timer.stop()
		fireball.resetPosition()
		isResetting = true
		print("Resetting")
	elif Inventory.health == 0 and isResetting:
		print("Already Resetting")
		

func _on_respawn_timer_timeout() -> void:
	print("Respawn Timer Timeout")
	isResetting = false
	respawn_timer.stop()
	Inventory.reset()
	get_tree().reload_current_scene()
	
func speedPotionUsed() -> void:
	Inventory.removePotions(1, "speedPotion")
	player.potionAffecting = true
	player.potion_timer.start()

func healthPotionUsed() -> void:
	Inventory.removePotions(1, "healthPotion")
	player.increaseHealth(Inventory.potions["healthPotion"]["affectingInteger"])
