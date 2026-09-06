-- ghosts --
directions = {
    {0 ,-1}, -- up
    {-1, 0}, -- left
    {0 , 1}, -- down
    {1 , 0}  -- right
} 

states = {
	chase = 0,
	scatter = 1,
	scared = 2, -- frightened
	eaten = 3, -- frightened
}


home = { x = 63, y = 63}
ghosts = {
    {name = "blinky", scatter = {x=0,y=0}}, -- red
    {name = "pinky",  scatter = {x=0,y=128}}, -- pink
    {name = "inky",   scatter = {x=128,y=128}}, -- blue
    {name = "clyde",  scatter = {x=128,y=0}}  -- orange
}

-- sets up the ghost entity in specified coordinate --
function init_ghost(ghost, x, y)
	-- set inital position
	ghost.x = x
	ghost.y = y
	
	-- set inital possible moves set
	ghost.available={}
	
	-- set initial eaten flag (main state, over global ghost state)
	ghost.iseaten = false
	ghost.state = states.chase
	ghost.sp = 16
	
	-- best and last move vectors
	ghost.best={0,0}
	ghost.lastmove={0,0}
	
	ghost.move_counter=8
	
	ghost.scatter_timer = 5 * 30 -- 5 seconds
	ghost.scared_timer = 10 * 30 -- 10 seconds

	-- setup starting target
	ghost.target={x=rnd(128),y=rnd(128)}

	-- setup debug color	
	-- using local names for readability
	local name = ghost.name
	local c = 4
	if name == "blinky" then c=8  end
	if name == "pinky"  then c=14 end
	if name == "inky"   then c=12 end
	if name == "clyde"  then c=9  end
	ghost.c = c
end

-- update ghosts every frame
function update_ghost(ghost)
	-- scared timer
	if ghost.state == states.scared then
		if ghost.scared_timer <= 0 then
			ghost.state = states.chase
			ghost.sp = 16
		else
			ghost.scared_timer -= 1
		end
	end
	

	-- collisions
	if ghost.state == states.eaten then
		if dist(ghost, home) <=  4 then 
			ghost.state = states.chase
		end
	else
		-- collided with pacman
		if (not pac.isdead) and (dist(ghost, pac) <  4) then
			if ghost.state == states.scared then 
				ghost.state = states.eaten
				ghost.sp = 16
			else
				hp -= 1
				pac.isdead = true
			end
		end
	end

	-- calculate movement
	-- if ghost can change direction
	if ghost.move_counter == 0 then
		-- update possible moves
		ghost.available = possible_moves(ghost)
		
		if ghost.state == states.scared then
			--pick random direction
			ghost.best = rnd(ghost.available)
		else
			-- move towards A target
			if ghost.state == states.eaten then
				ghost.target = home
			elseif ghost.state == states.chase then
				update_target(ghost) -- pacman is target
			elseif ghost.state == states.scatter then
				ghost.target = ghost.scatter -- go to scatter point
			end
			-- update best move acording to target
			ghost.best = best_move(ghost)
		end

		
		-- reset counter
		ghost.move_counter = 8
	end
	
	move_ghost(ghost)
	
	-- wrap around
	ghost.x = ghost.x % 128
	ghost.y = ghost.y % 128
end


-- moves ghost in current best direction, and updates the its move_counter
function move_ghost(ghost)
	-- update position
	ghost.x+=ghost.best[1]
	ghost.y+=ghost.best[2]
	-- save last move
	ghost.lastmove = ghost.best
	-- update move counter
	ghost.move_counter -= 1
end

-- calculates all possible moves and returns them in a table
function possible_moves(entity)
	-- declare a table of possible moves.
	local possible = {}
	
	-- get the "back" direction
	local back = {-entity.lastmove[1], -entity.lastmove[2]}
	
	-- loop through all directions
	for dir in all(directions) do
	    -- ignore if is back
		local is_back = (dir[1] == back[1] and dir[2] == back[2])
		if not is_back then
			-- check if will colide
			local nx = flr((entity.x + 4) / 8) + dir[1]
			local ny = flr((entity.y + 4) / 8) + dir[2]
			if not is_solid(nx, ny) then
				-- add is to the the table!
				add(possible, dir)
			end
		end
	 
	end
	
	-- check if table is empty, then we allow going back.
	-- avoids ghost getting stuck on corners of the map.
	if #possible == 0 then add(possible, back) end
	
	-- return the table to the caller
	return possible
end

-- calculates and returns best available direction to move, considering target.
function best_move(entity)
	local smallest_dist = 32767 -- a big impossible value
	local chosen = nil

	-- loops through all available directions
	for dir in all(entity.available) do
		-- get our future position
		local nx = (entity.x+4) + dir[1]*8
		local ny = (entity.y+4) + dir[2]*8
		-- get the distance we will be from the target
		local d = dist({x=nx, y=ny}, entity.target)
		-- if we found a better option, we chose that direction.
		if d < smallest_dist then
			chosen = dir
			smallest_dist = d -- update smallest_dist for next check
		end
	end
	
	-- return chosen direction (that will get us to closer to target)
	return chosen
end

-- calculates distance between two coordinates
function dist(p1, p2)
	local dx = p1.x - p2.x
	local dy = p1.y - p2.y
	return sqrt(dx*dx + dy*dy)
end



-- update ghost target --
--[[each ghost has its own unique "personality" and strategie,
    expressed through this target calculation.]]
function update_target(ghost)
	-- declare target positions
	local tx, ty
	
	-- binky goes direcly towards pacman
	if ghost.name == "blinky" then
		tx = pac.x+4
		ty = pac.y+4
	
	-- pinky goes to where he thinks pacman will be after 4 moves
	elseif ghost.name == "pinky" then
	 	tx = pac.x+4 + (pac.dx*8) * 4
		ty = pac.y+4 + (pac.dy*8) * 4

	-- clyde goes directly towards pacman,
	-- but gets scared and scatters when he gets too close
	elseif ghost.name == "clyde" then
	 	tx = pac.x+4
		ty = pac.y+4
		if dist(ghost,pac) < 32 then
			tx=ghost.scatter.x
			ty=ghost.scatter.y
		end
	-- pinky goes to where he thinks pacman will be after 2 moves
	elseif ghost.name == "inky" then
		tx = pac.x+4 + (pac.dx*8) * 2
		ty = pac.y+4 + (pac.dy*8) * 2	
	end
	
	-- update the target
	ghost.target = {x=tx, y=ty}
end

--drawing ghosts (and their debug graphics)
function draw_ghost(ghost)

	-- ghost sprite
	if ghost.state == states.eaten then
		palt(2, true) -- change base to ghost color
		spr(ghost.sp,ghost.x,ghost.y)
		palt() -- reset pallete
	else
		pal(2, ghost.c) -- change base to ghost color
		spr(ghost.sp,ghost.x,ghost.y)
		pal() -- reset pallete
	end
	
	-- debug
	-- show all availavle directions
	for dir in all(ghost.available) do
		pset(ghost.x + 4 + dir[1] * 8, ghost.y + 4 + dir[2] * 8, 8)
	end
	-- show current best direction
	pset(ghost.x+4+ghost.best[1]*8, ghost.y+4+ghost.best[2]*8,7)
	-- show active target position
	circfill(ghost.target.x, ghost.target.y, 1, ghost.c)
end