extends Level

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_tree().root.get_children():
		print(child.name)
