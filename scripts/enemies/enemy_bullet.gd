extends Area2D


const SPEED = 300.0
const LIFETIME = 5

@onready var timer: Timer = $DispawnTimer

@onready var player: CharacterBody2D = get_node('../Player')

func _physics_process(delta: float) -> void:
	# print("in bullet")

	position -= transform.x * SPEED * delta




func _on_body_entered(body: Node2D) -> void:
	if body == player:
		print('bullet: player hit')
		print(body)
		queue_free()



func _on_dispawn_timer_timeout() -> void:
		print('enemy bullet dispawned after %d seconds' % timer.wait_time)
		queue_free()
