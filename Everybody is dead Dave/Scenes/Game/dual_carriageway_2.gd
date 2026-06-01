extends BaseScene

var global_timer




const CAR_TYPES = [
	preload("res://Scenes/Mob/blue_car_slow.tscn"),
	preload("res://Scenes/Mob/green_car_slow.tscn"),
	preload("res://Scenes/Mob/yellow_car_slow.tscn"),
	preload("res://Scenes/Mob/red_car_slow.tscn")
]

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
	super()
	var hud = get_node("/root/HudManager")  # however you access your UI layer
	hud.show_hud()
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







	

func spawn_car(spawn_point: Path2D, car_pool: Array, delay: float, velocity: float, flip: bool = false):
	await get_tree().create_timer(delay).timeout
	var new_car = car_pool.pick_random().instantiate()
	new_car.speed = velocity
	spawn_point.add_child(new_car)
	if flip:
		new_car.flip_sprite()

func _on_car_timer_timeout():
	spawn_car(%CarSpawn1, CAR_TYPES, randf_range(0.05, 0.4), 0.3)
	spawn_car(%CarSpawn2, CAR_TYPES, randf_range(0.05, 0.4), 0.5)
	spawn_car(%CarSpawn3, CAR_TYPES, randf_range(0.05, 0.4), 0.5, true)
	spawn_car(%CarSpawn4, CAR_TYPES, randf_range(0.05, 0.4), 0.3, true)
