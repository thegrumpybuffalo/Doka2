extends Resource

class_name CombatMove

enum move_types { empty = -1, normal, special, magic, effect }
enum phase_type { empty = -1, offense, defense }
signal missed(text)

export var move_name : String = "Move"
export (move_types) var type = move_types.empty
export (phase_type) var phase = phase_type.empty
export var description : String = ""
export var icon : Texture = load("res://icon.png")

export var mana_cost : int
export var base_damage : int
export(float, 0.0, 1.0) var success_chance : float
