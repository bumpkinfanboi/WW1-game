require("database")
local arg1, arg2, arg3 = ...
local database = assert(loadfile("database.lua"))
--[[
Like seriously I don't know what I'm doing. I need a comprehensive way to generate not just
boxy rooms, but trenches that are zig-zag or V shaped or bunkers too.
How am I going to generate and store this data? What is the role of main.lua vs world_generator?
How do I call the world and player coordinates to display? Where do I store this information?
I have 0 plan for this and I think I was procrastinating actually starting the hard part...]]
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
if arg1 == "game_start" then
    player_position = {
        map = "starter_bunker",
        x = 10,
        y = 5,
    }
    for i=1,maps.friendly_trenches.starter_bunker.size.width do
        room[i] = {}
        for j=1,maps.friendly_trenches.starter_bunker.size.height do
            room[i][j] = "."
        end
    end
    room[player_position.x][player_position.y] = "P"
    print(#room)
    to_display = {
        player_position = player_position,
        room = room,
    }
    return to_display
end