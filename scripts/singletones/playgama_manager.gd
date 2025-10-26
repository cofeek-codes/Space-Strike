extends Node

func _ready():
	Bridge.game.connect("visibility_state_changed", _on_visibility_state_changed)


func unpause():
	get_tree().paused = false
	PauseMenu.hide()
	Bridge.platform.send_message(Bridge.PlatformMessage.GAMEPLAY_STARTED)
	
func pause():
	get_tree().paused = true
	PauseMenu.show()
	PauseMenu.open.emit()
	Bridge.platform.send_message(Bridge.PlatformMessage.GAMEPLAY_STOPPED)


func _on_visibility_state_changed(state):
	print('visibility state changed: %s' % state)
	if state == "hidden":
		pause()
		AudioServer.set_bus_mute(0, true)
		
	else:
		unpause()
		AudioServer.set_bus_mute(0, false)
		
