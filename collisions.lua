-- collisions --

-- colision flag (materials)
solid=0
-- sprite collision numbers
dot=14
bigdot=15
-- fruit=


-- checks if a particular cell coordinate (x,y) in the map
-- has a specified sprite(sp).
function is(x, y, sp)
    return mget(x,y) == sp
end
-- checks if a particular cell coordinate in the map
-- has a solid tile (flag 0).
function is_solid(x,y)
    return fget(mget(x,y), solid) -- flag 0 == solid
end