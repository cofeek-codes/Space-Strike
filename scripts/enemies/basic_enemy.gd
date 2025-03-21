extends Area2D

const SPEED = 200.0

@onready var player = get_node('../Player') 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position = position.move_toward(player.position, SPEED * delta)
