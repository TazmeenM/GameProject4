class_name Player extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var potion_timer: Timer = $PotionTimer
#@onready var health_timer: Timer = $HealthTimer
@onready var progress_bar: ProgressBar = $ProgressBar


var potionAffecting = false
#var health = 100

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _ready() -> void:
	pass #health_timer.start()

func _physics_process(delta: float) -> void:
	progress_bar.max_value = 100
	progress_bar.value = Inventory.health
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		if potionAffecting:
			velocity.y = velocity.y * 1.5

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#Getting the direction the player is moving in
	var direction := Input.get_axis("moveLeft", "moveRight")
	
	#Changing the animation direction based on the direction faced.
	if direction > 0:
		animated_sprite_2d.flip_h = false
	elif direction < 0:
		animated_sprite_2d.flip_h = true
	
	#For the animations for player movement
	if direction == 0:
		animated_sprite_2d.play("standing")
	else:
		animated_sprite_2d.play("walking")
	
	#Moving left or right
	if direction:
		velocity.x = direction * SPEED
		if potionAffecting:
			velocity.x = velocity.x * 2
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	Inventory.positionX = position.x
	Inventory.positionY = position.y


func _on_potion_timer_timeout() -> void:
	potionAffecting = false


#func _on_health_timer_timeout() -> void:
#	decreaseHealth(1)
#	print("Health Decreased")

func increaseHealth(healthIncreasedAmount: int) -> void:
	Inventory.increaseHealth(healthIncreasedAmount)
	progress_bar.max_value = 100
	progress_bar.value = Inventory.health

func decreaseHealth(healthDecreasedAmount: int) -> void:
	Inventory.increaseHealth(healthDecreasedAmount)
	progress_bar.max_value = 100
	progress_bar.value = Inventory.health
