
local embed_text_in_bar = false
local default_gui_styles = data.raw["gui-style"].default

local basic_healthbar =
{
    -- type = "progressbar_style",
    -- horizontally_stretchable = "on",
    -- bar_width = 13,
    -- color = { g = 1 },
    -- bar =
    -- {
    --     filename = "__core__/graphics/gui.png",
    --     position = { 223, 0 },
    --     size = { 1, 11 },
    --     scale = 1
    -- },
    -- bar_background =
    -- {
    --     filename = "__core__/graphics/gui.png",
    --     position = { 224, 0 },
    --     size = { 1, 13 },
    --     scale = 1
    -- }
}

basic_healthbar = util.table.deepcopy(default_gui_styles["health_progressbar"])

data.raw["gui-style"].default["sb_basic_healthbar"] = basic_healthbar

local mining_progressbar_style = table.deepcopy(default_gui_styles["mining_progressbar"])
mining_progressbar_style.embed_text_in_bar = embed_text_in_bar
mining_progressbar_style.parent = "sb_basic_healthbar"
data.raw["gui-style"].default["sb_player_mining_progressbar"] = mining_progressbar_style

local player_health_status_bar_style = table.deepcopy(default_gui_styles["health_progressbar"])
player_health_status_bar_style.embed_text_in_bar = embed_text_in_bar
player_health_status_bar_style.parent = "sb_basic_healthbar"
data.raw["gui-style"].default["sb_player_health_progressbar"] = player_health_status_bar_style

local player_shield_progressbar_style = table.deepcopy(default_gui_styles["shield_progressbar"])
player_shield_progressbar_style.embed_text_in_bar = embed_text_in_bar
player_shield_progressbar_style.parent = "sb_basic_healthbar"
data.raw["gui-style"].default["sb_player_shield_progressbar"] = player_shield_progressbar_style

local player_battery_progressbar_style = table.deepcopy(default_gui_styles["shield_progressbar"])
player_battery_progressbar_style.embed_text_in_bar = embed_text_in_bar
player_battery_progressbar_style.parent = "sb_basic_healthbar"
player_battery_progressbar_style.color = { r = 1, g = 1, b = 0 }
data.raw["gui-style"].default["sb_player_battery_progressbar"] = player_battery_progressbar_style

local armor_durability_status_bar_style = table.deepcopy(default_gui_styles["health_progressbar"])
armor_durability_status_bar_style.embed_text_in_bar = embed_text_in_bar
armor_durability_status_bar_style.parent = "sb_basic_healthbar"
armor_durability_status_bar_style.color = { r = 0, g = 0, b = 1 }
data.raw["gui-style"].default["sb_armor_durability_progressbar"] = armor_durability_status_bar_style

local vehicle_health_progressbar_style = table.deepcopy(default_gui_styles["vehicle_health_progressbar"])
vehicle_health_progressbar_style.embed_text_in_bar = embed_text_in_bar
vehicle_health_progressbar_style.parent = "sb_basic_healthbar"
data.raw["gui-style"].default["sb_vehicle_health_progressbar"] = vehicle_health_progressbar_style

local vehicle_shield_progressbar_style = table.deepcopy(default_gui_styles["shield_progressbar"])
vehicle_shield_progressbar_style.embed_text_in_bar = embed_text_in_bar
vehicle_shield_progressbar_style.parent = "sb_basic_healthbar"
data.raw["gui-style"].default["sb_vehicle_shield_progressbar"] = vehicle_shield_progressbar_style

local vehicle_battery_progressbar_style = table.deepcopy(default_gui_styles["shield_progressbar"])
vehicle_battery_progressbar_style.embed_text_in_bar = embed_text_in_bar
vehicle_battery_progressbar_style.parent = "sb_basic_healthbar"
vehicle_battery_progressbar_style.color = { r = 1, g = 1, b = 0 }
data.raw["gui-style"].default["sb_vehicle_battery_progressbar"] = vehicle_battery_progressbar_style

-- local modified_basic_healthbar = table.deepcopy(basic_healthbar)
-- modified_basic_healthbar.bar_width = 0
-- modified_basic_healthbar.color = nil
-- modified_basic_healthbar.bar = nil
-- modified_basic_healthbar.bar_background = nil

-- data.raw["gui-style"].default["health_progressbar"] = modified_basic_healthbar
-- data.raw["gui-style"].default["health_progressbar"].bar = nil
-- data.raw["gui-style"].default["health_progressbar"].bar_background = nil
-- data.raw["gui-style"].default["health_progressbar"].bar_width = 0

-- data.raw["gui-style"].default["vehicle_health_progressbar"].bar = nil
-- data.raw["gui-style"].default["vehicle_health_progressbar"].bar_background = nil
-- data.raw["gui-style"].default["vehicle_health_progressbar"].bar_width = 0

-- data.raw["gui-style"].default["mining_progressbar"].bar = nil
-- data.raw["gui-style"].default["mining_progressbar"].bar_background = nil
-- data.raw["gui-style"].default["mining_progressbar"].bar_width = 0

-- data.raw["gui-style"].default["shield_progressbar"].bar = nil
-- data.raw["gui-style"].default["shield_progressbar"].bar_background = nil
-- data.raw["gui-style"].default["shield_progressbar"].bar_width = 0
