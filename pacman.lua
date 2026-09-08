-- pacman --

-- creates the pacman table
function init_pacman(x,y)
	pac = {
		x = x,
		y = y,
		isdead = false,
		anim_timer = 0,
		base_frame = 0,
		fliph = false,
		flipv = false,
		sp = 2,
		dx = 1,
		dy = 0,
		desired = {1,0},
		spd = cfg_lookup(cfgs.p, lvl).spd,
		accm = 0,
		move_counter = 8
	}
end
-- updates pacman position
function update_pacman()
	-- check collision
	pcellx = flr((pac.x+4)/8)
	pcelly = flr((pac.y+4)/8)
	if is(pcellx, pcelly, dot) then
		dots_left -= 1
		points += 10
		mset(pcellx, pcelly, 0)
		sfx(0) -- needs sound design
	elseif is(pcellx, pcelly, bigdot) then
		dots_left -= 1
		pac.spd = cfg_lookup(cfgs.p, lvl).fspd
		points += 50
		for g in all(ghosts) do
			if not g.iseaten then 
				allscared = true
				g.isscared = true
				g.spd = cfg_lookup(cfgs.g, lvl).fspd
				scared_timer = cfg_lookup(cfgs.fright, lvl) * 30;
			end
		end
		mset(pcellx, pcelly, 0)
		sfx(1) -- needs sound design
	end


	-- get user input for desired direction
	if btn(⬅️) then pac.desired = {-1,0} end
	if btn(⬆️) then pac.desired = {0,-1} end
	if btn(➡️) then pac.desired = {1, 0} end
	if btn(⬇️) then pac.desired = {0, 1} end

	
	
	while pac.accm >= 100/max_speed do
		pac.accm -= 100/max_speed

		if pac.move_counter <= 0 then
		-- if wanted is ok
			if not is_solid(flr(pac.x / 8) + pac.desired[1], flr(pac.y / 8) + pac.desired[2]) then
				-- lets go there!
				pac.dx = pac.desired[1]
				pac.dy = pac.desired[2]
				-- else if cannot continue
			elseif is_solid(flr(pac.x / 8) + pac.dx, flr(pac.y / 8) + pac.dy) then
				-- we stop!
				pac.dx = 0
				pac.dy = 0
			end	
			pac.move_counter = 8
		end
		
		-- move pacman
		pac.x += pac.dx
		pac.y += pac.dy
		pac.move_counter -= 1
	end

	pac.accm += pac.spd

	-- wrap around
	wrap_around(pac)
	-- pac.x = pac.x % 128
	-- pac.y = pac.y % 128

end

function animate_pacman()
	if pac.dx == 1 then -- right
		pac.base_frame = 1
		pac.fliph = false
		pac.flipv = false
		pac.anim_timer += 0.4
	elseif pac.dx == -1 then -- left
		pac.base_frame = 1
		pac.fliph = true
		pac.flipv = false
		pac.anim_timer += 0.4
	elseif pac.dy == 1 then -- down
		pac.base_frame = 4
		pac.fliph = false
		pac.flipv = true
		pac.anim_timer += 0.4
	elseif pac.dy == -1 then -- up
		pac.base_frame = 4
		pac.fliph = false
		pac.flipv = false
		pac.anim_timer += 0.4
	else 
		pac.anim_timer = 1
	end
	pac.sp = pac.base_frame + (pac.anim_timer % 3)
end

function draw_pacman()
	spr(pac.sp,pac.x,pac.y,1,1,pac.fliph, pac.flipv)
	if debug_mode then
		print(pac.spd, pac.x, pac.y - 4, 7)
	end
end