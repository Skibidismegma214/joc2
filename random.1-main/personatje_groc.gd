extends CharacterBody2D
@onready var shoot_point = $ShootPoint
@onready var bullet = $Bullet

var bullet_speed = 1200.0
var bullet_direction = Vector2.LEFT
var bullet_direccio
var bullet_active = false


var velocitat := 200
var gravetat := Vector2.DOWN * 988
var salt := -700
var salts_disponibles = max_salts
var max_salts = 2

func _ready() -> void:
	pass
func _process(delta: float) -> void:
	#Bola2.rotation += 0.2*delta
	var dx = Input.get_axis("moure_esquerra_groc", "moure_dreta_groc")
	velocity.x = 0
	velocity.x += dx * velocitat
	
	if Input.is_action_just_pressed("moure_dalt_groc") and salts_disponibles > 0:
		velocity.y += salt
		salts_disponibles -= 1
	
	velocity += gravetat *  delta
	move_and_slide()
	anima(velocity, delta)
	
	if is_on_floor():
		salts_disponibles = max_salts
		
	if Input.is_action_just_pressed("Disparar_groc") and not bullet_active:
		shoot_bullet()

	# Mover la bala si está activa
	if bullet_active:
		bullet.global_position += bullet_direction * bullet_speed * delta
	
	if Input.is_action_just_pressed("moure_dreta_groc"):
		bullet_direccio =  'dreta'
	if Input.is_action_just_pressed("moure_esquerra_groc"):
		bullet_direccio =  'esquerra'
	
	
func anima(desplaçament: Vector2, delta: float):
	if Input.is_action_pressed("moure_dreta_groc"):
		$AnimatedSprite2D.play("AnimacioDreta")
	elif Input.is_action_just_released("moure_dreta_groc"):
		$AnimatedSprite2D.stop()
		$AnimatedSprite2D.frame = 0
	if Input.is_action_pressed("moure_esquerra_groc"):
		$AnimatedSprite2D.play("AnimacioEsquerra")
	elif Input.is_action_just_released("moure_esquerra_groc"):
		$AnimatedSprite2D.stop()
		$AnimatedSprite2D.frame = 0
#	if Input.is_action_just_pressed("Disparar_groc"):
#		$AnimatedSprite2D.play("AnimacioDisparar")
#		await get_tree().create_timer(0.5).timeout
#		$AnimatedSprite2D.stop()

	# Dirección según a dónde mire el personaje
func shoot_bullet():
	if bullet_direccio == 'dreta':
		bullet_direction = Vector2.RIGHT
	if bullet_direccio == 'esquerra':
		bullet_direction = Vector2.LEFT
	# Activar bala y colocarla en el punto de disparo
	bullet.global_position = shoot_point.global_position
	bullet.visible = true
	bullet_active = true
	await get_tree().create_timer(1.8).timeout
	bullet.visible = false
	bullet_active = false
func _on_bullet_body_entered(body: Node2D) -> void:
	print('ok')
