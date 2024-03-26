extends CharacterBody2D

@onready var main = get_node("/root/Main")
@onready var player = get_node("/root/Main/Player")

var item_scene := preload("res://scenes/item.tscn")
var explosion_scene := preload("res://scenes/explosion.tscn")

signal hit_player

var alive : bool
var entered : bool
var speed : int = 100
var direction : Vector2
const DROP_CHANCE : float = 0.1

func _ready():
	var screen_rect = get_viewport_rect()
	alive = true
	entered = false
	# pick direction
	var dist = screen_rect.get_center() - position
	# check hori or verti
	if abs(dist.x) > abs(dist.y):
		direction.x = dist.x
		direction.y = 0
	else:
		direction.x = 0
		direction.y = dist.y

func _physics_process(_delta):
	if alive:
		$AnimatedSprite2D.animation = "run"
		if entered:
			direction = (player.position - position)
		direction = direction.normalized()
		velocity = direction * speed
		move_and_slide()
		if velocity.x != 0:
			$AnimatedSprite2D.flip_h = velocity.x < 0
	else:
		pass

func die():
	alive = false
	$AnimatedSprite2D.stop()
	$AnimatedSprite2D.animation = "dead"
	$Area2D/CollisionShape2D.set_deferred("disabled", true)
	if randf() <= DROP_CHANCE:
		drop_item()
	var explosion = explosion_scene.instantiate()
	explosion.position = position
	main.add_child(explosion) #doesnt collide so its ok to add_child
	explosion.process_mode = Node.PROCESS_MODE_ALWAYS
	
func drop_item():
	var item = item_scene.instantiate()
	item.position = position
	item.item_type = randi_range(0,2)
	main.call_deferred("add_child", item) 
	# above line only run after physics process complete to avoid errors
	item.add_to_group("items")
	
func _on_entrance_timer_timeout():
	entered = true

func _on_area_2d_body_entered(_body):
	hit_player.emit()
