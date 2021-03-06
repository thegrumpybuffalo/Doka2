extends Control

var right
var left
onready var LeftOption = $MarginContainer/HBoxContainer/Left
onready var RightOption = $MarginContainer/HBoxContainer/Right
signal chosen(choice)

func _ready():
    $MarginContainer/HBoxContainer/Left/Button.grab_focus()

func decide_turns(left_speed, right_speed):
    randomize()
    var total = left_speed + right_speed
    var roll = randi() % total
    left = roll < left_speed
    right = !left
    $MarginContainer/HBoxContainer/Left/Button.grab_focus()
    

#left
func _on_Button_pressed(choice):
    if left:
        LeftOption.get_node("Button").hide()
        RightOption.get_node("Button").hide()
        LeftOption.get_node("Label").text = "First"
        RightOption.get_node("Label").text = "Last"
    else:
        LeftOption.get_node("Button").hide()
        RightOption.get_node("Button").hide()
        RightOption.get_node("Label").text = "First"
        LeftOption.get_node("Label").text = "Last"
    $Timer.set_wait_time(2)
    $Timer.start()
    yield($Timer, "timeout")
    if choice == "left":
        emit_signal("chosen", left)
    elif choice == "right":
        emit_signal("chosen", right)
    print(get_signal_connection_list("hide"))
    hide()
        
func reset():
    show()
    LeftOption.get_node("Button").show()
    RightOption.get_node("Button").show()
    LeftOption.grab_click_focus()
    $MarginContainer/HBoxContainer/Left/Button.grab_focus()
    RightOption.get_node("Label").text = "" 
    LeftOption.get_node("Label").text =  ""
