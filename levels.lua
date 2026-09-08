lvl = 1

f = {
	cherries = { sp = 32, bonus = 100 },
	strawberry = { sp = 33, bonus = 300 },
	peach = { sp = 34, bonus = 500 },
	apple = { sp = 35, bonus = 700 },
	grapes = { sp = 36, bonus = 1000 },
	galaxian = { sp = 37, bonus = 2000 },
	bell = { sp = 38, bonus = 3000 },
	key = { sp = 39, bonus = 5000 }
}

cfgs = {
    mode_time = {
        [1] = {7,20,7,20,5,10  ,5},
        [2] = {7,20,7,20,5,1033,1/30},
        [5] = {5,20,5,20,5,1037,1/30},
    },
    fruit = {
        [1] = f.cherries, 
        [2] = f.strawberry,
        [3] = f.peach,      -- 03 and 04
        [5] = f.apple,      -- 05 and 06
        [7] = f.grapes,     -- 07 and 08
        [9] = f.galaxian,   -- 09 and 10
        [11] = f.bell,      -- 11 and 12
        [13] = f.key,       -- 13+
    },
    p = {
        [1] = {spd = 80, fspd = 90},
        [2] = {spd = 90, fspd = 95},   -- 03 to 04
        [5] = {spd = 100, fspd = 100}, -- 05 to 20
        [21] = {spd = 90, fspd = 90},  -- 21+
    },
    g = {
        [1] = {spd = 75, fspd = 50, tnlspd = 40},
        [2] = {spd = 85, fspd = 55, tnlspd = 45}, -- 2 to 4
        [5] = {spd = 95, fspd = 60, tnlspd = 50}, -- 5+
    },
    elroy = {
        dt_left = {
            [1]  = {20, 10},
            [2]  = {30, 15},
            [3]  = {40, 20},  -- 3 to 5
            [6]  = {50, 25},  -- 6 to 8
            [9]  = {60, 30},  -- 9 to 11
            [12] = {80, 40},  -- 12 to 14
            [15] = {100, 50}, -- 15 to 18
            [19] = {120, 60}, -- 19 +
        },
        spd = {
            [1] = { 80,  85},
            [2] = { 90,  95},  -- 2 to 4
            [5] = { 100, 105}, -- 5+
        }
    },

    fright = {
        [1]  = 6,
        [2]  = 5,
        [3]  = 4,
        [4]  = 3,
        [5]  = 2,
        [6]  = 5,
        [7]  = 2, -- 7 and 8
        [9]  = 1, 
        [10] = 5,
        [11] = 2,
        [12] = 1, -- 12 and 13
        [14] = 3,
        [15] = 1, -- 15 and 16
        [17] = 0,
        [18] = 1,
        [19] = 0  -- 19 +
    },
}

function cfg_lookup(t, lvl)
    for l = lvl, 1, -1 do
        if t then return t[l] end
    end
end