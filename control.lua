
local bar_width = 468 -- width of hotbar
local bar_height = 13 -- height of original health bar
local caption = false

local floor = math.floor
local ceil = math.ceil

---@class player_armor_data
---@field armor LuaItemStack?
---@field armor_grid LuaEquipmentGrid?
---@field max_durability number?
---@field max_shield number?
---@field battery_capacity number?

---@class player_vehicle_data
---@field grid LuaEquipmentGrid?
---@field max_shield number?
---@field battery_capacity number?
---@field max_health number?

---@class player_mod_settings
---@field mining_bar_enabled boolean
---@field mining_bar_color Color
---@field player_health_bar_enabled boolean
---@field player_health_bar_color Color
---@field player_shield_bar_enabled boolean
---@field player_shield_bar_color Color
---@field player_battery_bar_enabled boolean
---@field player_battery_bar_color Color
---@field durability_bar_enabled boolean
---@field durability_bar_color Color
---@field vehicle_health_bar_enabled boolean
---@field vehicle_health_bar_color Color
---@field vehicle_shield_bar_enabled boolean
---@field vehicle_shield_bar_color Color
---@field vehicle_battery_bar_enabled boolean
---@field vehicle_battery_bar_color Color

local function on_init()
    global.status_bar_counts = global.status_bar_counts or {}
    global.status_bar_values = global.status_bar_values or {}
    global.player_armor = global.player_armor or {} ---@type table<uint, player_armor_data>
    global.player_vehicle = global.player_vehicle or {} ---@type table<uint, player_vehicle_data>
    for _, player in pairs(game.players) do
        global.status_bar_counts[player.index] = 0
        global.status_bar_values[player.index] = {
            character_mining_progress = 0,
            player_health_ratio = 0,
            player_shield_radio = 0,
            player_battery_ratio = 0,
            armor_durability_ratio = 0,
            vehicle_health_ratio = 0,
            vehicle_shield_ratio = 0,
            vehicle_battery_ratio = 0,
        }
        global.player_armor[player.index] = {
            armor = nil,
            armor_grid = nil,
            max_durability = nil,
            max_shield = nil,
            battery_capacity = nil,
        }
        local inventory = player.get_inventory(defines.inventory.character_armor)
        local player_armor = inventory and inventory[1] or nil
        if player_armor and player_armor.valid_for_read then
            local max_durability = player_armor.prototype.durability or 0
            local armor_grid = player_armor.grid or nil
            local max_shield = armor_grid and armor_grid.max_shield or 0
            local battery_capacity = armor_grid and armor_grid.battery_capacity or 0
            global.player_armor = global.player_armor or {}
            global.player_armor[player.index] = {
                armor = player_armor,
                armor_grid = armor_grid,
                max_durability = max_durability,
                max_shield = max_shield,
                battery_capacity = battery_capacity,
            }
        end
        local vehicle = player.vehicle
        if vehicle then
            local max_health = vehicle.prototype.max_health
            local grid = vehicle.grid
            local max_shield = grid and grid.max_shield or 0
            local battery_capacity = grid and grid.battery_capacity or 0
            global.player_vehicle = global.player_vehicle or {}
            global.player_vehicle[player.index] = {
                grid = grid,
                max_shield = max_shield,
                battery_capacity = battery_capacity,
                max_health = max_health,
            }
        end
        local mod_settings = player.mod_settings
        global.mod_settings = global.mod_settings or {} ---@type table<uint, player_mod_settings>
        global.mod_settings[player.index] = {
            mining_bar_enabled = mod_settings["player-mining-status-bar-enabled"].value,
            mining_bar_color = mod_settings["player-mining-status-bar-color"].value,
            player_health_bar_enabled = mod_settings["player-health-status-bar-enabled"].value,
            player_health_bar_color = mod_settings["player-health-status-bar-color"].value,
            player_shield_bar_enabled = mod_settings["player-shield-status-bar-enabled"].value,
            player_shield_bar_color = mod_settings["player-shield-status-bar-color"].value,
            player_battery_bar_enabled = mod_settings["player-battery-status-bar-enabled"].value,
            player_battery_bar_color = mod_settings["player-battery-status-bar-color"].value,
            durability_bar_enabled = mod_settings["armor-durability-status-bar-enabled"].value,
            durability_bar_color = mod_settings["armor-durability-status-bar-color"].value,
            vehicle_health_bar_enabled = mod_settings["vehicle-health-status-bar-enabled"].value,
            vehicle_health_bar_color = mod_settings["vehicle-health-status-bar-color"].value,
            vehicle_shield_bar_enabled = mod_settings["vehicle-shield-status-bar-enabled"].value,
            vehicle_shield_bar_color = mod_settings["vehicle-shield-status-bar-color"].value,
            vehicle_battery_bar_enabled = mod_settings["vehicle-battery-status-bar-enabled"].value,
            vehicle_battery_bar_color = mod_settings["vehicle-battery-status-bar-color"].value,
        }
    end
