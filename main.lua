require("database")
local database = assert(loadfile("database.lua"))
local to_save = nil
local file = nil
local input = nil
local amount_of_perks = 0
local function save_write(save_location, data)
    file = io.open("savefile", "a+")
    to_save = file:read("*all")
    file:close()
    if save_location == "class" then
        if string.find(to_save, "class") then
            to_save = string.gsub(to_save, "{class = %a+}", "{class = "..data.."}")
        else to_save = to_save.."\n{class = "..data.."}"
        end
    end
    if save_location == "perk" then
        print(to_save)
        to_save = to_save.." \n {perk = "..data.."}"
        print(to_save)
    end
end

local function save_game()
    if to_save == nil then print("Nothing to save!") return end
    file = io.open("savefile", "w+")
    file:write(to_save)
    file:close()
    print("Saved!")
end

local function select_perks()
    local perk_selected = {
        Scav = false,
        Insomniac = false,
        Underage = false,
        Flat_Footed = false,
        Immunocomprimised = false,
        -- TODO: FINISH THIS
    }
    while true do
        local amount_of_perks = 0
        for k, v in pairs(perk_selected) do
            amount_of_perks = amount_of_perks + 1
            print(k)
        end
        print("You have "..amount_of_perks.." perks selected.")
        input = io.read()
        if input == "confirm" then break end
        if input == "quit" then
            save_game()
            os.exit()
        end
        if input == "Scav" then perk_selected.Scav = true end
        if input == "Insomniac" then perk_selected.Insomniac = true end
        if input == "Underage" then perk_selected.Underage = true end
        if input == "Flat Footed" then perk_selected.Flat_Footed = true end
        if input == "Immunocomprimised" then perk_selected.Immunocomprimised = true end
        if input == "Pack Mule" then perk_selected.Pack_Mule = true end
        if input == "Cigarette Addict" then perk_selected.Cigarette_Addict = true end
        if input == "Alcohol Addict" then perk_selected.Alcohol_Addict = true end

    end
end

local function create_character()
    print(database("introduction", 1))
    print('Type "back" to return.')
    while true do
        input = io.read()
        if input == "back" then print("Returning to main") break end -- quits back to game_loop() 
        if input == "quit" then
            save_game()
            os.exit()
        end
        if input == "Rifleman" then -- start of step 1
            save_write("class", "Rifleman")
        elseif input == "Raider" then
            save_write("class", "Raider")
        elseif input == "Medic" then
            save_write("class", "Medic")
        elseif input == "Officer" then
            save_write("class", "Officer")
        elseif input == "Spotter" then
            save_write("class", "Spotter")
        else print("Not a class.") end
        print(database("introduction", 2))-- start of step 2
        select_perks()
    end
end

local function game_loop()
    while true do
        input = io.read()
        if input == "start" then create_character()
        elseif input == "quit" then
            print("Saving!")
            save_game()
            break
        end
    end
end
game_loop()
