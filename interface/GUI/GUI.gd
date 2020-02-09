extends Control

var board
var current_player
onready var moves_label = $Counter/MarginContainer/VBoxContainer/MovesLeft
onready var name_label = $NinePatchRect/PlayerName
onready var InventoryMenu = preload("res://interface/menus/InventoryMenu.tscn")

func _ready():
    pass

func initialize(board):
    self.board = board
    
func change_player(player):
    current_player = player
    $ActionMenu.show()
    $ActionMenu/MarginContainer/VBoxContainer/RollButton.grab_focus()
    $ActionMenu/MarginContainer/VBoxContainer/RollButton.grab_click_focus()
    
    
func _process(delta):
    if(current_player):
        moves_label.text = String(current_player.board_character.get_moves())
        name_label.text =String(current_player.board_character.get_name())

func _on_RollButton_pressed():
    $DiceRollPopup.initialize()
    $ActionMenu.hide()
    #board roll
    pass # Replace with function body.

func _on_InventoryButton_pressed():
    var inventory_menu = InventoryMenu.instance()
    inventory_menu.set_inventory(current_player.get_inventory())
    $Container.add_child(inventory_menu)
    inventory_menu.initialize()
    get_tree().paused = true
    yield(inventory_menu, "completed")
    get_tree().paused = false


func _on_ViewBoardButton_pressed():
    #board view mode activate
    pass # Replace with function body.


func _on_PlayerInfoButton_pressed():
    #show player stats and board character
    pass # Replace with function body.
