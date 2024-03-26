extends Area2D

@onready var main = get_node("/root/Main")
@onready var lives_label = get_node("/root/Main/Hud/LiveLabel")

var item_type : int # 0: Coffee 1: Health 2: Gun

var coffee_box = preload("res://assets/items/coffee_box.png")
var health_box = preload("res://assets/items/health_box.png")
var gun_box = preload("res://assets/items/gun_box.png")
var textures = [coffee_box, health_box, gun_box]

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite2D.texture = textures[item_type] # decided by Goblin

func _on_body_entered(body):
	if item_type == 0:
		body.boost()
	elif item_type == 1:
		main.lives += 1
		lives_label.text = "x " + str(main.lives)
	elif item_type == 2:
		body.quick_fire()
	queue_free()