end

script.on_init(on_init)
script.on_configuration_changed(on_init)

local function refresh_mod_settings_data()
    for _, player in pairs(game.connected_players) do
        local mod_settings = player.mod_settings
        global.mod_settings = global.mod_settings or {}
        global.mod_settings[player.index] = {
            mining_bar_enabled = mod_settings["player-mining-status-bar-enabled"].value,
            mining_bar_color = mod_settings["player-mining-status-bar-color"].value,
            player_health_bar_enabled = mod_settings["player-health-status-bar-enabled"].value,
            player_health_bar_color = mod_settings["player-health-status-bar-color"].value,
            player_shield_bar_enabled = mod_settings["player-shield-status-bar-enabled"].value,
            player_shield_bar_color = mod_settings["player-shield-status-bar-color"].value,
            player_battery_bar_enabled = mod_settings["player-battery-status-bar-enabled"].value,
            player_battery_bar_color = mod_settings["player-battery-status-bar-color"].value,
            durability_bar_enabled = mod_settings["armor-durability-status-bar-enabled"].value,
            durability_bar_color = mod_settings["armor-durability-status-bar-color"].value,
            vehicle_health_bar_enabled = mod_settings["vehicle-health-status-bar-enabled"].value,
            vehicle_health_bar_color = mod_settings["vehicle-health-status-bar-color"].value,
            vehicle_shield_bar_enabled = mod_settings["vehicle-shield-status-bar-enabled"].value,
            vehicle_shield_bar_color = mod_settings["vehicle-shield-status-bar-color"].value,
            vehicle_battery_bar_enabled = mod_settings["vehicle-battery-status-bar-enabled"].value,
            vehicle_battery_bar_color = mod_settings["vehicle-battery-status-bar-color"].value,
        }
    end
end

script.on_event(defines.events.on_runtime_mod_setting_changed, refresh_mod_settings_data)

---@param gui_element LuaGuiElement
---@param player_index uint
local function add_mining_status_bar(gui_element, player_index)
    gui_element.add {
        type = "progressbar",
        name = "sb_player_mining_progressbar",
        value = 0,
    }
    gui_element.sb_player_mining_progressbar.style = "sb_player_mining_progressbar"
    gui_element.sb_player_mining_progressbar.style.width = bar_width
    gui_element.sb_player_mining_progressbar.style.height = bar_height
    gui_element.sb_player_mining_progressbar.caption = caption and "Mining Progress" or ""
    local mod_settings = global.mod_settings[player_index]
    if mod_settings then
        gui_element.sb_player_mining_progressbar.style.color = mod_settings.mining_bar_color
    end
end

---@param gui_element LuaGuiElement
---@param value number
---@param player_index uint
local function update_mining_status_bar(gui_element, value, player_index)
    if not gui_element.sb_player_mining_progressbar then
        add_mining_status_bar(gui_element, player_index)
    end
    gui_element.sb_player_mining_progressbar.value = value
