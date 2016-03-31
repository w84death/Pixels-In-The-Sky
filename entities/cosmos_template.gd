
extends Sprite

const ASTEROIDS_DENISTY = 3
const STAR_DENISTY = 6
const STATIC_STARS = 3

var z_index = 0.1
var start_x = 0
var skin = 0
onready var pos = self.get_pos()
onready var second_layer = self.get_node("second_layer")

func _ready():
    randomize()
    self.random_skin(true)
    self.random_start_pos()

func random_start_pos():
    self.set_pos(Vector2(int(randi() % int(OS.get_window_size().x)), int(randi() % int(OS.get_window_size().y))))
    start_x = self.get_pos().x

func restart_pos():
    self.set_pos(Vector2(int(randi() % int(OS.get_window_size().x)), 0))
    start_x = self.get_pos().x

func random_skin(var init = false):
    if ( randi() % 10 ) <= STAR_DENISTY:
        skin = 0
    else:
        if !init and ( randi() % 10 ) <= ASTEROIDS_DENISTY:
            skin = 3 + int(randi() % 5)
        else:
            skin = 1 + int(randi() % 2)

    self.set_frame(skin)
    self.second_layer.set_frame(skin)
    z_index = 12 + (skin * 32) + int( randi() % 24)
    if init and skin == 0 and randi() % 10 < STATIC_STARS:
        z_index = 0
    self.set_z(z_index)

func move(delta):
    pos = self.get_pos()
    pos.x = start_x + ( Globals.get("PARRALAX") * z_index * -0.003)

    if z_index < 10:
        self.set_opacity(int(randi() % 2))
    else:
        pos.y = pos.y + ( Globals.get("GAME_SPEED") * delta * z_index ) * 0.1

    if pos.y > OS.get_window_size().y:
        self.restart_pos()
        self.random_skin()
    else:
        self.set_pos(pos)