-- collisions --

-- checks if a particular cell coordinate in the map
-- has a solid tile (flag 0).
function is_solid(x,y)
    return fget(mget(x,y), 0) -- flag 0 == solid
end

-- checks if a particular pixel coordinate in the map
-- has a solid tile (flag 0).
function is_solid_coord(x,y)
    return fget(mget(flr(x / 8),flr(y / 8)), 0) -- flag 0 == solid
end