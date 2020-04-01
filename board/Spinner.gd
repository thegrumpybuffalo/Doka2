extends Panel

onready var timer = $Timer
var item_num
var curr_item : int
var spin_decay = 8
var spin_decaying = false
onready var option_button = preload("res://interface/GUI/OptionButton.tscn")
var items = []
signal item_chosen(item)

func _ready():
    curr_item = 0

func set_items(_items: Array):
    assert(_items is Array)
    items = _items
    

func initialize(player):  
# warning-ignore:return_value_discarded
    connect("item_chosen", player, "receive_item", [], CONNECT_ONESHOT)

    for item in items:
        var option = option_button.instance()
        option.set_item(item)
        $Row.add_child(option)

    item_num = items.size()
    $AnimationPlayer.play("slide in")
    yield($AnimationPlayer, "animation_finished")
    $Row.get_child(0).grab_focus()
    timer.start()

func _unhandled_input(event):
    if (event is InputEventKey 
    and ControlsHandler.is_action_pressed_by_current_player(event, "ui_accept")):
        spin_decaying = true

func _on_Timer_timeout():
    if spin_decaying:
        if spin_decay <= 0:
            timer.queue_free()
            var new_timer = Timer.new()
            new_timer.one_shot = true
            add_child(new_timer)
            new_timer.start(1)
            yield(new_timer, "timeout")
            queue_free()
            emit_signal("item_chosen", get_focus_owner().get_item())
        else:
            spin_decay -= 1
            timer.wait_time += .03
            curr_item = (curr_item + 1) % 3
            $Row.get_child(curr_item).grab_focus()
            timer.start()
    
    
func _on_delay_over():
    $AnimationPlayer.play_backwards("slide in")
    yield($AnimationPlayer, "animation_finished")
    queue_free()

