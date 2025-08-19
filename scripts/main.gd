extends Node

@onready var GS: Node3D = $"GameSpace"
@onready var hud: Control = $HUD
var levelInstance: Node3D


func _ready():
	loadLevel(1)
	Signaler.connect("changeLevel", loadLevel)


func unloadLevel():
	if (is_instance_valid(levelInstance)):
		levelInstance.queue_free()
	levelInstance = null
	
func loadLevel(levelNum):
	Global.level = levelNum
	unloadLevel()
	var levelPath: String
	if levelNum is int:
		levelPath = "res://scenes/level%s.tscn" % str(levelNum)
		var levelResource: PackedScene = load(levelPath)
		if levelResource:
			levelInstance = levelResource.instantiate()
			GS.add_child(levelInstance)
