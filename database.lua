local player = { -- base stats, is changed during gameplay but not permenantly (no file:write)
    status={
        body_parts = { -- HP out of 440 (based on tarkov)
            head = 35,
            thorax = 85,
            stomach = 70,
            left_arm = 60,
            right_arm = 60,
            left_leg = 65,
            right_leg = 65,
        },
        sustinance = {
            hunger = 100, -- out of 100
            hydration = 100, -- out of 100
            addictions = { -- addictions.cigarette == true looks alot nicer compared to addictions.is_cigarette == true
                cigarette = false,
                cigarette_need = 0,
                alcohol = false,
                alcohol_need = 0,
            }
        },
        ailments = {
            plauge = false,
            plague_severity = 0,
            chlorine = false,
            chlorine_severity = 0,
        },
    },
    inventory = {
        equipped = {
            head = "empty",
            face = "empty",
            uniform = "empty",
            primary = "empty",
            secondary = "empty",
        },
        bag = {},
        inventory_weight_max = 70,
    },
}
local maps = { -- TODO: use this somewhere to shut up luachecker
    trenches = {},
    dugouts = {},
    bunkers = {},
    types_of_trench = {"T", "B", "D", "H", "C"} -- Trench (basic), Bunker [entrance], Dugout, Howitzer, Canteen
}
local arg1, arg2, arg3 = ... -- shut up i know some are unused luachecker (btw all files are run thru luachecker)
local introduction = [[
Select a class.
Rifleman:
    Basic infantry. Comes equipped with a rifle and a gas mask.
Raider:
    Trench Raider. Equipped with a carbine and a club.
Medic:
    Medical specialist. Issued with a handgun and basic medical equipment.
Officer:
    High ranking commander. Has a whistle for rallying troops and a handgun.]]
if arg1 == "introduction" then
    return introduction
end
if arg1 == "player" then
    return player
end