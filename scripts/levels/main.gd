extends Node2D
class_name Main


onready var background: ParallaxBackground = $ParallaxBackground
onready var pipe_spawner: Position2D = $ParallaxBackground/PipeSpawner
onready var bird: KinematicBody2D = $Bird
onready var interface: CanvasLayer = $Interface


func _ready() -> void:
  var _start = interface.connect('start_game', self, 'start_game')
  var _game_over = bird.connect('game_over', self, 'game_over')


func start_game() -> void:
  bird.start()
  pipe_spawner.spawn()
  

func game_over() -> void:
  interface.game_over()
  background.game_over()
  pipe_spawner.game_over()
