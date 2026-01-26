extends BaseScene

var global_timer


const LightTexture = preload("res://Sprites/Light.png")
const GRID_SIZE = 32

@onready var fog = $Fog
@onready var explosion: AudioStreamPlayer2D = $Audio/GameOver
@onready var music: AudioStreamPlayer2D = $Audio/Music


var display_width = 3500
var display_height = 3000

var fogImage = Image.new()
var fogTexture = ImageTexture.new()
var lightImage = LightTexture.get_image()
var light_offset = Vector2(LightTexture.get_width()/2, LightTexture.get_height()/2)

func _ready():
	music.play()
	var fog_image_width: int = int(display_width / GRID_SIZE)
	var fog_image_height: int = int(display_height / GRID_SIZE)
	fogImage = Image.create(fog_image_width, fog_image_height, false, Image.FORMAT_RGBAH)
	fogImage.fill(Color.BLACK)
	lightImage.convert(Image.FORMAT_RGBAH)
	fog.scale *= GRID_SIZE
	GlobalTimer.timer.timeout.connect(_on_timer_timeout)
	GlobalTimer.start_timer()
	MobManager.total_mobs_spawned = 0

func update_fog(new_grid_position):
	var light_rect = Rect2(Vector2.ZERO, Vector2(lightImage.get_width(), lightImage.get_height()))
	fogImage.blend_rect(lightImage, light_rect, new_grid_position - light_offset)

	update_fog_image_texture()

func update_fog_image_texture():
	fogTexture = ImageTexture.create_from_image(fogImage)
	fog.texture = fogTexture

func _physics_process(delta: float) -> void:
		update_fog(player.global_position/GRID_SIZE)

func _on_timer_timeout():
	get_tree().change_scene_to_file("res://Scenes/Game/game_over.tscn")
	#explosion.play()
	#explosion.finished.connect(_on_explosion_finished)  # Connect the signal using new syntax

#
#func _on_explosion_finished():
	#get_tree().change_scene_to_file("res://game_over.tscn")
