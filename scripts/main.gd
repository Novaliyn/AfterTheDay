extends Node

func _ready():
	Signaler.connect("Test", test)


func test():
	print("test")
