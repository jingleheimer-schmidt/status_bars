
local bar_width = 467 -- width of hotbar
local bar_height = 13 -- height of original health bar

---@param gui_element LuaGuiElement
local function add_mining_status_bar(gui_element)
    gui_element.add {
        type = "progressbar",
        name = "player_mining_progressbar",
        value = 0,
    }
    gui_element.player_mining_progressbar.style = "sb_player_mining_progressbar"
    gui_element.player_mining_progressbar.style.width = bar_width
    gui_element.player_mining_progressbar.style.height = bar_height
    gui_element.player_mining_progressbar.caption = "Mining Progress"
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
    gui_element.sb_armor_durability_progressbar.caption = "Armor Durability"
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
    gui_element.sb_player_health_progressbar.caption = "Player Health"
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
    gui_element.sb_vehicle_health_progressbar.caption = "Vehicle Health"
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
    gui_element.sb_player_shield_progressbar.caption = "Armor Shield"
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
    gui_element.sb_vehicle_shield_progressbar.caption = "Vehicle Shield"
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
        local status_bar_height = (bar_height * status_bar_count) + (15 * (status_bar_count - 1)) -- 4 is the padding between bars
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
    if screen.sb_status_bars then
        screen.sb_status_bars.destroy()
    end
    screen.add {
        type = "flow",
        name = "sb_status_bars",
        direction = "vertical",
    }
    local status_bars = screen.sb_status_bars
    if not status_bars then return end
    status_bars.style.vertical_spacing = 0

    local status_bar_count = 0

    if player.mining_state.mining then
        add_mining_status_bar(status_bars)
        local progress = player.character_mining_progress
        status_bars.player_mining_progressbar.value = progress
        status_bar_count = status_bar_count + 1
    end

    local character = player.character
    if character then

        local health_remaining = tonumber(character.get_health_ratio()) or 0
        if health_remaining > 0 and health_remaining < 1 then
            add_player_health_status_bar(status_bars)
            status_bars.sb_player_health_progressbar.value = health_remaining
            status_bar_count = status_bar_count + 1
        end

        local armor = character.get_inventory(defines.inventory.character_armor)[1]
        if armor and armor.valid_for_read then

            local grid = armor.grid
            if grid then
                local shield = grid.shield
                local max_shield = grid.max_shield
                if shield and max_shield then
                    local shield_remaining = shield / max_shield
                    if shield_remaining > 0 and shield_remaining < 1 then
                        add_player_shield_status_bar(status_bars)
                        status_bars.sb_player_shield_progressbar.value = shield_remaining
                        status_bar_count = status_bar_count + 1
                    end
                end
            end

            local durability = armor.durability
            if durability then
                local max_durability = armor.prototype.durability
                local durability_remaining = durability / max_durability
                if durability_remaining > 0 and durability_remaining < 1 then
                    add_armor_durability_status_bar(status_bars)
                    status_bars.sb_armor_durability_progressbar.value = durability_remaining
                    status_bar_count = status_bar_count + 1
                end
            end
        end
    end

    local vehicle = player.vehicle
    if vehicle then

        local max_health = vehicle.prototype.max_health
        local health = vehicle.health
        local health_remaining = health / max_health
        if health_remaining > 0 and health_remaining < 1 then
            add_vehicle_health_status_bar(status_bars)
            status_bars.sb_vehicle_health_progressbar.value = health_remaining
            status_bar_count = status_bar_count + 1
        end

        local grid = vehicle.grid
        if grid then
            local shield = grid.shield
            local max_shield = grid.max_shield
            if shield and max_shield then
                local shield_remaining = shield / max_shield
                if shield_remaining > 0 and shield_remaining < 1 then
                    add_vehicle_shield_status_bar(status_bars)
                    status_bars.sb_vehicle_shield_progressbar.value = shield_remaining
                    status_bar_count = status_bar_count + 1
                end
            end
        end
    end

    global.status_bar_counts = global.status_bar_counts or {}
    global.status_bar_counts[player.index] = status_bar_count

    update_status_bar_location(player)
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