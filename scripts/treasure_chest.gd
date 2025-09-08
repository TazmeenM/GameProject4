extends Area2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var item_earned_label: Label = $ItemEarnedLabel
@onready var item_earned_label_timer: Timer = $ItemEarnedLabelTimer
@onready var change_scene_timer: Timer = $ChangeSceneTimer

static var treasureChestOpened = false
var treasureChestAreaEntered = false
var labelIndex = 0

var treasureChestItems = ["+4 Health Potion", "+2 Speed Potion", "Health Filled"]

func _ready() -> void:
	item_earned_label.visible = false


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("openTreasureChest") and treasureChestAreaEntered and treasureChestOpened == false:
		print("Opened")
		openTreasureChest()
		


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		print("Player Entered")
		treasureChestAreaEntered = true


func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		print("Player Exited")
		treasureChestAreaEntered = false


func openTreasureChest() -> void:
	sprite_2d.texture = load("res://assets/sprites/treasureChestOpened.png")
	treasureChestOpened = true
	Inventory.addPotions(2, "speedPotion")
	Inventory.addPotions(4, "healthPotion")
	Inventory.health = 100
	item_earned_label.visible = true
	item_earned_label_timer.start()
	


func _on_items_earned_label_timer_timeout() -> void:
	item_earned_label.visible = true
	labelIndex += 1
	if (labelIndex < treasureChestItems.size()):
		item_earned_label.text = treasureChestItems[labelIndex]
		if (labelIndex == treasureChestItems.size() - 1):
			change_scene_timer.start()
	


func _on_change_scene_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://scenes/chest_opening_cutscene.tscn")
