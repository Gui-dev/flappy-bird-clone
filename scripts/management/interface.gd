extends CanvasLayer
class_name Interface


signal start_game
var score: int = 0
onready var animation: AnimationPlayer = $animation
onready var score_container: Control = $score_container
onready var message_container: Control = $message_container
export(PackedScene) var sfx_scene


func _ready() -> void:
  score_container.visible = false
  animation.play('fade_out')
  
  for button in message_container.get_children():
    button.connect('pressed', self, 'on_button_pressed', [button])
    

func update_score() -> void:
  score += 1
  spawn_sfx('res://assets/sfx/point.ogg')
  score_container.get_node('text').text = str(score)
  

func game_over() -> void:
  message_container.get_node('game_over').show()


func spawn_sfx(effect: String) -> void:
  var sfx: SoundEffect = sfx_scene.instance()
  sfx.stream = load(effect)
  get_tree().root.call_deferred('add_child', sfx)
    

func on_button_pressed(button: Button) -> void:
  match button.name:
    'message':
      message_container.get_node('message').hide()
      score_container.visible = true
      emit_signal('start_game')
    'game_over':
      animation.play('fade_in')
      yield(get_tree().create_timer(1), 'timeout')
      var _reload = get_tree().reload_current_scene()
