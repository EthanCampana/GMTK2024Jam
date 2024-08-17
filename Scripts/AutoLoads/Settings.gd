extends Node


@onready var SFX_BUS_ID = AudioServer.get_bus_index("SFX")
@onready var MUSIC_BUS_ID = AudioServer.get_bus_index("Music")


var settingsData : SettingsData


const WINDOW_MODE_OPTIONS : Array[String] = [
	"Window Mode",
	"Borderless Window",
	"Full-Screen",
	"Borderless Full-Screen"
]
const WINDOW_SIZE : Dictionary = {
	"800x600" : Vector2(800, 600),
	"1024x768" : Vector2(1024, 768),
	"1280x720" : Vector2(1280, 720),
	"1366x768" : Vector2(1366, 768),
	"1600x900" : Vector2(1600, 900),
	"1920x1080" : Vector2(1920, 1080),
	"2560x1440" : Vector2(2560, 1440),
	"3840x2160" : Vector2(3840, 2160)
}

func _ready():
    settingsData = SettingsData.load_or_create()
    set_window_mode(settingsData.Window_Mode)
    DisplayServer.window_set_size(WINDOW_SIZE.values()[settingsData.Window_Size])
    AudioServer.set_bus_volume_db(SFX_BUS_ID, linear_to_db(settingsData.sfx_volume))
    AudioServer.set_bus_volume_db(MUSIC_BUS_ID, linear_to_db( settingsData.music_volume) )

func set_window_mode(index: int):
    match index:
        # Window Mode
        0:
            DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
            DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS,false)
        # Borderless Window
        1:
            DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
            DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS,true)
        # Full-Screen
        2:
            DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
            DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS,false)
        # Borderless Full-Screen	
        3:
            DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
            DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS,true)
		
