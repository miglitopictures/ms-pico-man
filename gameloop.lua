lvl = 1
points = 0
hp = 3
gm = {
	intro = 0,
	playing = 1,
	over = 2,
}
gamestate = gm.playing
dots_left = 86

max_speed = 2

debug_mode = false

function reload_map()
	-- for a 128x128-tile map that can use all 256 sprite tiles
	reload(0x2000, 0x2000, 0x2000)
	-- https://pico-8.fandom.com/wiki/Reload
end

function _init()
	mode_counter = 0
	mode_phase = 1
	mode_time = cfg_lookup(cfgs.mode_time, lvl)
	-- reload map data
	-- reload_map()
	-- init entities
	init_pacman(7*8,14*8)
	init_ghost(ghosts[1],8*8,6*8)
	init_ghost(ghosts[2],8*8,8*8)
	init_ghost(ghosts[3],7*8,8*8)
	init_ghost(ghosts[4],8*8,8*8)
end
death_anim = 7
function _update()
	-- update entities
	if btnp(❎) then
		debug_mode = not debug_mode
	end
	if gamestate == gm.playing then
		
		if not pac.isdead then

			-- global state counter (mode_counter)
			if mode_phase <= 7 then
				if mode_counter/30 <= mode_time[mode_phase] then
					mode_counter += 1
				else
					mode_counter = 0
					mode_phase += 1
					global_state = (global_state==states.chase) and states.scatter or states.chase
				end
			end
			
			-- scared timer
			if allscared then
				if scared_timer <= 0 then
					allscared = false
					pac.spd = cfg_lookup(cfgs.p, lvl).spd
					for g in all(ghosts) do
						g.isscared = false
						if not g.iseaten then g.spd = cfg_lookup(cfgs.g, lvl).spd end
					end
				else
					scared_timer -= 1
				end
			end

			update_pacman()
			animate_pacman()

			for g in all(ghosts) do
				update_ghost(g)
				animate_ghost(g)
			end

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
	color(7)
	print("\^o0ffpoints: " ..points, 2, 2) 
	print("\^o0ffdotsleft: " ..dots_left) 
	print("\^o0ffhp: " ..hp) 
	if debug_mode then
		if global_state == states.chase then
			print("\^o0ffchase :" ..flr(mode_counter/30))
		else
			print("\^o0ffscatter :" ..flr(mode_counter/30))
		end
		if allscared then print("\^o0ffallscared: ") end
	end
end