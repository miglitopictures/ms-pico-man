points = 0

function _init()
	-- init entities
	init_pacman(7*8,14*8)
	init_ghost(ghosts[1],7*8,7*8)
	init_ghost(ghosts[2],8*8,7*8)
	init_ghost(ghosts[3],7*8,7*8)
	init_ghost(ghosts[4],8*8,7*8)
end

function _update()
	-- update entities
	update_pacman()
	update_ghost(ghosts[1])
	update_ghost(ghosts[2])
	update_ghost(ghosts[3])
	update_ghost(ghosts[4])
end

function _draw()
	cls() -- clear the screen
	map() -- draw map
	
	-- draw entities
	draw_pacman()
	draw_ghost(ghosts[1])
	draw_ghost(ghosts[2])
	draw_ghost(ghosts[3])
	draw_ghost(ghosts[4])

	-- draw points
	print("\^o0ffpoints: " ..points, 0, 0, 7) 
end