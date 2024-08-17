class_name SaveData extends Resource

@export var main_scene : String = ""

const PATH: String = "user://savegame.tres"

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