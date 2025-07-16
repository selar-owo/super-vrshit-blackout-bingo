extends Node2D
class_name Bi12ngler

const VER := 3

var editing := false

var currently_selected := []
var quotes := [
	"DO not let Jay know about this he will Block me again",
	"Have you ever checked the discord channel descriptions i think theyre funny :heart:",
	"So like. Does Kovu still struggle to talk to women at the time of seeing this or not",
	"my kidney hurts",
	"Flutter Splooging everywhere after Laying eyes on nari:",
	"Theres this person that i know that takes 20 Minutes pisses how is that Even possible",
	"No. Undertale is NOT Better than Deltarune. You need to Kill yourself",
	"#FATKOVU",
	"#KILLKOVU",
	"Nari would Genuinely be a Perfect Undertale Character",
	"Jacob Poland if you See this. Beat Undertale genocide its Really good",
]

@onready var players: Node2D = $Players

@export_category("BINGO DATA")
@export var all_players := [
	["flutter",Color(0.934, 0.226, 0.226)],
	["tofucurry",Color(0.12, 0.613, 0.0)],
	["jaykeezy",Color(0.485, 0.488, 0.109)],
	["nari",Color(0.0, 0.75, 0.521)],
	["kobu",Color(0.131, 0.439, 0.836)],
	["aaron",Color(0.922, 0.13, 0.798)],
	["alina",Color(0.64, 0.305, 0.918)],
	["chills",Color(0.652, 0.441, 0.441)],
]
@export_category("BOARD DATA")
@export var board_data := {
0: [],
1: [],
2: [],
3: [],
4: [],
5: [],
6: [],
7: [],
8: [],
9: [],
10: [],
11: [],
12: [],
13: [],
14: [],
15: [],
16: [],
17: [],
18: [],
19: [],
20: [],
21: [],
22: [],
23: [],
24: []
}
@export_category("SETTINGS DATA")
@export var settings_data := {
	"music_muted": false,
}

#@export var all_players := {
	#"flutter": Color(0.934, 0.226, 0.226),
	#"tofucurry": Color(0.12, 0.613, 0.0),
	#"jaykeezy": Color(0.485, 0.488, 0.109),
	#"nari": Color(0.0, 0.75, 0.521),
	#"kobu": Color(0.131, 0.439, 0.836),
	#"aaron": Color(0.922, 0.13, 0.798),
	#"alina": Color(0.64, 0.305, 0.918),
	#"chills": Color(0.652, 0.441, 0.441),
#}

func _ready() -> void:
	version_handler()

func version_handler() -> void:
	if randi_range(1,4) == 1:
		get_window().title = quotes.pick_random()
		return
	get_window().title += str(" U",VER)

func updated_toggled() -> void:
	currently_selected = []
	for b in players.get_children():
		b.button.disabled = false
	for i in players.get_children():
		if i.button.is_pressed():
			currently_selected.append(i.get_index())
		if currently_selected.size() >= 18:
			for b in players.get_children():
				if !b.button.is_pressed(): b.button.disabled = true
			return
