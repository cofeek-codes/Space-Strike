extends CharacterBody2D

# Movement speed constants
var horizontal_speed = 500.0
var vertical_speed = 300.0

@onready var animationPlayer: AnimatedSprite2D = $AnimationPlayer 

func movement():
		# horizontal movement
	var horizontal_input = Input.get_axis("move_left", "move_right")
	velocity.x = horizontal_input * horizontal_speed
	
	# vertical movement
	var vertical_input = Input.get_axis("move_up", "move_down")
	velocity.y = vertical_input * vertical_speed
	
	move_and_slide()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	movement()
