extends Node

var numberOfPotions = 0

var potions = {
	"speedPotion": {
		"numberOfPotions": 0,
		"affectingInteger": 10
	},
	"healthPotion": {
		"numberOfPotions": 0,
		"affectingInteger": 5
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

func removePotions(numberOfPotionsRemoved: int, potionName: String) -> void:
	potions[potionName]["numberOfPotions"] -= numberOfPotionsRemoved
