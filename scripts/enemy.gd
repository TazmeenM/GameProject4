extends CharacterBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var ray_cast_2d_right: RayCast2D = $RayCast2DRight
@onready var ray_cast_2d_left: RayCast2D = $RayCast2DLeft

@export var enemyName: String = "enemy1"
var direction = 0

const SPEED = 100.0
const JUMP_VELOCITY = -400.0


var imagePath = "res://assets/sprites/"
var collisionShapeRoot = "res://scenes/"
var collisionShapeEnding = "_collision_shape_2d.tscn"
var collider: CollisionShape2D

var enemies = {
	"enemy1": {
		"strength": 10,
		"follow": true,
		"imagePath": imagePath + "enemy1" + ".png",
		"collisionShapePath": collisionShapeRoot + "enemy_1" + collisionShapeEnding
	}
}

func _ready() -> void:
	setCollisionShape()

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	followPlayer()
	animate()

	move_and_slide()
	
func setCollisionShape() -> void:
	if !collider:
		#collider.queue_free()
		var colliderLoader:PackedScene = load(enemies[enemyName]["collisionShapePath"])
		print(enemies[enemyName]["collisionShapePath"])
		collider = colliderLoader.instantiate()
		collider.position = Vector2(0, 0)
		add_child(collider)
	
func followPlayer() -> void:
	if (position.x - Inventory.positionX > 0):
		direction = -1
	elif (position.x - Inventory.positionX < 0):
		direction = 1
	velocity.x = direction * SPEED
	if ray_cast_2d_right.is_colliding() or ray_cast_2d_left.is_colliding():
		if ray_cast_2d_right.get_collider() is TileMap or ray_cast_2d_left.get_collider() is TileMap:
			jump()

func jump() -> void:
	velocity.y = JUMP_VELOCITY

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
	
