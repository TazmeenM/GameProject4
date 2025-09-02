extends Area2D

@onready var movement_timer: Timer = $MovementTimer
@onready var reset_timer: Timer = $ResetTimer
@export var direction: String

var originalPositionX = 0
var translatedPositionX = 0
var strength = 50
var isMoving = false

func _ready() -> void:
	isMoving = true
	originalPositionX = position.x
	translatedPositionX = originalPositionX
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


func reset() -> void:
	isMoving = false
	position.x = originalPositionX
	translatedPositionX = originalPositionX
	reset_timer.start()

func _on_reset_timer_timeout() -> void:
	reset_timer.stop()
	isMoving = true
