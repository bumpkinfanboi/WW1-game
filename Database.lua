player = { -- base stats for player, is changed during gameplay (e.g. player.status.food = 25 ) but not permenantly changed (i.e. no file:write commands).
    status={
        body_parts={ --HP out of 440 (tarkov)
            head=35,
            thorax=85,
            stomach=70,
            left_arm=60,
            right_arm=60,
            left_leg=65,
            right_leg=65,
        },
        sustinance={
            food=100, --out of 100
            water=100, -- out of 100
            addictions={ -- t/f means if you have it, need is a counter that rises and has side effects
                cigarettes=false,
                cigarette_need=0,
                alcohol=false,
                alcohol_need=0,
            }
        },
        ailments={
            plauge=false, --t/f means if you have it, severity is a counter that rises and has side effects
            plague_severity=0,
            chlorine=false,
            chlorine_severity=0,
        },
    },
    inventory={
        equipped={
            head="empty",
            face="empty",
            uniform="empty",
            primary="empty",
            secondary="empty",
        },
        bag={
        },
        inventory_weight_max=70,
    },
}
maps = {
    trenches = {},
    dugouts = {},
    bunkers = {},
    types_of_trench = {"T","B","D","H","C"} --Trench (basic), Bunker [entrance], Dugout, Howitzer (artillery emplacement), Canteen
}
local arg1,arg2,arg3 = ...
introduction = [[
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