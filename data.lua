
local default_gui_styles = data.raw["gui-style"].default

local basic_healthbar =
{
    type = "progressbar_style",
    horizontally_stretchable = "on",
    bar_width = 13,
    color = { g = 1 },
    bar =
    {
        filename = "__core__/graphics/gui.png",
        position = { 223, 0 },
        size = { 1, 11 },
        scale = 1
    },
    bar_background =
    {
        filename = "__core__/graphics/gui.png",
        position = { 224, 0 },
        size = { 1, 13 },
        scale = 1
    }
}
data.raw["gui-style"].default["sb_basic_healthbar"] = basic_healthbar

local player_health_status_bar_style = table.deepcopy(default_gui_styles["health_progressbar"])
player_health_status_bar_style.embed_text_in_bar = true
player_health_status_bar_style.parent = "sb_basic_healthbar"
-- player_health_status_bar_style.color = { r = 0, g = 1, b = 0 }
-- player_health_status_bar_style.other_colors = {
--     { less_than = 0.25, color = { r = 1, g = 0, b = 0 } },
--     { less_than = 0.5, color = { r = 1, g = 1, b = 0 } },
-- }
data.raw["gui-style"].default["sb_player_health_progressbar"] = player_health_status_bar_style

local armor_durability_status_bar_style = table.deepcopy(default_gui_styles["health_progressbar"])
armor_durability_status_bar_style.embed_text_in_bar = true
armor_durability_status_bar_style.parent = "sb_basic_healthbar"
armor_durability_status_bar_style.color = { r = 0, g = 0, b = 1 }
-- armor_durability_status_bar_style.other_colors = {
--     { less_than = 0.25, color = { r = 1, g = 0, b = 0 } },
--     { less_than = 0.5, color = { r = 1, g = 1, b = 0 } },
-- }
data.raw["gui-style"].default["sb_armor_durability_progressbar"] = armor_durability_status_bar_style

local vehicle_health_progressbar_style = table.deepcopy(default_gui_styles["vehicle_health_progressbar"])
vehicle_health_progressbar_style.embed_text_in_bar = true
vehicle_health_progressbar_style.parent = "sb_basic_healthbar"
-- vehicle_health_progressbar_style.color = { r = 0, g = 1, b = 0 }
-- vehicle_health_progressbar_style.other_colors = {
--     { less_than = 0.25, color = { r = 1, g = 0, b = 0 } },
--     { less_than = 0.5, color = { r = 1, g = 1, b = 0 } },
-- }
data.raw["gui-style"].default["sb_vehicle_health_progressbar"] = vehicle_health_progressbar_style

local mining_progressbar_style = table.deepcopy(default_gui_styles["mining_progressbar"])
mining_progressbar_style.embed_text_in_bar = true
mining_progressbar_style.parent = "sb_basic_healthbar"
-- mining_progressbar_style.color = { r = 0, g = 1, b = 0 }
-- mining_progressbar_style.other_colors = {
--     { less_than = 0.25, color = { r = 1, g = 0, b = 0 } },
--     { less_than = 0.5, color = { r = 1, g = 1, b = 0 } },
-- }
data.raw["gui-style"].default["sb_player_mining_progressbar"] = mining_progressbar_style

local player_shield_progressbar_style = table.deepcopy(default_gui_styles["shield_progressbar"])
player_shield_progressbar_style.embed_text_in_bar = true
player_shield_progressbar_style.parent = "sb_basic_healthbar"
-- player_shield_progressbar_style.color = { r = 0, g = 1, b = 0 }
-- shield_progressbar_style.color = { r = 0, g = 1, b = 0 }
-- shield_progressbar_style.other_colors = {
--     { less_than = 0.25, color = { r = 1, g = 0, b = 0 } },
--     { less_than = 0.5, color = { r = 1, g = 1, b = 0 } },
-- }
data.raw["gui-style"].default["sb_player_shield_progressbar"] = player_shield_progressbar_style

local vehicle_shield_progressbar_style = table.deepcopy(default_gui_styles["shield_progressbar"])
vehicle_shield_progressbar_style.embed_text_in_bar = true
vehicle_shield_progressbar_style.parent = "sb_basic_healthbar"
-- vehicle_shield_progressbar_style.color = { r = 0, g = 1, b = 0 }
-- vehicle_shield_progressbar_style.other_colors = {
--     { less_than = 0.25, color = { r = 1, g = 0, b = 0 } },
--     { less_than = 0.5, color = { r = 1, g = 1, b = 0 } },
-- }
data.raw["gui-style"].default["sb_vehicle_shield_progressbar"] = vehicle_shield_progressbar_style


local modified_basic_healthbar =
{
    type = "progressbar_style",
    horizontally_stretchable = "on",
    bar_width = 0,
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
