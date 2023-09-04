
local bar_width = 467 -- width of hotbar
local bar_height = 13 -- height of original health bar
local caption = false

---@param gui_element LuaGuiElement
local function add_mining_status_bar(gui_element)
    gui_element.add {
        type = "progressbar",
        name = "sb_player_mining_progressbar",
        value = 0,
    }
    gui_element.sb_player_mining_progressbar.style = "sb_player_mining_progressbar"
    gui_element.sb_player_mining_progressbar.style.width = bar_width
    gui_element.sb_player_mining_progressbar.style.height = bar_height
    gui_element.sb_player_mining_progressbar.caption = caption and "Mining Progress" or ""
end

---@param gui_element LuaGuiElement
---@param value number
local function update_mining_status_bar(gui_element, value)
    if not gui_element.sb_player_mining_progressbar then
        add_mining_status_bar(gui_element)
    end
    gui_element.sb_player_mining_progressbar.value = value
end

---@param gui_element LuaGuiElement
local function add_armor_durability_status_bar(gui_element)
    gui_element.add {
        type = "progressbar",
        name = "sb_armor_durability_progressbar",
        value = 0,
    }
    gui_element.sb_armor_durability_progressbar.style = "sb_armor_durability_progressbar"
    gui_element.sb_armor_durability_progressbar.style.width = bar_width
    gui_element.sb_armor_durability_progressbar.style.height = bar_height
    gui_element.sb_armor_durability_progressbar.caption = caption and "Armor Durability" or ""
end

---@param gui_element LuaGuiElement
---@param value number
local function update_armor_durability_status_bar(gui_element, value)
    if not gui_element.sb_armor_durability_progressbar then
        add_armor_durability_status_bar(gui_element)
    end
    gui_element.sb_armor_durability_progressbar.value = value
end

---@param gui_element LuaGuiElement
local function add_player_health_status_bar(gui_element)
    gui_element.add {
        type = "progressbar",
        name = "sb_player_health_progressbar",
        value = 1,
    }
    gui_element.sb_player_health_progressbar.style = "sb_player_health_progressbar"
    gui_element.sb_player_health_progressbar.style.width = bar_width
    gui_element.sb_player_health_progressbar.style.height = bar_height
    gui_element.sb_player_health_progressbar.caption = caption and "Player Health" or ""
end

---@param gui_element LuaGuiElement
---@param value number
local function update_player_health_status_bar(gui_element, value)
    if not gui_element.sb_player_health_progressbar then
        add_player_health_status_bar(gui_element)
    end
    gui_element.sb_player_health_progressbar.value = value
end

---@param gui_element LuaGuiElement
local function add_vehicle_health_status_bar(gui_element)
    gui_element.add {
        type = "progressbar",
        name = "sb_vehicle_health_progressbar",
        value = 1,
    }
    gui_element.sb_vehicle_health_progressbar.style = "sb_vehicle_health_progressbar"
    gui_element.sb_vehicle_health_progressbar.style.width = bar_width
    gui_element.sb_vehicle_health_progressbar.style.height = bar_height
    gui_element.sb_vehicle_health_progressbar.caption = caption and "Vehicle Health" or ""
end

---@param gui_element LuaGuiElement
---@param value number
local function update_vehicle_health_status_bar(gui_element, value)
    if not gui_element.sb_vehicle_health_progressbar then
        add_vehicle_health_status_bar(gui_element)
    end
    gui_element.sb_vehicle_health_progressbar.value = value
end

---@param gui_element LuaGuiElement
local function add_player_shield_status_bar(gui_element)
    gui_element.add {
        type = "progressbar",
        name = "sb_player_shield_progressbar",
        value = 0,
    }
    gui_element.sb_player_shield_progressbar.style = "sb_player_shield_progressbar"
    gui_element.sb_player_shield_progressbar.style.width = bar_width
    gui_element.sb_player_shield_progressbar.style.height = bar_height
    gui_element.sb_player_shield_progressbar.caption = caption and "Armor Shield" or ""
end

---@param gui_element LuaGuiElement
---@param value number
local function update_player_shield_status_bar(gui_element, value)
    if not gui_element.sb_player_shield_progressbar then
        add_player_shield_status_bar(gui_element)
    end
    gui_element.sb_player_shield_progressbar.value = value
end

---@param gui_element LuaGuiElement
local function add_vehicle_shield_status_bar(gui_element)
    gui_element.add {
        type = "progressbar",
        name = "sb_vehicle_shield_progressbar",
        value = 0,
    }
    gui_element.sb_vehicle_shield_progressbar.style = "sb_vehicle_shield_progressbar"
    gui_element.sb_vehicle_shield_progressbar.style.width = bar_width
    gui_element.sb_vehicle_shield_progressbar.style.height = bar_height
    gui_element.sb_vehicle_shield_progressbar.caption = caption and "Vehicle Shield" or ""
