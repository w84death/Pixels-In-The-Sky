
extends Sprite


const RIGHT = 1
const LEFT = 0
const UP = 2
const DOWN = 3
const SPEED_X = 128
const SPEED_Y = 64
const TARGET_SPEED = 24
onready var target = self.get_pos()
const GAME_SPEED_INC = 2
const PLAYER_AREA_MARGINS = 48
var frame_up = 4
var frame_move = 5

onready var second_layer = self.get_node("second_layer")

func _ready():
	self.set_z(1000)
	pass

func move_ship(direction):
	var pos = self.get_pos()
	if direction == LEFT:
		self.target.x = pos.x - TARGET_SPEED
	if direction == RIGHT:
		self.target.x = pos.x + TARGET_SPEED
	if direction == UP and pos.y > PLAYER_AREA_MARGINS:
		self.target.y = pos.y - TARGET_SPEED
		Globals.set("GAME_SPEED", (OS.get_window_size().y - pos.y) * 0.1 )
	if direction == DOWN and pos.y < OS.get_window_size().y - PLAYER_AREA_MARGINS:
		self.target.y = pos.y + TARGET_SPEED
		Globals.set("GAME_SPEED", (OS.get_window_size().y - pos.y) * 0.1 )

func move(delta):
	var pos = self.get_pos()

	if pos.y > target.y:
		pos.y = pos.y - SPEED_Y * delta

	if pos.y < target.y:
		pos.y = pos.y + SPEED_Y * delta

	if pos.x > target.x:
		pos.x = pos.x - SPEED_X * delta
		self.set_frame(frame_move)
		self.second_layer.set_frame(frame_move)
		self.set_flip_h(true)

	if pos.x < target.x:
		pos.x = pos.x + SPEED_X * delta
		self.set_frame(frame_move)
		self.second_layer.set_frame(frame_move)
		self.set_flip_h(false)

	if abs(pos.x - target.x) < 4:
		self.set_frame(frame_up)
		self.second_layer.set_frame(frame_up)

	self.set_pos(pos)