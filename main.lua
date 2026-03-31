require("database")
local database = assert(loadfile("database.lua"))
local input = nil
local amount_of_perks = 0

local file = io.open("savefile", "r")
local old_save = file:read("*all")
file:close()
local function save_write(save_location, data)
    if save_location == "class" then -- TODO: make this use old_save instead of manipulating old_save.
        if string.find(old_save, "class") then
            old_save = string.gsub(old_save, "{class = %a+}", "{class = "..data.."}")
        else old_save = old_save.."{class = "..data.."}\n"
        end
    end
    if save_location == "perk" then
        if old_save == nil then  -- spite fix
            old_save = "{perk "..amount_of_perks.." = "..data.."}\n"
        else
        old_save = old_save .. "{perk "..amount_of_perks.." = "..data.."}\n"
        end
        print(old_save)
    end
end

local function save_game()
    if old_save == nil then print("Nothing to save!") return end
    print(old_save.."finalsave")
    file = io.open("savefile", "w+")
    file:write(old_save.."\n")
    file:close()
    print("Saved!")
end
local perks = {
    Scav = false,
    Insomniac = false,
    Underage = false,
    Flat_Footed = false,
    Immunocomprimised = false,
    Institutionalized = false,
    Far_Sighted = false,
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
        if input == "confirm" then
            if amount_of_perks >= 2 then
                print("confirmed!")
                save_game()
                break
            else print("not enough perks!") end
        end
        if input == "quit" then
            save_game()
            print("quitting!")
            os.exit()
        end
    end
end

local function select_class()
    while true do
        input = io.read()
        if input == "back" then print("Returning to main") break end -- quits back to game_loop()
        if input == "quit" then
            print("quitting!")
            os.exit()
        end
        if input == "Rifleman" then -- start of step 1
            save_write("class", "Rifleman")
            return
        elseif input == "Raider" then
            save_write("class", "Raider")
            return
        elseif input == "Medic" then
            save_write("class", "Medic")
            return
        elseif input == "Officer" then
            save_write("class", "Officer")
            return
        elseif input == "Spotter" then
            save_write("class", "Spotter")
            return
        else print("Not a class.") end
    end
end
local function create_character()
    print(database("introduction", 1))
    print('Type "back" to return.')
    select_class()
    print(database("introduction", 2))
    select_perks()
    --print(database("introduction", 3)) -- TODO: add difficulties and custom options for difficulties
    --select_difficulty()
    --if difficulty == "custom" then print(database("introduction", 4)) create_custom_difficulty()
    print(database("introduction", 5))
    print(database("introduction", 6))
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