end

---@param gui_element LuaGuiElement
---@param value number
local function update_vehicle_shield_status_bar(gui_element, value)
    if not gui_element.sb_vehicle_shield_progressbar then
        add_vehicle_shield_status_bar(gui_element)
    end
    gui_element.sb_vehicle_shield_progressbar.value = value
end

---@param gui_element LuaGuiElement
local function add_player_battery_status_bar(gui_element)
    gui_element.add {
        type = "progressbar",
        name = "sb_player_battery_progressbar",
        value = 0,
    }
    gui_element.sb_player_battery_progressbar.style = "sb_player_battery_progressbar"
    gui_element.sb_player_battery_progressbar.style.width = bar_width
    gui_element.sb_player_battery_progressbar.style.height = bar_height
    gui_element.sb_player_battery_progressbar.caption = caption and "Armor Battery" or ""
end

---@param gui_element LuaGuiElement
---@param value number
local function update_player_battery_status_bar(gui_element, value)
    if not gui_element.sb_player_battery_progressbar then
        add_player_battery_status_bar(gui_element)
    end
    gui_element.sb_player_battery_progressbar.value = value
end

---@param gui_element LuaGuiElement
local function add_vehicle_battery_status_bar(gui_element)
    gui_element.add {
        type = "progressbar",
        name = "sb_vehicle_battery_progressbar",
        value = 0,
    }
    gui_element.sb_vehicle_battery_progressbar.style = "sb_vehicle_battery_progressbar"
    gui_element.sb_vehicle_battery_progressbar.style.width = bar_width
    gui_element.sb_vehicle_battery_progressbar.style.height = bar_height
    gui_element.sb_vehicle_battery_progressbar.caption = caption and "Vehicle Battery" or ""
end

---@param gui_element LuaGuiElement
---@param value number
local function update_vehicle_battery_status_bar(gui_element, value)
    if not gui_element.sb_vehicle_battery_progressbar then
        add_vehicle_battery_status_bar(gui_element)
    end
    gui_element.sb_vehicle_battery_progressbar.value = value
end

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
        local status_bar_height = (bar_height * status_bar_count) + (0 * (status_bar_count - 1)) -- 4 is the padding between bars
        local status_bar_width = bar_width
        status_bar_height = status_bar_height * display_scale
        status_bar_width = status_bar_width * display_scale
        local width_offset = 24
        width_offset = width_offset * display_scale
        local location = {
            x = (display_width / 2) - (status_bar_width / 2) - width_offset,
            y = display_height - hotbar_height - status_bar_height,
        }
        screen.sb_status_bars.location = location
    end
end

