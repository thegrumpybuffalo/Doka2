extends Panel

signal string_finished
onready var sb = $MarginContainer/SyndiBox

func _ready():
    pass

func play_text(text):
    sb.DIALOG = text
    sb.play()

func _on_SyndiBox_strings_finished():
    emit_signal("string_finished")
    pass # Replace with function body.