end

---@param gui_element LuaGuiElement
---@param player_index uint
local function add_armor_durability_status_bar(gui_element, player_index)
    gui_element.add {
        type = "progressbar",
        name = "sb_armor_durability_progressbar",
        value = 0,
    }
    gui_element.sb_armor_durability_progressbar.style = "sb_armor_durability_progressbar"
    gui_element.sb_armor_durability_progressbar.style.width = bar_width
    gui_element.sb_armor_durability_progressbar.style.height = bar_height
    gui_element.sb_armor_durability_progressbar.caption = caption and "Armor Durability" or ""
    local mod_settings = global.mod_settings[player_index]
    if mod_settings then
        gui_element.sb_armor_durability_progressbar.style.color = mod_settings.durability_bar_color
    end
end

---@param gui_element LuaGuiElement
---@param value number
---@param player_index uint
local function update_armor_durability_status_bar(gui_element, value, player_index)
    if not gui_element.sb_armor_durability_progressbar then
        add_armor_durability_status_bar(gui_element, player_index)
    end
    gui_element.sb_armor_durability_progressbar.value = value
end

---@param gui_element LuaGuiElement
---@param player_index uint
local function add_player_health_status_bar(gui_element, player_index)
    gui_element.add {
        type = "progressbar",
        name = "sb_player_health_progressbar",
        value = 1,
    }
    gui_element.sb_player_health_progressbar.style = "sb_player_health_progressbar"
    gui_element.sb_player_health_progressbar.style.width = bar_width
    gui_element.sb_player_health_progressbar.style.height = bar_height
    gui_element.sb_player_health_progressbar.caption = caption and "Player Health" or ""
    local mod_settings = global.mod_settings[player_index]
    if mod_settings then
        gui_element.sb_player_health_progressbar.style.color = mod_settings.player_health_bar_color
    end
end

---@param gui_element LuaGuiElement
---@param value number
---@param player_index uint
local function update_player_health_status_bar(gui_element, value, player_index)
    if not gui_element.sb_player_health_progressbar then
        add_player_health_status_bar(gui_element, player_index)
    end
    gui_element.sb_player_health_progressbar.value = value
end

---@param gui_element LuaGuiElement
---@param player_index uint
local function add_vehicle_health_status_bar(gui_element, player_index)
    gui_element.add {
        type = "progressbar",
        name = "sb_vehicle_health_progressbar",
        value = 1,
    }
    gui_element.sb_vehicle_health_progressbar.style = "sb_vehicle_health_progressbar"
    gui_element.sb_vehicle_health_progressbar.style.width = bar_width
    gui_element.sb_vehicle_health_progressbar.style.height = bar_height
    gui_element.sb_vehicle_health_progressbar.caption = caption and "Vehicle Health" or ""
    local mod_settings = global.mod_settings[player_index]
    if mod_settings then
        gui_element.sb_vehicle_health_progressbar.style.color = mod_settings.vehicle_health_bar_color
    end
end

---@param gui_element LuaGuiElement
---@param value number
---@param player_index uint
local function update_vehicle_health_status_bar(gui_element, value, player_index)
    if not gui_element.sb_vehicle_health_progressbar then
        add_vehicle_health_status_bar(gui_element, player_index)
    end
    gui_element.sb_vehicle_health_progressbar.value = value
end

---@param gui_element LuaGuiElement
---@param player_index uint
local function add_player_shield_status_bar(gui_element, player_index)
    gui_element.add {
        type = "progressbar",
        name = "sb_player_shield_progressbar",
        value = 0,
    }
    gui_element.sb_player_shield_progressbar.style = "sb_player_shield_progressbar"
    gui_element.sb_player_shield_progressbar.style.width = bar_width
    gui_element.sb_player_shield_progressbar.style.height = bar_height
    gui_element.sb_player_shield_progressbar.caption = caption and "Armor Shield" or ""
    local mod_settings = global.mod_settings[player_index]
    if mod_settings then
        gui_element.sb_player_shield_progressbar.style.color = mod_settings.player_shield_bar_color
    end