---@param player LuaPlayer
local function refresh_status_bar_gui(player)
    local screen = player.gui.screen
    if not screen.sb_status_bars then
        screen.add {
            type = "flow",
            name = "sb_status_bars",
            direction = "vertical",
        }
    end
    local status_bars = screen.sb_status_bars
    if not status_bars then return end
    status_bars.style.vertical_spacing = 0

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

        player_health_ratio = tonumber(character.get_health_ratio()) or 0

        local armor = character.get_inventory(defines.inventory.character_armor)[1]
        if armor and armor.valid_for_read then

            local grid = armor.grid
            if grid then

                local shield = grid.shield
                local max_shield = grid.max_shield
                if shield and max_shield then
                    player_shield_radio = shield / max_shield
                end

                local battery_charge = grid.available_in_batteries
                local battery_capacity = grid.battery_capacity
                if battery_charge and battery_capacity then
                    player_battery_ratio = battery_charge / battery_capacity
                end
            end

            local durability = armor.durability
            local max_durability = armor.prototype.durability
            if durability and max_durability then
                armor_durability_ratio = durability / max_durability
            end
        end
    end

    local vehicle = player.vehicle
    if vehicle then

        local health = vehicle.health
        local max_health = vehicle.prototype.max_health
        if health and max_health then
            vehicle_health_ratio = health / max_health
        end

        local grid = vehicle.grid
        if grid then

            local shield = grid.shield
            local max_shield = grid.max_shield
            if shield and max_shield then
                vehicle_shield_ratio = shield / max_shield
            end

            local battery_charge = grid.available_in_batteries
            local battery_capacity = grid.battery_capacity
            if battery_charge and battery_capacity then
                vehicle_battery_ratio = battery_charge / battery_capacity
            end
        end
    end

    local show_mining_progress_bar = character_mining_progress > 0 and character_mining_progress < 1
    local show_player_health_bar = player_health_ratio > 0 and player_health_ratio < 1
    local show_player_shield_bar = player_shield_radio > 0 and player_shield_radio < 1
    local show_player_battery_bar = player_battery_ratio > 0 and player_battery_ratio < 1
    local show_armor_durability_bar = armor_durability_ratio > 0 and armor_durability_ratio < 1
    local show_vehicle_health_bar = vehicle_health_ratio > 0 and vehicle_health_ratio < 1
    local show_vehicle_shield_bar = vehicle_shield_ratio > 0 and vehicle_shield_ratio < 1
    local show_vehicle_battery_bar = vehicle_battery_ratio > 0 and vehicle_battery_ratio < 1

    if show_mining_progress_bar then
        status_bar_count = status_bar_count + 1
    end
    if show_player_health_bar then
        status_bar_count = status_bar_count + 1
    end
    if show_player_shield_bar then
        status_bar_count = status_bar_count + 1
    end
    if show_player_battery_bar then
        status_bar_count = status_bar_count + 1
    end
    if show_armor_durability_bar then
        status_bar_count = status_bar_count + 1
    end
    if show_vehicle_health_bar then
        status_bar_count = status_bar_count + 1
    end
    if show_vehicle_shield_bar then
        status_bar_count = status_bar_count + 1
    end
    if show_vehicle_battery_bar then
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
    if (show_mining_progress_bar and not mining_progress_element) or (not show_mining_progress_bar and mining_progress_element) then
        reset_required = true
    end
    if (show_player_health_bar and not player_health_element) or (not show_player_health_bar and player_health_element) then
        reset_required = true
    end
    if (show_player_shield_bar and not player_shield_element) or (not show_player_shield_bar and player_shield_element) then
        reset_required = true
    end
    if (show_player_battery_bar and not player_battery_element) or (not show_player_battery_bar and player_battery_element) then
        reset_required = true
    end
    if (show_armor_durability_bar and not armor_durability_element) or (not show_armor_durability_bar and armor_durability_element) then
        reset_required = true
    end
    if (show_vehicle_health_bar and not vehicle_health_element) or (not show_vehicle_health_bar and vehicle_health_element) then
        reset_required = true
    end
    if (show_vehicle_shield_bar and not vehicle_shield_element) or (not show_vehicle_shield_bar and vehicle_shield_element) then
        reset_required = true
    end
    if (show_vehicle_battery_bar and not vehicle_battery_element) or (not show_vehicle_battery_bar and vehicle_battery_element) then
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
    local last_status_bar_values = global.status_bar_values[player.index] or {}

    local mining_progress_changed = character_mining_progress ~= last_status_bar_values.character_mining_progress
    local player_health_changed = player_health_ratio ~= last_status_bar_values.player_health_ratio
    local player_shield_changed = player_shield_radio ~= last_status_bar_values.player_shield_radio
    local player_battery_changed = player_battery_ratio ~= last_status_bar_values.player_battery_ratio
    local armor_durability_changed = armor_durability_ratio ~= last_status_bar_values.armor_durability_ratio
    local vehicle_health_changed = vehicle_health_ratio ~= last_status_bar_values.vehicle_health_ratio
    local vehicle_shield_changed = vehicle_shield_ratio ~= last_status_bar_values.vehicle_shield_ratio
    local vehicle_battery_changed = vehicle_battery_ratio ~= last_status_bar_values.vehicle_battery_ratio

    if show_mining_progress_bar then
        if mining_progress_changed or reset_required then
            update_mining_status_bar(status_bars, character_mining_progress)
        end
    end
    if show_player_health_bar then
        if player_health_changed or reset_required then
            update_player_health_status_bar(status_bars, player_health_ratio)
        end
    end
    if show_player_shield_bar then
        if player_shield_changed or reset_required then
            update_player_shield_status_bar(status_bars, player_shield_radio)
        end
    end
    if show_player_battery_bar then
        if player_battery_changed or reset_required then
            update_player_battery_status_bar(status_bars, player_battery_ratio)
        end
    end
    if show_armor_durability_bar then
        if armor_durability_changed or reset_required then
            update_armor_durability_status_bar(status_bars, armor_durability_ratio)
        end
    end
    if show_vehicle_health_bar then
        if vehicle_health_changed or reset_required then
            update_vehicle_health_status_bar(status_bars, vehicle_health_ratio)
        end
    end
    if show_vehicle_shield_bar then
        if vehicle_shield_changed or reset_required then
            update_vehicle_shield_status_bar(status_bars, vehicle_shield_ratio)
        end
    end
    if show_vehicle_battery_bar then
        if vehicle_battery_changed or reset_required then
            update_vehicle_battery_status_bar(status_bars, vehicle_battery_ratio)
        end
    end

    global.status_bar_counts[player.index] = status_bar_count

    global.status_bar_values[player.index] = {
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