extends StaticBody2D

func _ready():
	$collision.polygon = $poly.polygon
