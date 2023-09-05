
local player_mining_status_bar_enabled = {
    type = "bool-setting",
    name = "player-mining-status-bar-enabled",
    setting_type = "runtime-per-user",
    default_value = true,
    order = "a-player-mining-1"
}
local player_mining_status_bar_color = {
    type = "color-setting",
    name = "player-mining-status-bar-color",
    setting_type = "runtime-per-user",
    default_value = { r = 0.98, g = 0.66, b = 0.22 },
    order = "a-player-mining-2"
}

local player_health_status_bar_enabled = {
    type = "bool-setting",
    name = "player-health-status-bar-enabled",
    setting_type = "runtime-per-user",
    default_value = true,
    order = "b-player-health-1"
}
local player_health_status_bar_color = {
    type = "color-setting",
    name = "player-health-status-bar-color",
    setting_type = "runtime-per-user",
    default_value = { r = 0, g = 1, b = 0 },
    order = "b-player-health-2"
}

local player_shield_status_bar_enabled = {
    type = "bool-setting",
    name = "player-shield-status-bar-enabled",
    setting_type = "runtime-per-user",
    default_value = true,
    order = "c-player-shield-1"
}
local player_shield_status_bar_color = {
    type = "color-setting",
    name = "player-shield-status-bar-color",
    setting_type = "runtime-per-user",
    default_value = { r = 0.8, g = 0.2, b = 0.8 },
    order = "c-player-shield-2"
}

local player_battery_status_bar_enabled = {
    type = "bool-setting",
    name = "player-battery-status-bar-enabled",
    setting_type = "runtime-per-user",
    default_value = true,
    order = "d-player-battery-1"
}
local player_battery_status_bar_color = {
    type = "color-setting",
    name = "player-battery-status-bar-color",
    setting_type = "runtime-per-user",
    default_value = { r = 1, g = 1, b = 0 },
    order = "d-player-battery-2"
}

local armor_durability_status_bar_enabled = {
    type = "bool-setting",
    name = "armor-durability-status-bar-enabled",
    setting_type = "runtime-per-user",
    default_value = true,
    order = "e-player-durability-1"
}
local armor_durability_status_bar_color = {
    type = "color-setting",
    name = "armor-durability-status-bar-color",
    setting_type = "runtime-per-user",
    default_value = {r = 0, g = 0, b = 1},
    order = "e-player-durability-2"
}

local vehicle_health_status_bar_enabled = {
    type = "bool-setting",
    name = "vehicle-health-status-bar-enabled",
    setting_type = "runtime-per-user",
    default_value = true,
    order = "f-vehicle-health-1"
}
local vehicle_health_status_bar_color = {
    type = "color-setting",
    name = "vehicle-health-status-bar-color",
    setting_type = "runtime-per-user",
    default_value = { r = 0.8, g = 0.8, b = 0.8, },
    order = "f-vehicle-health-2"
}

local vehicle_shield_status_bar_enabled = {
    type = "bool-setting",
    name = "vehicle-shield-status-bar-enabled",
    setting_type = "runtime-per-user",
    default_value = true,
    order = "g-vehicle-shield-1"
}
local vehicle_shield_status_bar_color = {
    type = "color-setting",
    name = "vehicle-shield-status-bar-color",
    setting_type = "runtime-per-user",
    default_value = { r = 0.8, g = 0.2, b = 0.8 },
    order = "g-vehicle-shield-2"
}

local vehicle_battery_status_bar_enabled = {
    type = "bool-setting",
    name = "vehicle-battery-status-bar-enabled",
    setting_type = "runtime-per-user",
    default_value = true,
    order = "h-vehicle-battery-1"
}
local vehicle_battery_status_bar_color = {
    type = "color-setting",
    name = "vehicle-battery-status-bar-color",
    setting_type = "runtime-per-user",
    default_value = {r = 1, g = 1, b = 0},
    order = "h-vehicle-battery-2"
}

local current_hotbar_count = {
    type = "int-setting",
    name = "current-hotbar-count",
    setting_type = "runtime-per-user",
    default_value = 2,
    allowed_values = { 1, 2, 3, 4 },
    order = "x-hotbar-count"
}

data:extend{
    player_mining_status_bar_enabled,
    player_mining_status_bar_color,
    player_health_status_bar_enabled,
    player_health_status_bar_color,
    player_shield_status_bar_enabled,
    player_shield_status_bar_color,
    player_battery_status_bar_enabled,
    player_battery_status_bar_color,
    armor_durability_status_bar_enabled,
    armor_durability_status_bar_color,
    vehicle_health_status_bar_enabled,
    vehicle_health_status_bar_color,
    vehicle_shield_status_bar_enabled,
    vehicle_shield_status_bar_color,
    vehicle_battery_status_bar_enabled,
    vehicle_battery_status_bar_color,
    current_hotbar_count
}
