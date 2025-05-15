extends Area2D
@export var escena_muerte: PackedScene  # Asigna la escena en el Inspector

func _ready():
	# Conecta la señal automáticamente
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.is_in_group("personatje_Blau"):
		cambiar_escena()
		queue_free()  # Elimina la bala

func cambiar_escena():
	if escena_muerte:
		# Método moderno para Godot 4
		get_tree().change_scene_to_packed(escena_muerte)
	else:
		printerr("¡No hay escena asignada en el Inspector!")
