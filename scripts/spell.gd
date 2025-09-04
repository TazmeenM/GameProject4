extends Area2D

@onready var movement_timer: Timer = $MovementTimer
@onready var reset_timer: Timer = $ResetTimer
@export var direction: String

var originalPositionX = 0
var translatedPositionX = 0
var strength = 50
var isMoving = false

func _ready() -> void:
	originalPositionX = position.x
	translatedPositionX = originalPositionX
	
	#To add a small time frame between when the game loads and when the fireball starts moving
	reset()
	movement_timer.start()

func _process(delta: float) -> void:
	position.x = translatedPositionX


func _on_movement_timer_timeout() -> void:
	if isMoving:
		if direction == "right":
			translatedPositionX += 10
		elif direction == "left":
			translatedPositionX -= 10
		if abs(translatedPositionX - originalPositionX) > 300:
			reset()
		


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		Inventory.decreaseHealth(strength)

func resetPosition() -> void:
	position.x = originalPositionX
	translatedPositionX = originalPositionX

func reset() -> void:
	isMoving = false
	resetPosition()
	reset_timer.start()

func _on_reset_timer_timeout() -> void:
	reset_timer.stop()
	isMoving = true
