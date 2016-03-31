
extends Sprite


const SPEED_X = 120
const SPEED_Y = 30
const TARGET_SPEED = 30
onready var target = self.get_pos()

var frame_up = 4
var frame_move = 5

func _ready():
	self.set_z(1000)
	pass

func move_ship(direction):
	if direction == 0:
		self.target.x = self.get_pos().x - TARGET_SPEED
	if direction == 1:
		self.target.x = self.get_pos().x + TARGET_SPEED

func move(delta):
	var pos = self.get_pos()
	#pos.y = pos.y - SPEED_Y * delta

	if abs(pos.x - target.x) < 4:
		self.set_frame(frame_up)
		self.set_pos(pos)
		return

	if pos.x > target.x:
		self.set_pos(Vector2(pos.x - SPEED_X * delta, pos.y))
		self.set_frame(frame_move)
		self.set_flip_h(true)

	if pos.x < target.x:
		self.set_pos(Vector2(pos.x + SPEED_X * delta, pos.y))
		self.set_frame(frame_move)
		self.set_flip_h(false)