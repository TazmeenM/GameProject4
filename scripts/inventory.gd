extends Node

var numberOfPotions = 0
var health = 100
var positionX = 0
var positionY = 0
var imageRoot = "res://assets/sprites/"
var slotSelected = 0

var potions = {
	"speedPotion": {
		"itemNumber": 0,
		"numberOfPotions": 0,
		"numberOfPotionsThisLevel": 0,
		"affectingInteger": 10,
		"imagePath": imageRoot + "speedPotion" + ".png"
	},
	"healthPotion": {
		"itemNumber": 1,
		"numberOfPotions": 0,
		"numberOfPotionsThisLevel": 0,
		"affectingInteger": 5,
		"imagePath": imageRoot + "healthPotion" + ".png"
	}
}



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func addPotions(numberOfPotionsAdded: int, potionName: String) -> void:
	potions[potionName]["numberOfPotions"] += numberOfPotionsAdded
	potions[potionName]["numberOfPotionsThisLevel"] += numberOfPotionsAdded

func removePotions(numberOfPotionsRemoved: int, potionName: String) -> void:
	potions[potionName]["numberOfPotions"] -= numberOfPotionsRemoved
	potions[potionName]["numberOfPotionsThisLevel"] -= numberOfPotionsRemoved

func increaseHealth(healthIncreasedAmount: int) -> void:
	if health + healthIncreasedAmount < 100:
		health = health + healthIncreasedAmount
	else:
		health = 100

func decreaseHealth(healthDecreasedAmount: int) -> void:
	if health - healthDecreasedAmount > 0:
		health = health - healthDecreasedAmount
	else:
		health = 0

func reset() -> void:
	health = 100
	for potion in potions:
		potions[potion]["numberOfPotions"] -= potions[potion]["numberOfPotionsThisLevel"]
		potions[potion]["numberOfPotionsThisLevel"] = 0
