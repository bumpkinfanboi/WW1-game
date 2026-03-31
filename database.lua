local player = { -- base stats, is changed during gameplay but not permenantly (no file:write)
    status={
        body_parts = { -- HP out of 440 (based on tarkov, also cant see this directly)
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
    High ranking commander. Has a whistle for rallying troops and a sabre.
Spotter:
    Artillery fire director. Assigned a radio backpack and a handgun.]],
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
    You have a 19% mental health boost and you require 15% less rations. Your carry capacity is reduced by 20%, you are +30% succeptable to addictions, and you take +10% damage.
Flat_Footed:
    A hereditary condition. Your flat feet help against the sea of mud. You cannot run like the others.
    Immune to terrain move debuffs like mud. You only have 80% base movement speed. Injuries to the legs take much longer to heal.
Immunocomprimised:
    You got sick. Very sick. The scars of the disease still haunt you. Now your either variolated and recover quickly, or completely crippled until the sickness burns through you.
    Infections give permenant scarring. +40% infection chance, but +25% wound healing speed if not infected.
Institutionalized:
    They saw you as diseased. They locked you away from society, chained and starved. They never truly broke you.
    10% morale boost, +15% melee hit chance, but you start without a weapon.
Far_Sighted:
    Spending your days watching birds, you can't see up close as well as you used to.
    -20% melee hit chance, +10% accuracy. 5% morale boost when outdoors.
Pack_Mule:
    Your hoarding has led to a compulsion to collect what you find. Your back has grown stronger, but your legs struggle against the strain.
    Carry capacity is increased 20% and containers have increased capacity. Base movement speed is 70%.
Cigarette_Addict:
    War is hell. Healthy coping mechanisms are in short supply. You've grown reliant on Nicotine.
    When craving Nicotine, you have a 20% accuracy debuff and hunger drains 30% faster. When not craving Nicotine, gain +1 perception range. Gain a permenant Nicotine addiction.
Alcohol_Addict:
    You hate it here. Everything gives you nightmares. Alcohol stops the bad thoughts.
    When not on Alcohol, your mental health drains 5% per hour. Alcohol's positive effect on your mood is doubled. Gain a permenant Alcohol addiction.]], -- TODO: remove exact morale numbers and write them down somewhere else
step3 = [[
Select a difficulty.
Easy:
    insert difficulty settings
Medium:
    insert difficulty settings
Hard:
    insert difficulty settings
Custom:
    ]], -- TODO: all of this
step4 = [[
add custom options for difficulty]], 
}
local dialogue = {
    class_specific = {},
    general = {}
}
if arg1 == "introduction" then
    return introduction[tostring("step"..arg2)]
end
if arg1 == "player" then
    return player
end