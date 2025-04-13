extends Area2D

class_name BaseBuff

@export var title: String
@export var duration: int

@onready var sprite: Sprite2D = $Sprite
@onready var collider: CollisionShape2D = $Collider
@onready var timer: Timer = $Timer

func _ready() -> void:
	timer.wait_time = duration

func activate():
	print("activated buff %s for %d" % self.title, self.duration)

func deactivate():
	print("buff %s deactivated" % self.title)
	
	


func _on_timer_timeout() -> void:
	deactivate()