end

---@param gui_element LuaGuiElement
---@param value number
---@param player_index uint
local function update_player_shield_status_bar(gui_element, value, player_index)
    if not gui_element.sb_player_shield_progressbar then
        add_player_shield_status_bar(gui_element, player_index)
    end
    gui_element.sb_player_shield_progressbar.value = value
end

---@param gui_element LuaGuiElement
---@param player_index uint
local function add_vehicle_shield_status_bar(gui_element, player_index)
    gui_element.add {
        type = "progressbar",
        name = "sb_vehicle_shield_progressbar",
        value = 0,
    }
    gui_element.sb_vehicle_shield_progressbar.style = "sb_vehicle_shield_progressbar"
    gui_element.sb_vehicle_shield_progressbar.style.width = bar_width
    gui_element.sb_vehicle_shield_progressbar.style.height = bar_height
    gui_element.sb_vehicle_shield_progressbar.caption = caption and "Vehicle Shield" or ""
    local mod_settings = global.mod_settings[player_index]
    if mod_settings then
        gui_element.sb_vehicle_shield_progressbar.style.color = mod_settings.vehicle_shield_bar_color
    end
end

---@param gui_element LuaGuiElement
---@param value number
---@param player_index uint
local function update_vehicle_shield_status_bar(gui_element, value, player_index)
    if not gui_element.sb_vehicle_shield_progressbar then
        add_vehicle_shield_status_bar(gui_element, player_index)
    end
    gui_element.sb_vehicle_shield_progressbar.value = value
end

---@param gui_element LuaGuiElement
---@param player_index uint
local function add_player_battery_status_bar(gui_element, player_index)
    gui_element.add {
        type = "progressbar",
        name = "sb_player_battery_progressbar",
        value = 0,
    }
    gui_element.sb_player_battery_progressbar.style = "sb_player_battery_progressbar"
    gui_element.sb_player_battery_progressbar.style.width = bar_width
    gui_element.sb_player_battery_progressbar.style.height = bar_height
    gui_element.sb_player_battery_progressbar.caption = caption and "Armor Battery" or ""
    local mod_settings = global.mod_settings[player_index]
    if mod_settings then
        gui_element.sb_player_battery_progressbar.style.color = mod_settings.player_battery_bar_color
    end
end

---@param gui_element LuaGuiElement
---@param value number
---@param player_index uint
local function update_player_battery_status_bar(gui_element, value, player_index)
    if not gui_element.sb_player_battery_progressbar then
        add_player_battery_status_bar(gui_element, player_index)
    end
    gui_element.sb_player_battery_progressbar.value = value
end

---@param gui_element LuaGuiElement
---@param player_index uint
local function add_vehicle_battery_status_bar(gui_element, player_index)
    gui_element.add {
        type = "progressbar",
        name = "sb_vehicle_battery_progressbar",
        value = 0,
    }
    gui_element.sb_vehicle_battery_progressbar.style = "sb_vehicle_battery_progressbar"
    gui_element.sb_vehicle_battery_progressbar.style.width = bar_width
    gui_element.sb_vehicle_battery_progressbar.style.height = bar_height
    gui_element.sb_vehicle_battery_progressbar.caption = caption and "Vehicle Battery" or ""
    local mod_settings = global.mod_settings[player_index]
    if mod_settings then
        gui_element.sb_vehicle_battery_progressbar.style.color = mod_settings.vehicle_battery_bar_color
    end
end

---@param gui_element LuaGuiElement
---@param value number
---@param player_index uint
local function update_vehicle_battery_status_bar(gui_element, value, player_index)
    if not gui_element.sb_vehicle_battery_progressbar then
        add_vehicle_battery_status_bar(gui_element, player_index)
    end
    gui_element.sb_vehicle_battery_progressbar.value = value
