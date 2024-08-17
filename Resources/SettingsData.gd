class_name SettingsData extends Resource

@export_range(0,1,.05) var music_volume: float = 1.0
@export_range(0,1,.05) var sfx_volume: float = 1.0

@export var Window_Mode : int  
@export var Window_Size : int 


const PATH:String = "user://settings.tres"

func save() -> void:
    ResourceSaver.save(self,PATH)

static func load_or_create() -> SettingsData:
    var res:SettingsData
    if FileAccess.file_exists(PATH):
        res = load(PATH) as SettingsData
    else:
        res = SettingsData.new()
        res.save()
    return res