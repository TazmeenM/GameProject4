extends CharacterBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@export var enemyName: String = "enemy1"
var direction = 0

const SPEED = 300.0
const JUMP_VELOCITY = -400.0


var imagePath = "res://assets/sprites/"


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	followPlayer()
	animate()

	move_and_slide()

func setEnemy() -> void:
	sprite_2d.texture = load(imagePath + enemyName + ".png")
	
func followPlayer() -> void:
	if (position.x - Inventory.positionX > 0):
		direction = -1
	elif (position.x - Inventory.positionX > 0):
		direction = 1
	velocity = direction * SPEED

func animate() -> void:
	if direction > 0:
		animated_sprite_2d.flip_h = false
	elif direction < 0:
		animated_sprite_2d.flip_h = true
	
	#For the animations for enemy movement
	if direction == 0:
		animated_sprite_2d.play(enemyName + "Standing")
	else:
		animated_sprite_2d.play(enemyName + "Walking")
	