end

---@param player LuaPlayer
local function refresh_player_status_bar_data(player)
    if not player then return end
    local player_armor = player.get_inventory(defines.inventory.character_armor)[1]
    if player_armor and player_armor.valid_for_read then
        local max_durability = player_armor.prototype.durability or 0
        local armor_grid = player_armor.grid or nil
        local max_shield = armor_grid and armor_grid.max_shield or 0
        local battery_capacity = armor_grid and armor_grid.battery_capacity or 0
        global.player_armor = global.player_armor or {}
        global.player_armor[player.index] = {
            armor = player_armor,
            armor_grid = armor_grid,
            max_durability = max_durability,
            max_shield = max_shield,
            battery_capacity = battery_capacity,
        }
    end
    local vehicle = player.vehicle
    if vehicle then
        local max_health = vehicle.prototype.max_health
        local grid = vehicle.grid
        local max_shield = grid and grid.max_shield or 0
        local battery_capacity = grid and grid.battery_capacity or 0
        global.player_vehicle = global.player_vehicle or {}
        global.player_vehicle[player.index] = {
            grid = grid,
            max_shield = max_shield,
            battery_capacity = battery_capacity,
            max_health = max_health,
        }
    end
end

---@param event EventData.on_equipment_inserted
local function on_equipment_inserted(event)
    for _, player in pairs(game.connected_players) do
        refresh_player_status_bar_data(player)
    end
end

---@param event EventData.on_equipment_removed
local function on_equipment_removed(event)
    for _, player in pairs(game.connected_players) do
        refresh_player_status_bar_data(player)
    end
end

---@param event EventData.on_player_placed_equipment
local function on_player_placed_equipment(event)
    local player = game.get_player(event.player_index)
    if not player then return end
    refresh_player_status_bar_data(player)
end

---@param event EventData.on_player_removed_equipment
local function on_player_removed_equipment(event)
    local player = game.get_player(event.player_index)
    if not player then return end
    refresh_player_status_bar_data(player)
end

---@param event EventData.on_player_armor_inventory_changed
local function on_player_armor_inventory_changed(event)
    local player = game.get_player(event.player_index)
    if not player then return end
    refresh_player_status_bar_data(player)
end

script.on_event(defines.events.on_equipment_inserted, on_equipment_inserted)
script.on_event(defines.events.on_equipment_removed, on_equipment_removed)
script.on_event(defines.events.on_player_placed_equipment, on_player_placed_equipment)
script.on_event(defines.events.on_player_removed_equipment, on_player_removed_equipment)
script.on_event(defines.events.on_player_armor_inventory_changed, on_player_armor_inventory_changed)

---@param event EventData.on_player_driving_changed_state
local function on_player_driving_changed_state(event)
    local player = game.get_player(event.player_index)
    if not player then return end
    refresh_player_status_bar_data(player)
end

script.on_event(defines.events.on_player_driving_changed_state, on_player_driving_changed_state)

---@param player LuaPlayer
local function update_status_bar_location(player)
    local screen = player.gui.screen
    if screen.sb_status_bars then
        local display_resolution = player.display_resolution
        local display_height = display_resolution.height
        local display_width = display_resolution.width
        local display_scale = player.display_scale
        local hotbar_border_height = 8
        local hotbar_inner_padding = 1
        local hotbar_single_row_height = 38
        local hotbar_between_row_padding = 2
        local hotbar_count = 2
        local hotbar_height = (hotbar_border_height * 2) + (hotbar_inner_padding * 2) + (hotbar_single_row_height * hotbar_count) + (hotbar_between_row_padding * (hotbar_count - 1))
        hotbar_height = hotbar_height * display_scale

        local status_bar_count = global.status_bar_counts[player.index]
        local status_bar_height = bar_height * status_bar_count * display_scale
        local status_bar_width = bar_width * display_scale
        local width_offset = 24 * display_scale

        status_bar_height = status_bar_height - 2

        local location = {
            x = (display_width / 2) - (status_bar_width / 2) - width_offset,
            y = display_height - hotbar_height - status_bar_height,
        }
        screen.sb_status_bars.location = location
    end
