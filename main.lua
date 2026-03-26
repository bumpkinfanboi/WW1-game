require("database")
local database = assert(loadfile("database.lua"))
local to_save = nil
local file = nil
local input = nil
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
end

local function save_game()
    if to_save == nil then print("Nothing to save!") return end
    file = io.open("savefile", "w")
    file:write(to_save)
    file:close()
    print("Saved!")
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
        else print("Not a class.") end
        print(database("introduction", 2))-- start of step 2
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
