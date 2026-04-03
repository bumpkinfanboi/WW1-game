require("database")
local arg1, arg2, arg3 = ...
local database = assert(loadfile("database.lua"))
local maps = {
    friendly_trenches = {
        starter_bunker = {
            size = {
                width = 15,
                height = 10,
            }
        }
    },
    no_mans_land = {},
    player_position,
}
local room = {}
local to_display = {}
local width = 0
local height = 0
if arg1 == "game_start" then
    player_position = {
        map = "starter_bunker",
        x = 10,
        y = 5,
    }
    for i=1,maps.friendly_trenches.starter_bunker.size.width do
        room[i] = {}
        width = width + 1
        for j=1,maps.friendly_trenches.starter_bunker.size.height do
            room[i][j] = "."
            height = height+1
        end
    end
    room[player_position.x][player_position.y] = "P"
    print(#room)
    to_display = {
        player_position = player_position,
        room_data = room,
        width = width,
        height = height/width,
    }
    return to_display
end