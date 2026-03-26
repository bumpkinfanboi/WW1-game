local database = assert(loadfile("database.lua"))
local to_save = nil
local file = nil
local input = nil
local function save_write(save_location, data)
    file = io.open("savefile", "r")
    to_save = file:read("a")
    file:close()
    if save_location == "class" then
        if string.find(to_save, "class") ~= "fail" then
            to_save = string.gsub(to_save, "{class = %a+}", "{class = "..data.."}")
        else to_save = "{class = "..data.."}"
        end
    end
    file = io.open("savefile", "w+")
    file:write(to_save)
    file:close()
end

local function save_game()
    -- TODO: write all data to savefile by copying database table(s)
end

local function create_character()
    -- TODO: take all the stuff from gameloop() if input == start and shove it here
end

local function game_loop()
    while true do
        input = io.read()
        if input == "start" then
            create_character()
            print(database("introduction"))
            input = io.read()
            if input == "Rifleman" then
                save_write("class", "Rifleman")
            end
            if input == "Raider" then
                save_write("class", "Raider")
            end
            if input == "Medic" then
                save_write("class", "Medic")
            end
            if input == "Officer" then
                save_write("class", "Officer")
            end
        elseif input == "quit" then
            print("Do you want to save?")
            input = io.read()
            if input == "y" or input == "Y" or input == "yes" or input "Yes" then save_game() break
            elseif input == "n" or input == "no" or input == "N" or input == "No" then break
            else print("Not a yes or no answer! (type either y, Y, yes, Yes, or n, N, no, No)")
            end
        end
    end
end
game_loop()
