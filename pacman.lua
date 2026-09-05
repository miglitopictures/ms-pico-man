-- pacman --

-- creates the pacman table
function init_pacman(x,y)
	pac = {
		x=x,
		y=y,
		dx=1,
		dy=0,
		sp=2,
		wantedmove={1,0},
		lastmove={1,0}
	}
end

-- updates pacman position
function update_pacman()

	local canmove = (pac.x + pac.y) % 8 == 0

	if canmove then
		if btn(⬅️) then
			if not is_solid_coord(pac.x-1, pac.y) then
				pac.dx = -1
				pac.dy = 0
				pac.lastmove={-1,0}
			end
		end
		if btn(⬆️) then
			if not is_solid_coord(pac.x, pac.y-1) then
				pac.dx = 0
				pac.dy = -1
				pac.lastmove={0,-1}
			end
		end
		if btn(➡️) then
			if not is_solid_coord(pac.x+8, pac.y) then
				pac.dx = 1
				pac.dy = 0
				pac.lastmove={1,0}
			end 
		end
		if btn(⬇️) then
			if not is_solid_coord(pac.x, pac.y+8) then
				pac.dx = 0
				pac.dy = 1
				pac.lastmove={0,1}
			end
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