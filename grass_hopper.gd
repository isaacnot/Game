extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@onready var image_1__1_: Sprite2D = $"Image(1)(1)"


const SPEED = 130.0
const JUMP_VELOCITY = -250.0
@onready var attack_up: CollisionShape2D = $"attack/attack up"
@onready var attack_bakwords: CollisionShape2D = $"attack/attack bakwords"
@onready var attack_forward: CollisionShape2D = $"attack/attack forward"
@onready var attack_timer: Timer = $"attack timer"
@onready var animated_sprite_2d_2: AnimatedSprite2D = $AnimatedSprite2D2


func _ready() -> void:
	attack_forward.disabled=true
	attack_bakwords.disabled=true
	attack_up.disabled=true
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("attack bakwords"):
		animated_sprite_2d_2.play("shot")
		attack_forward.disabled=false
		attack_timer.start()
	if Input.is_action_just_pressed("Attack forward"):
		animated_sprite_2d_2.play("shot")
		attack_bakwords.disabled=false
		attack_timer.start()
	if Input.is_action_just_pressed("attack up"):
		animated_sprite_2d_2.play("shot")
		attack_up.disabled=false
		attack_timer.start()
	if Input.is_action_just_pressed("move up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move left", "move right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	if direction > 0:
		animated_sprite_2d.flip_h = false
		animated_sprite_2d_2.flip_h= false
	elif  direction < 0:
		animated_sprite_2d.flip_h = true
		animated_sprite_2d_2.flip_h= true
		
	if is_on_floor():
		if direction == 0:
			animated_sprite_2d.play("Idle")
		else:
			animated_sprite_2d.play("run")
	else:
		animated_sprite_2d.play("jump")


func _on_attack_timer_timeout() -> void:
	attack_forward.disabled=true
	attack_bakwords.disabled=true
	attack_up.disabled=true
	animated_sprite_2d_2.play("Idle")
	
		
