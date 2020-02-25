extends KinematicBody2D

const VELX = 500
const GRAV = 1500

var velocity = Vector2(0,0)
var jump = false
var jump_release = false
var was_on_floor = false
var ending = false
var pulo_mola = false

func _ready():
	set_physics_process(true)
	add_to_group("player")

func _physics_process(delta):
	if not ending:
		#Gravidade
		velocity.y += GRAV * delta
		velocity.x = VELX
		velocity = move_and_slide(velocity, Vector2(0, -1))
		
		if is_on_floor():
			if not was_on_floor:
				$animation.play("player_elastico")
				$animation.play("dust")
			$anim.play("walk")
			if jump:
				velocity.y = -1000
				$sound_jump.play()
		else:
			$anim.play("jump")
			if jump_release:
				velocity.y *= .3
				
		if pulo_mola:
			velocity.y = -1200
			$sound_jump.play()
		
		#$dust.hide()
		was_on_floor = is_on_floor()
		jump = false
		jump_release = false
		pulo_mola = false
	
func _input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			jump = true
		else:
			jump_release = true

func happy():
	$anim.play("victory")
	ending = true

func pulo_mola():
	pulo_mola = true