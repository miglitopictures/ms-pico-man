-- pacman --

-- creates the pacman table
function init_pacman(x,y)
	pac = {
		x = x,
		y = y,
		sp = 2,
		dx = 1,
		dy = 0,
		desired = {0,-1},
	}
end

-- updates pacman position
function update_pacman()

	-- can move if is on the grid
	local canmove = (pac.x + pac.y) % 8 == 0

	-- get user input for desired direction
	if btn(⬅️) then pac.desired = {-1,0} end
	if btn(⬆️) then pac.desired = {0,-1} end
	if btn(➡️) then pac.desired = {1, 0} end
	if btn(⬇️) then pac.desired = {0, 1} end

	if canmove then
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
	end

	pac.x += pac.dx
	pac.y += pac.dy
	
	-- wrap around
	pac.x = pac.x % 128
	pac.y = pac.y % 128

end


function draw_pacman()
	spr(pac.sp,pac.x,pac.y)
end