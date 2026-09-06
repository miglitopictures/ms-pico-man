points = 0
hp = 3
gm = {
	intro = 0,
	playing = 1,
	over = 2,
}
gamestate = gm.playing

function reload_map()
	-- for a 128x128-tile map that can use all 256 sprite tiles
	reload(0x2000, 0x2000, 0x2000)
	-- https://pico-8.fandom.com/wiki/Reload
end
function _init()
	-- reload map data
	reload_map()
	-- init entities
	init_pacman(7*8,14*8)
	init_ghost(ghosts[1],7*8,7*8)
	init_ghost(ghosts[2],8*8,7*8)
	init_ghost(ghosts[3],7*8,7*8)
	init_ghost(ghosts[4],8*8,7*8)
end
death_anim = 7
function _update()
	-- update entities
	if gamestate == gm.playing then
		
		if not pac.isdead then
			update_pacman()
			update_ghost(ghosts[1])
			update_ghost(ghosts[2])
			update_ghost(ghosts[3])
			update_ghost(ghosts[4])
		else 
			-- play death animation
			if death_anim < 13.9 then
				death_anim = death_anim + 0.1
			else 
				if hp == 0 then
					-- game over
					gamestate = gm.over
				else
					-- reset at start
					death_anim = 7
					pac.sp = 2
					pac.isdead = false
					_init()
				end
			end
			pac.sp = death_anim;
		end

	end
end

function _draw()
	cls() -- clear the screen
	if gamestate == gm.playing then
	
		map() -- draw map
		
		-- draw entities
		draw_ghost(ghosts[1])
		draw_ghost(ghosts[2])
		draw_ghost(ghosts[3])
		draw_ghost(ghosts[4])
		draw_pacman()
	
	else 
		print("gameover :(", 30,30)
	end
	-- draw points
	print("\^o0ffpoints: " ..points) 
	print("\^o0ffhp: " ..hp) 
end