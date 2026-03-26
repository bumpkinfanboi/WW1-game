require("database")
local database = assert(loadfile("database.lua"))
local to_save = nil
local to_add_to_save = nil
local file = nil
local input = nil
local amount_of_perks = 0
local function save_write(save_location, data)
    file = io.open("savefile", "a+")
    to_save = file:read("*all") -- this overwrites tosave every time it runs, therefore causing it to overwrite itself
    file:close()
    if save_location == "class" then
        if string.find(to_save, "class") then
            to_save = string.gsub(to_save, "{class = %a+}", "{class = "..data.."}")
        else to_save = to_save.."{class = "..data.."}\n"
        end
    end
    if save_location == "perk" then
        if to_add_to_save == nil then  -- spite fix
            to_add_to_save = "{perk "..amount_of_perks.." = "..data.."}\n"
        else
        to_add_to_save = to_add_to_save .. "{perk "..amount_of_perks.." = "..data.."}\n"
        end
        print(to_add_to_save)
    end
end

local function save_game()
    if to_save == nil then print("Nothing to save!") return end
    print(to_save.."finalsave")
    file = io.open("savefile", "w+")
    file:write(to_save.."\n"..to_add_to_save)
    file:close()
    print("Saved!")
end
local perks = {
    Scav = false,
    Insomniac = false,
    Underage = false,
    Flat_Footed = false,
    Immunocomprimised = false,
    Pack_Mule = false,
    Cigarette_Addict = false,
    Alcohol_Addict = false,
}
local function select_perks()
    while true do
        input = io.read()
        for k, v in pairs(perks) do
            if input == k then
                amount_of_perks = amount_of_perks + 1
                perks[k] = true
                save_write("perk", k)
            end
        end
        if input == "quit" then break end
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
