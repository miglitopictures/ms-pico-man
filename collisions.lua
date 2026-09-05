-- collisions --

solid=0

function is_solid(x,y)
 return fget(mget(x,y),solid)
end