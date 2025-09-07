extends Area2D

@onready var movement_timer: Timer = $MovementTimer
@onready var reset_timer: Timer = $ResetTimer
@onready var sprite_2d: Sprite2D = $Sprite2D



@export var direction: String = "left"
@export var spellName: String = "electricBall"

var originalPositionX = 0
var translatedPositionX = 0
var strength = 50
var distance = 100
var isMoving = false
var imageRoot= "res://assets/sprites/"
var collisionShapeRoot = "res://scenes/"
var collisionShapeEnding = "_collision_shape_2d.tscn"
var collider: CollisionShape2D

var spells = {
	"fireball": {
		"strength": 20,
		"distance": 300,
		"imagePath": imageRoot + "fireball" + ".png",
		"collisionShapePath": collisionShapeRoot + "fireball" + collisionShapeEnding
	},
	"electricBall": {
		"strength": 40,
		"distance": 500,
		"imagePath": imageRoot + "electricBall" + ".png",
		"collisionShapePath": collisionShapeRoot + "electric_ball" + collisionShapeEnding
	}
}

func _ready() -> void:
	print("Spell Ready")
	originalPositionX = position.x
	translatedPositionX = originalPositionX
	strength = spells[spellName]["strength"]
	distance = spells[spellName]["distance"]
	setSprite()
	setCollisionShape()
	sprite_2d.position.x = 0
	sprite_2d.position.y = 0
	collider.position.x = 0
	collider.position.y = 0
	
	#To add a small time frame between when the game loads and when the fireball starts moving
	reset()
	#movement_timer.start()

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
	if isMoving:
		if body is Enemy:
			body.decreaseHealth(strength)
			print("Decreased Enemy Health")
		reset()

func resetPosition() -> void:
	print("Spell Position Resetting")
	position.x = originalPositionX
	translatedPositionX = originalPositionX

func reset() -> void:
	isMoving = false
	sprite_2d.visible = false
	movement_timer.stop()
	resetPosition()
	reset_timer.start()

func setSprite() -> void:
	sprite_2d.texture = load(spells[spellName]["imagePath"])
	sprite_2d.position = Vector2(0, 0)
	
func setCollisionShape() -> void:
	if !collider:
		#collider.queue_free()
		var colliderLoader:PackedScene = load(spells[spellName]["collisionShapePath"])
		print(spells[spellName]["collisionShapePath"])
		collider = colliderLoader.instantiate()
		collider.position = Vector2(0, 0)
		add_child(collider)

func _on_reset_timer_timeout() -> void:
	reset_timer.stop()

func fireSpell() -> void:
	if reset_timer.is_stopped() and movement_timer.is_stopped():
		movement_timer.start()
		isMoving = true
		sprite_2d.visible = true
