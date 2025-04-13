extends Area2D

const BUFF_SPAWN_DISTANCE = 300

@onready var player: CharacterBody2D = $"../Player"


func _ready() -> void:
	var tween = create_tween().set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "position:x", self.position.x - BUFF_SPAWN_DISTANCE, 1)



func activate():
	pass


func _on_body_entered(body: Node2D) -> void:
	if body == player:
		queue_free()
