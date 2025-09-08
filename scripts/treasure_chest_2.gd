extends Area2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collect_keys_label: Label = $CollectKeysLabel
@onready var collect_keys_label_timer: Timer = $CollectKeysLabelTimer
@onready var change_scene_timer: Timer = $ChangeSceneTimer

static var treasureChestOpened = false
var treasureChestAreaEntered = false
var canBeOpened = false
var labelIndex = 0

func _ready() -> void:
	collect_keys_label.visible = false


func _process(delta: float) -> void:
	if Inventory.numberOfKeys == 2:
		canBeOpened = true
	if Input.is_action_just_pressed("openTreasureChest") and treasureChestAreaEntered and treasureChestOpened == false and canBeOpened:
		print("Opened")
		openTreasureChest()
	elif Input.is_action_just_pressed("openTreasureChest") and treasureChestAreaEntered and treasureChestOpened == false and !canBeOpened:
		collect_keys_label.visible = true
		collect_keys_label_timer.start()


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
	

func _on_collect_keys_label_timer_timeout() -> void:
	collect_keys_label.visible = false


func _on_change_scene_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://scenes/chest_opening_cutscene.tscn")
