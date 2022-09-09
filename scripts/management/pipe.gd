extends Node2D
class_name Pipe


onready var top_pipe = $top_pipe
onready var bottom_pipe = $bottom_pipe
onready var score_area = $score_area
export(int) var walk_speed
export(Array, String) var pipe_texture


func _ready() -> void:
  randomize()
  var random_number: int = randi() % pipe_texture.size()
  top_pipe.get_node('texture').texture = load(pipe_texture[random_number])
  bottom_pipe.get_node('texture').texture = load(pipe_texture[random_number])


func _physics_process(delta: float) -> void:
  position.x -= delta * walk_speed


func _on_notifier_screen_exited() -> void:
  queue_free()


func _on_score_area_body_entered(body: Bird) -> void:
  if body is Bird and body.global_position.x > score_area.global_position.x:
    get_tree().call_group('interface', 'update_score')
