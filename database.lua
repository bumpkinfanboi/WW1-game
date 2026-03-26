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
        mental_health = 100, -- each segment of 20 has its own quote (e.g. 100 = fine, 0 = insane rambling)
        sustinance = {
            hunger = 100, -- out of 100
            hydration = 100, -- out of 100
            addictions = { -- addictions.nicotine == true looks alot nicer compared to addictions.is_nicotine == true
                nicotine = false,
                nicotine_need = 0,
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
local introduction = {
step1 = [[
Select a class.
Rifleman:
    Basic infantry. Comes equipped with a rifle and a gas mask.
Raider:
    Trench Raider. Equipped with a carbine and a club.
Medic:
    Medical specialist. Issued with a handgun and basic medical equipment.
Officer:
    High ranking commander. Has a whistle for rallying troops and a handgun.]],
step2 = [[
Select two or more perks.
Scav:
    Always the opportunist, you pilfer whatever you can, even if it's not the best.
    Containers have 10% more items but at 0-30% reduced durability.
Insomniac:
    The artillery sounds are getting to you. You find it hard to stay asleep.
    You wake up one hour early but you have -1 move range and a random 10% negative modifier on accuracy)
Underage:
    Eager for the supposed spoils and glory of war, you did whatever you could to join the military. You lied on your recruitment papers.
    You have a permenant mental health boost and you require 15% less rations. Your carry capacity is reduced by 20%, you are +30% succeptable to addictions, and you take +10% damage.
blitzkrieg - when take dmg move speed up
mudinvincible - immune to mud debuffs but reduced total move speed
Cigarette Addict:
    War is hell. Healthy coping mechanisms are in short supply. You've grown reliant on Nicotine.
    When craving Nicotine, you have a 20% accuracy debuff and hunger drains 30% faster. When not craving Nicotine, gain +1 perception range. Gain a permenant Nicotine addiction.
Alcohol Addict:
    You hate it here. Everything gives you nightmares. Alcohol stops the bad thoughts.
    When not on Alcohol, your mental health drains 5% per hour. Alcohol's positive effect on your mood is doubled. Gain a permenant Alcohol addiction.

]] -- Underage gives a permenant +19% mood buff. The exact numbers are never shown to the player. 0-20% is worst, 21-40% is second worst.
}
local class_specific_dialogue = {}
if arg1 == "introduction" then
    return introduction[tostring("step"..arg2)]
end
if arg1 == "player" then
    return player
end