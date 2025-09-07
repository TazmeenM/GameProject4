class_name Enemy extends CharacterBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var ray_cast_2d_right: RayCast2D = $RayCast2DRight
@onready var ray_cast_2d_left: RayCast2D = $RayCast2DLeft
@onready var attack_timer: Timer = $AttackTimer
@onready var progress_bar: ProgressBar = $ProgressBar

@export var enemyName: String = "enemy1"
var direction = 0
var health = 100

const SPEED = 100.0
const JUMP_VELOCITY = -400.0


var imagePath = "res://assets/sprites/"
var collisionShapeRoot = "res://scenes/"
var collisionShapeEnding = "_collision_shape_2d.tscn"
var collider: CollisionShape2D
var attacking = true

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
	attacking = true

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	progress_bar.max_value = 100
	progress_bar.value = health
	if health <= 0:
		die()

	followPlayer()
	animate()
	#Checking if the enemy is colliding with/getting stuck on a part of the TileMap, and jumping if it is
	if ray_cast_2d_right.is_colliding() or ray_cast_2d_left.is_colliding():
		if ray_cast_2d_right.get_collider() is TileMap or ray_cast_2d_left.get_collider() is TileMap:
			jump()
		elif ray_cast_2d_right.get_collider() is Player or ray_cast_2d_left.get_collider() is Player:
			print("Attacking")
			if attacking:
				Inventory.decreaseHealth(enemies[enemyName]["strength"])
				attacking = false
				attack_timer.start()
				

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
	


func _on_attack_timer_timeout() -> void:
	attacking = true


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


func die() -> void:
	queue_free()
