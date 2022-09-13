extends KinematicBody2D
class_name Bird


signal game_over
var velocity: Vector2
var can_interact: bool = true
onready var bird_texture: Sprite = $texture
onready var animation: AnimationPlayer = $animation
export(Array, String) var texture_list
export(int) var gravity_speed
export(int) var jump_speed
export(PackedScene) var sfx_scene


func _ready() -> void:
  set_texture()
  set_physics_process(false)
  

func _physics_process(delta: float) -> void:
  velocity.y += gravity_speed * delta
  
  if velocity.y > gravity_speed:
    velocity.y = gravity_speed
    
  if Input.is_action_just_pressed('ui_select') and can_interact:
    velocity.y = jump_speed
    spawn_sfx('res://assets/sfx/swoosh.ogg')
    
  velocity = move_and_slide(velocity)


func start() -> void:
  animation.play('idle')
  set_physics_process(true)


func set_texture() -> void:
  randomize()
  var random_number: int = randi() % texture_list.size()
  bird_texture.texture = load(texture_list[random_number])
  

func spawn_sfx(effect: String) -> void:
  var sfx: SoundEffect = sfx_scene.instance()
  sfx.stream = load(effect)
  get_tree().root.call_deferred('add_child', sfx)


func _on_detection_area_body_entered(body: Object) -> void:
  if body.name != 'Bird':
    velocity.x = 0
    can_interact = false
    spawn_sfx('res://assets/sfx/hit.ogg')
    animation.play('RESET')
    emit_signal('game_over') 
