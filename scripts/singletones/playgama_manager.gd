extends Node

func _ready():
	Bridge.game.connect("visibility_state_changed", _on_visibility_state_changed)


func unpause():
	Bridge.platform.send_message(Bridge.PlatformMessage.GAMEPLAY_STARTED)
	get_tree().paused = false
	AudioServer.set_bus_mute(0, false)
	
func pause():
	Bridge.platform.send_message(Bridge.PlatformMessage.GAMEPLAY_STOPPED)
	get_tree().paused = true
	AudioServer.set_bus_mute(0, true)


func _on_visibility_state_changed(state):
	print('visibility state changed: %s' % state)
	if state == "hidden":
		pause()
	else:
		unpause()
