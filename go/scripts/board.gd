# Header
@icon("res://assets/icons/queen.svg")
class_name GoBoard
extends Node2D

# Global Variables
@export var stone_scene : PackedScene
@export var board_size := 19
@export var board_pixels := 600.0

var black_to_play := true
var occupied : Dictionary = {}

## Called when the node enters the scene tree for the first time.
func _draw() -> void:
	var step := board_pixels / float(board_size - 1)
	var board_rect := Rect2 (
		Vector2.ZERO,
		Vector2(board_pixels, board_pixels)
	)
	
	# Draw the board background
	draw_rect(
		Rect2(Vector2.ZERO, Vector2(board_pixels, board_pixels)),
		Color("d9a851")
	)
	
	# Draw the grid lines on the board background
	for index in range(board_size):
		var offset := index * step
		draw_line(Vector2(offset, 0), Vector2(offset, board_pixels), Color.BLACK, 1.0)
		draw_line(Vector2(0, offset), Vector2(board_pixels, offset), Color.BLACK, 1.0)

## Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton \
	and event.button_index == MOUSE_BUTTON_LEFT \
	and event.pressed:
		var step := board_pixels / float(board_size - 1)
		var point := to_local(event.position)
		
		# Find the nearest grid intersection.
		var x := roundi(point.x / step)
		var y := roundi(point.y / step)
		
		if x < 0 or x >= board_size \
		or y < 0 or y >= board_size:
			return
		
		var intersection := Vector2i(x, y)
		if occupied.has(intersection):
			return
		
		_place_stone(intersection, step)

## Place stones onto the board
func _place_stone(intersection: Vector2i, step: float) -> void:
	var stone = stone_scene.instantiate()
	stone.position = Vector2(intersection.x * step, intersection.y * step)
	stone.stone_color = Color.BLACK if black_to_play else Color.WHITE
	add_child(stone)
	
	occupied[intersection] = stone
	black_to_play = not black_to_play
