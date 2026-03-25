local Database = assert(loadfile("Database.lua"))
local to_save = nil
function save_write(save_location, data)
    file = io.open("Savefile", "r")
    to_save = file:read("a")
    file:close()
    if save_location == "Class" then
        if string.find(to_save, "Class") ~= "fail" then
            to_save = string.gsub(to_save, "{Class = %a+}", "{Class = "..data.."}")
        else to_save = "{Class = "..data.."}"
        end
    end
    file = io.open("Savefile", "w+")
    file:write(to_save)
    file:close()
end
function save_game()
    --TODO: write all data worth saving to Savefile by copying the Database tables (remember: they change at runtime to reflect the player) 
end
function create_character()
    --TODO: take all the stuff from gameloop() if input == start and shove it here
end
function game_loop()
    while true do
        input = io.read()
        if input == "start" then
            create_character()
            print(Database("introduction"))
            input = io.read()
            if input == "Rifleman" then
                save_write("Class", "Rifleman")
            end
            if input == "Raider" then
                save_write("Class", "Raider")
            end
            if input == "Medic" then
                save_write("Class", "Medic")
            end
            if input == "Officer" then
                save_write("Class", "Officer")
            end
        elseif input == "quit" then
            print("Do you want to save?")
            input = io.read()
            if input == "y" or input == "Y" or input == "yes" or input "Yes" then
                save_game()
                break
            elseif input == "n" or input == "no" or input == "N" or input == "No" then
                break
            else print("Not a yes or no answer! (type either y, Y, yes, Yes, or n, N, no, No)")
            end
            break
        end
    end
end
game_loop()