end

---@param player LuaPlayer
local function refresh_status_bar_gui(player)
    local player_index = player.index
    global.player_screen_gui = global.player_screen_gui or {}
    local screen = global.player_screen_gui[player_index]
    if not screen then
        screen = player.gui.screen
        global.player_screen_gui[player_index] = screen
    end
    if not screen.sb_status_bars then
        screen.add {
            type = "flow",
            name = "sb_status_bars",
            direction = "vertical",
        }
        screen.sb_status_bars.style.vertical_spacing = 0
    end
    local status_bars = screen.sb_status_bars
    if not status_bars then return end

    local status_bar_count = 0

    local character_mining_progress = 0
    local player_health_ratio = 0
    local player_shield_radio = 0
    local player_battery_ratio = 0
    local armor_durability_ratio = 0
    local vehicle_health_ratio = 0
    local vehicle_shield_ratio = 0
    local vehicle_battery_ratio = 0

    if player.mining_state.mining then
        character_mining_progress = player.character_mining_progress
    end

    local character = player.character
    if character then

        player_health_ratio = character.get_health_ratio() or 0

        global.player_armor = global.player_armor or {}
        local player_armor_data = global.player_armor[player_index]
        if player_armor_data then
            local armor = player_armor_data.armor
            if armor and armor.valid and armor.valid_for_read then

                local grid = player_armor_data.armor_grid
                if grid and grid.valid then

                    local shield = grid.shield
                    local max_shield = player_armor_data.max_shield
                    if shield and max_shield then
                        player_shield_radio = shield / max_shield
                    end

                    local battery_charge = grid.available_in_batteries
                    local battery_capacity = player_armor_data.battery_capacity
                    if battery_charge and battery_capacity then
                        player_battery_ratio = battery_charge / battery_capacity
                    end
                end

                local durability = armor.durability
                local max_durability = player_armor_data.max_durability
                if durability and max_durability then
                    armor_durability_ratio = durability / max_durability
                end
            end
        end
    end

    local vehicle = player.vehicle
    if vehicle then

        global.player_vehicle = global.player_vehicle or {}
        local player_vehicle_data = global.player_vehicle[player_index]
        if player_vehicle_data then
            local health = vehicle.health
            local max_health = player_vehicle_data.max_health
            if health and max_health then
                vehicle_health_ratio = health / max_health
            end

            local grid = player_vehicle_data.grid
            if grid and grid.valid then

                local shield = grid.shield
                local max_shield = player_vehicle_data.max_shield
                if shield and max_shield then
                    vehicle_shield_ratio = shield / max_shield
                end

                local battery_charge = grid.available_in_batteries
                local battery_capacity = player_vehicle_data.battery_capacity
                if battery_charge and battery_capacity then
                    vehicle_battery_ratio = battery_charge / battery_capacity
                end
            end
        end
    end

    global.mod_settings = global.mod_settings or {}
    local mod_settings = global.mod_settings[player_index]
    if not mod_settings then refresh_mod_settings_data() end
    mod_settings = global.mod_settings[player_index]
    if not mod_settings then return end
    local enable_mining = mod_settings.mining_bar_enabled
    local enable_player_health = mod_settings.player_health_bar_enabled
    local enable_player_shield = mod_settings.player_shield_bar_enabled
    local enable_player_battery = mod_settings.player_battery_bar_enabled
    local enable_durability = mod_settings.durability_bar_enabled
    local enable_vehicle_health = mod_settings.vehicle_health_bar_enabled
    local enable_vehicle_shield = mod_settings.vehicle_shield_bar_enabled
    local enable_vehicle_battery = mod_settings.vehicle_battery_bar_enabled

    local show_mining_progress = enable_mining and character_mining_progress > 0 and character_mining_progress < 1
    local show_player_health = enable_player_health and player_health_ratio > 0 and player_health_ratio < 1
    local show_player_shield = enable_player_shield and player_shield_radio > 0 and player_shield_radio < 1
    local show_player_battery = enable_player_battery and player_battery_ratio > 0 and player_battery_ratio < 1
    local show_armor_durability = enable_durability and armor_durability_ratio > 0 and armor_durability_ratio < 1
    local show_vehicle_health = enable_vehicle_health and vehicle_health_ratio > 0 and vehicle_health_ratio < 1
    local show_vehicle_shield = enable_vehicle_shield and vehicle_shield_ratio > 0 and vehicle_shield_ratio < 1
    local show_vehicle_battery = enable_vehicle_battery and vehicle_battery_ratio > 0 and vehicle_battery_ratio < 1

    if show_mining_progress then
        status_bar_count = status_bar_count + 1
    end
    if show_player_health then
        status_bar_count = status_bar_count + 1
    end
    if show_player_shield then
        status_bar_count = status_bar_count + 1
    end
    if show_player_battery then
        status_bar_count = status_bar_count + 1
    end
    if show_armor_durability then
        status_bar_count = status_bar_count + 1
    end
    if show_vehicle_health then
        status_bar_count = status_bar_count + 1
    end
    if show_vehicle_shield then
        status_bar_count = status_bar_count + 1
    end
    if show_vehicle_battery then
        status_bar_count = status_bar_count + 1
    end

    global.status_bar_counts = global.status_bar_counts or {}
    local last_status_bar_count = global.status_bar_counts[player.index] or 0
    local status_bar_count_changed = last_status_bar_count ~= status_bar_count

    local mining_progress_element = status_bars.sb_player_mining_progressbar
    local player_health_element = status_bars.sb_player_health_progressbar
    local player_shield_element = status_bars.sb_player_shield_progressbar
    local player_battery_element = status_bars.sb_player_battery_progressbar
    local armor_durability_element = status_bars.sb_armor_durability_progressbar
    local vehicle_health_element = status_bars.sb_vehicle_health_progressbar
    local vehicle_shield_element = status_bars.sb_vehicle_shield_progressbar
    local vehicle_battery_element = status_bars.sb_vehicle_battery_progressbar

    local reset_required = false
    if (show_mining_progress and not mining_progress_element) or (not show_mining_progress and mining_progress_element) then
        reset_required = true
    end
    if (show_player_health and not player_health_element) or (not show_player_health and player_health_element) then
        reset_required = true
    end
    if (show_player_shield and not player_shield_element) or (not show_player_shield and player_shield_element) then
        reset_required = true
    end
    if (show_player_battery and not player_battery_element) or (not show_player_battery and player_battery_element) then
        reset_required = true
    end
    if (show_armor_durability and not armor_durability_element) or (not show_armor_durability and armor_durability_element) then
        reset_required = true
    end
    if (show_vehicle_health and not vehicle_health_element) or (not show_vehicle_health and vehicle_health_element) then
        reset_required = true
    end
    if (show_vehicle_shield and not vehicle_shield_element) or (not show_vehicle_shield and vehicle_shield_element) then
        reset_required = true
    end
    if (show_vehicle_battery and not vehicle_battery_element) or (not show_vehicle_battery and vehicle_battery_element) then
        reset_required = true
    end

    if reset_required then
        if mining_progress_element then
            mining_progress_element.destroy()
        end
        if player_health_element then
            player_health_element.destroy()
        end
        if player_shield_element then
            player_shield_element.destroy()
        end
        if player_battery_element then
            player_battery_element.destroy()
        end
        if armor_durability_element then
            armor_durability_element.destroy()
        end
        if vehicle_health_element then
            vehicle_health_element.destroy()
        end
        if vehicle_shield_element then
            vehicle_shield_element.destroy()
        end
        if vehicle_battery_element then
            vehicle_battery_element.destroy()
        end
    end

    global.status_bar_values = global.status_bar_values or {}
    local last_status_bar_values = global.status_bar_values[player_index] or {}

    local mining_progress_changed = character_mining_progress ~= last_status_bar_values.character_mining_progress
    local player_health_changed = player_health_ratio ~= last_status_bar_values.player_health_ratio
    local player_shield_changed = player_shield_radio ~= last_status_bar_values.player_shield_radio
    local player_battery_changed = player_battery_ratio ~= last_status_bar_values.player_battery_ratio
    local armor_durability_changed = armor_durability_ratio ~= last_status_bar_values.armor_durability_ratio
    local vehicle_health_changed = vehicle_health_ratio ~= last_status_bar_values.vehicle_health_ratio
    local vehicle_shield_changed = vehicle_shield_ratio ~= last_status_bar_values.vehicle_shield_ratio
    local vehicle_battery_changed = vehicle_battery_ratio ~= last_status_bar_values.vehicle_battery_ratio

    if show_mining_progress then
        if mining_progress_changed or reset_required then
            update_mining_status_bar(status_bars, character_mining_progress, player_index)
        end
    end
    if show_player_health then
        if player_health_changed or reset_required then
            update_player_health_status_bar(status_bars, player_health_ratio, player_index)
        end
    end
    if show_player_shield then
        if player_shield_changed or reset_required then
            update_player_shield_status_bar(status_bars, player_shield_radio, player_index)
        end
    end
    if show_player_battery then
        if player_battery_changed or reset_required then
            update_player_battery_status_bar(status_bars, player_battery_ratio, player_index)
        end
    end
    if show_armor_durability then
        if armor_durability_changed or reset_required then
            update_armor_durability_status_bar(status_bars, armor_durability_ratio, player_index)
        end
    end
    if show_vehicle_health then
        if vehicle_health_changed or reset_required then
            update_vehicle_health_status_bar(status_bars, vehicle_health_ratio, player_index)
        end
    end
    if show_vehicle_shield then
        if vehicle_shield_changed or reset_required then
            update_vehicle_shield_status_bar(status_bars, vehicle_shield_ratio, player_index)
        end
    end
    if show_vehicle_battery then
        if vehicle_battery_changed or reset_required then
            update_vehicle_battery_status_bar(status_bars, vehicle_battery_ratio, player_index)
        end
    end

    global.status_bar_counts[player_index] = status_bar_count

    global.status_bar_values[player_index] = {
        character_mining_progress = character_mining_progress,
        player_health_ratio = player_health_ratio,
        player_shield_radio = player_shield_radio,
        player_battery_ratio = player_battery_ratio,
        armor_durability_ratio = armor_durability_ratio,
        vehicle_health_ratio = vehicle_health_ratio,
        vehicle_shield_ratio = vehicle_shield_ratio,
        vehicle_battery_ratio = vehicle_battery_ratio,
    }

    if status_bar_count_changed or not status_bars.location then
        update_status_bar_location(player)
    end
end

local function on_tick()
    for _, player in pairs(game.connected_players) do
        refresh_status_bar_gui(player)
    end
end

script.on_event(defines.events.on_tick, on_tick)

---@param event EventData.on_player_display_resolution_changed|EventData.on_player_display_scale_changed
local function on_display_changed(event)
    local player = game.get_player(event.player_index)
    if not player then return end
    update_status_bar_location(player)
end

script.on_event(defines.events.on_player_display_resolution_changed, on_display_changed)
script.on_event(defines.events.on_player_display_scale_changed, on_display_changed)

-- script.on_event(defines.events.on_console_chat, function(event)
--     game.print("on_console_chat")
-- end)

-- script.on_event("toggle-console-link", function(event)
--     game.print("toggle-console-link")
-- end)
