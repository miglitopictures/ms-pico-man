-- ghosts --

moves = {
    {0 ,-1}, --up
    {-1, 0}, --left
    {0 , 1}, --down
    {1 , 0}  --right
} 

ghosts = {
    {name = "blinky"}, --red
    {name = "pinky"},  --pink
    {name = "inky"},   --blue
    {name = "clyde",   --orange
    scatter = {x=0,y=128}}
}

function init_ghost(ghost, x, y)
	ghost.x = x
	ghost.y = y
	ghost.available={}
	ghost.best={0,0}
	ghost.lastmove={0,0}
	ghost.moving = false
	ghost.dist_2_move=7
	ghost.target={x=rnd(128),y=rnd(128)}
	local name = ghost.name
	local sp = 16
	local c=4
	if name=="blinky" then sp=16 c=8 end
	if name=="pinky" then sp=32 c=14 end
	if name=="inky" then sp=48 c=12 end
	if name=="clyde" then sp=21 c=9 end
	ghost.sp=sp
	ghost.c=c
end

--update ghosts

function update_ghost(ghost)
	
	if not ghost.moving do
		ghost.available = possible_moves(ghost)
		update_target(ghost)
		ghost.best = best_move(ghost)
		ghost.lastmove=ghost.best
		ghost.moving=true
		ghost.dist_2_move=7
		move_ghost(ghost)
	else
		move_ghost(ghost)
	end
end

--drawing ghosts

function draw_ghost(ghost)
	local x = ghost.x
	local y = ghost.y
	
	--rectfill(x,y,x+7,y+7,ghost.c)
	spr(ghost.sp,x,y)

	--drawing ghosts debug

	for dir in all(ghost.available) do
		pset(x+4+dir[1]*8,y+4+dir[2]*8,8)
	end

	pset(x+4+ghost.best[1]*8,y+4+ghost.best[2]*8,7)
	
	circfill(ghost.target.x,ghost.target.y,1,ghost.c)
	
end

--calculating possible moves

function possible_moves(entity)
	local possible = {}
	
	local bx = -entity.lastmove[1]
	local by = -entity.lastmove[2]
	
	for dir in all(moves) do
	   
		local is_back = (dir[1] == bx and dir[2] == by)
		
		--checando porque os fantasmas
		--nao viram de costas
		
		if not is_back then
			local nx = flr((entity.x + 4) / 8) + dir[1]
			local ny = flr((entity.y + 4) / 8) + dir[2]
			if not is_solid(nx, ny) then
				add(possible, dir)
			end
		end
	 
	end
	
	if #possible == 0 then
		add(possible, {bx, by})
	end
	
	return possible
end

--moving ghosts

function move_ghost(ghost)
	if ghost.dist_2_move == 0 then
			ghost.moving=false
	end
	ghost.x+=ghost.best[1]
	ghost.y+=ghost.best[2]
	ghost.dist_2_move -= 1
end

--calculating best move

function best_move(entity)
	local smallest_dist = 32767 -- um valor inicial bem alto
	local chosen = nil

	for dir in all(entity.available) do
		local nx = (entity.x+4) + dir[1]*8
		local ny = (entity.y+4) + dir[2]*8
		local d = dist({x=nx, y=ny}, entity.target)
		if d < smallest_dist then
			smallest_dist = d
			chosen = dir
		end
	end
	
	return chosen
end

function dist(p1, p2)
	local dx = p1.x - p2.x
	local dy = p1.y - p2.y
	return sqrt(dx*dx + dy*dy)
end

--pacman's target for each ghost

function update_target(ghost)
	local tx = 10
	local ty = 10
	
	if ghost.name == "blinky" then
		tx = pac.x+4
		ty = pac.y+4
	elseif ghost.name == "pinky" then
	 	tx = pac.x+4 + (pac.lastmove[1]*8)*4
		ty = pac.y+4 + (pac.lastmove[2]*8)*4
	elseif ghost.name == "clyde" then
	 	tx = pac.x+4
		ty = pac.y+4
		if dist(ghost,pac) < 32 then
			tx=ghost.scatter.x
			ty=ghost.scatter.y
		end
	elseif ghost.name == "inky" then
		tx = pac.x+4 + (pac.lastmove[1]*8)*2
		ty = pac.y+4 + (pac.lastmove[2]*8)*2	
	end
	
	ghost.target = {x=tx, y=ty}
	
end