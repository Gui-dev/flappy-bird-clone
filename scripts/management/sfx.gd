extends AudioStreamPlayer2D
class_name SoundEffect


func _ready() -> void:
  play()


func _on_sfx_finished() -> void:
  queue_free()
