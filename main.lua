require("database")
local database = assert(loadfile("database.lua"))
local input = nil
local amount_of_perks = 0

local file = io.open("savefile", "r")
local old_save = file:read("*all")
file:close()
local function save_write(save_location, data)
    if save_location == "class" then
        if string.find(old_save, "class") then
            old_save = string.gsub(old_save, "{class = %a+}", "{class = "..data.."}")
        else old_save = old_save.."{class = "..data.."}\n"
        end
    end
    if save_location == "perk" then
        if old_save == nil then
            old_save = "{perk "..amount_of_perks.." = "..data.."}\n"
        else
        old_save = old_save .. "{perk "..amount_of_perks.." = "..data.."}\n"
        end
        print(old_save)
    end
    if save_location == "difficulty" then
        if string.find(old_save, "difficulty") then
            old_save = string.gsub(old_save, "{difficulty = %a+}", "{difficulty = "..data.."}")
        else old_save = old_save.."{difficulty = "..data.."}\n"
        end
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

local function select_difficulty()
    while true do
        input = io.read()
        if input == "back" then print("Returning to main") break end
        if input == "quit" then
            print("quitting")
            os.exit()
        end
        if input == "Easy" then
            save_write("difficulty", "easy")
            return
        elseif input == "Medium" then
            save_write("difficulty", "medium")
            return
        elseif input == "Hard" then
            save_write("difficulty", "hard")
            return
        elseif input == "Custom" then
            print("NOT IMPLEMENTED YET") -- TODO: add custom difficulty
        else print("Not an option.") end
    end
end

local function create_character()
    print(database("introduction", 1))
    print('Type "back" to return.')
    select_class()
    print(database("introduction", 2))
    select_perks()
    print(database("introduction", 3)) -- TODO: add difficulties and custom options for difficulties
    select_difficulty()
    -- if difficulty == "custom" then print(database("introduction", 4))
    --create_custom_difficulty() end
    print(database("introduction", 5))
    print("Show image? Requires at least 200-character-wide display. Input 'confirm' to proceed.")
    input = io.read()
    if input == "confirm" then
        print(database("introduction", 6))
    else print("Image skipped.") end
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