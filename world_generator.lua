require("database")
local arg1, arg2, arg3 = ...
local database = assert(loadfile("database.lua"))
--[[
Like seriously I don't know what I'm doing. I need a comprehensive way to generate not just
boxy rooms, but trenches that are zig-zag or V shaped or bunkers too.
How am I going to generate and store this data? What is the role of main.lua vs world_generator?
How do I call the world and player coordinates to display? Where do I store this information?
I have 0 plan for this and I think I was procrastinating actually starting the hard part...]]