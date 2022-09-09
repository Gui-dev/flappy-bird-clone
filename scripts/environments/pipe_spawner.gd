extends Position2D
class_name PipeSpawner


signal game_over
onready var timer: Timer = $timer
export(float) var spawn_cooldown
export(PackedScene) var pipe_scene 


func _ready() -> void:
  pass


func spawn() -> void:
  var pipe = pipe_scene.instance()
  pipe.global_position = random_position()
  var _game_over = connect('game_over', pipe, 'game_over')
  add_child(pipe)
  timer.start(spawn_cooldown)


func random_position() -> Vector2:
  randomize()
  var random_number: float = rand_range(-118, 62)
  
  return Vector2(0, random_number)
  

func game_over() -> void:
  timer.stop()
  emit_signal('game_over')


func _on_timer_timeout() -> void:
  spawn()
