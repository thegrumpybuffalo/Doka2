extends Node2D

onready var parser = CutsceneParser.new()
onready var dialogue = $CanvasLayer/MarginContainer/DialogueBox
onready var sprite = $CanvasLayer/pivot/Sprite
var sprite_text_map

func _ready():
    pass
    
func _init():
    _ready()
    
#TODO: create a sprite "theater" system that can work in parallel with the dialogue system
#sprite_text_map should look like {"sprites": [], "dialogue" []}
func load_dialogue(filename):
    sprite_text_map = parser.parse(filename)
    
func play():
    sprite.texture = load(sprite_text_map["sprites"][0])
    var sizeto=Vector2(70,100)
    var size=sprite.texture.get_size()
    var scalefactor=sizeto/size
    sprite.scale = Vector2(0.322,0.322)
    dialogue.show()
    dialogue.sb.show()
    dialogue.play_text(sprite_text_map["dialogue"])

func _on_DialogueBox_string_finished():
    queue_free()
    pass # Replace with function body.