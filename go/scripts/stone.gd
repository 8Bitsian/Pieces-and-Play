# Header
@icon("res://assets/icons/icon.svg")
class_name GoStones
extends Node2D

# Global Variables
@export var stone_color := Color.BLACK
@export var radius := 15.0

## Called when the node enters the scene tree for the first time.
func _draw() -> void:
	# Draw the stone
	draw_circle(Vector2.ZERO, radius, stone_color)
	draw_arc(Vector2.ZERO, radius, 0.0, TAU, 48, Color.BLACK, 1.0)
