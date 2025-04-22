extends Node

class_name ENV

static func is_purchases_avalable():
	return Bridge && Bridge.payments.is_supported
