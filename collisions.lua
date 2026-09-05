-- collisions --

-- checks if a particular cell coordinate in the map
-- has a solid tile (flag 0).
function is_solid(x,y)
    return fget(mget(x,y), 0) -- flag 0 == solid
end