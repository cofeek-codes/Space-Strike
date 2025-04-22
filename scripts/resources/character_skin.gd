extends Resource

class_name CharacterSkin

@export var texture: AnimatedTexture
@export var price: int
@export var is_purchased: bool = false
@export var is_selected: bool = false
@export_custom(PROPERTY_HINT_LINK, 'scale:') var scale: Vector2 = Vector2.ONE # sprites can be of different sizes 
@export_custom(PROPERTY_HINT_LINK, 'collider_scale:') var collider_scale: Vector2 = Vector2.ONE # make collider match skin texture 
