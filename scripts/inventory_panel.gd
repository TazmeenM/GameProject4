class_name InventoryPanel extends Control

@onready var slot: Button = $InventorySlot
@onready var slot_2: Button = $InventorySlot2
@onready var slot_3: Button = $InventorySlot3
@onready var slot_4: Button = $InventorySlot4
@onready var slot_5: Button = $InventorySlot5
@onready var slot_6: Button = $InventorySlot6
@onready var slot_7: Button = $InventorySlot7
@onready var slot_8: Button = $InventorySlot8
@onready var slot_9: Button = $InventorySlot9
@onready var slot_10: Button = $InventorySlot10

static var slotSelected = 0

var inventorySlots = {
	"slot1": {
		"button": slot,
		"imagePath": "res://assets/sprites/speedPotion.png"
	}
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass




func _on_inventory_slot_pressed() -> void:
	slotSelected = 0


func _on_inventory_slot_2_pressed() -> void:
	slotSelected = 1


func _on_inventory_slot_3_pressed() -> void:
	slotSelected = 2


func _on_inventory_slot_4_pressed() -> void:
	slotSelected = 3


func _on_inventory_slot_5_pressed() -> void:
	slotSelected = 4


func _on_inventory_slot_6_pressed() -> void:
	slotSelected = 5


func _on_inventory_slot_7_pressed() -> void:
	slotSelected = 6


func _on_inventory_slot_8_pressed() -> void:
	slotSelected = 7


func _on_inventory_slot_9_pressed() -> void:
	slotSelected = 8


func _on_inventory_slot_10_pressed() -> void:
	slotSelected = 9
