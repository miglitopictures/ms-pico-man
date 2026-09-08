points = 0
hp = 3
gm = {
	intro = 0,
	readying = 1,	        -- ready? 
	playing = 2, 	    -- in play
	won = 3, -- between levels
	over = 4, 		    -- if lost (save score)
}
gamestate = gm.playing
dots_left = 84

max_speed = 1

debug_mode = false

mode_phase = 1
mode_counter = 0

function reload_map()
	-- for a 128x128-tile map that can use all 256 sprite tiles
	reload(0x2000, 0x2000, 0x2000)
	-- https://pico-8.fandom.com/wiki/Reload
end

function _init()
	-- mode_phase = 1
	mode_time = cfg_lookup(cfgs.mode_time, lvl)
	-- reload map data
	-- init entities
	init_pacman(7*8,14*8)
	init_ghost(ghosts[1],8*8,6*8)
	init_ghost(ghosts[2],8*8,8*8)
	init_ghost(ghosts[3],7*8,8*8)
	init_ghost(ghosts[4],8*8,8*8)
	-- sfx(4)
end
death_anim = 7
win_timer = 30
function _update()
	-- update entities
	if btnp(❎) then
		debug_mode = not debug_mode
	end
	
	-- check dots left
	
	if gamestate == gm.won then
		if win_timer == 0 then
			win_timer = 30
			gamestate = gm.playing
			reload_map()
			mode_phase = 1
			mode_counter = 0
			_init()
		else 
			win_timer -= 1
		end
	elseif gamestate == gm.playing then
		
		if dots_left == 0 then
			gamestate = gm.won
			dots_left = 84
			hp = 3
			lvl += 1
		end

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
				hp -= 1
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
	if gamestate == gm.won then
		print("lvl:" ..lvl, 30,30)
	elseif gamestate == gm.playing then
	
		map() -- draw map
		
		-- draw entities
		draw_ghost(ghosts[1])
		draw_ghost(ghosts[2])
		draw_ghost(ghosts[3])
		draw_ghost(ghosts[4])
		draw_pacman()

		-- draw ui
		for i = 0, hp - 1, 1 do
			spr(2, (128 - 8), (128 - 8) - (9 * i))
		end
	
	elseif gamestate == gm.over then
		print("gameover :(", 30,30)
		print("lvl:" ..lvl)
	end
	-- draw points
	color(7)
	print("\^o0ffpoints: " ..points, 2, 2) 
 		if debug_mode then
		if global_state == states.chase then
			print("\^o0ffchase :" ..flr(mode_counter/30))
		else
			print("\^o0ffscatter :" ..flr(mode_counter/30))
		end
		if allscared then print("\^o0ffallscared: ") end
	end
end


function wrap_around(pos)
	pos.x = pos.x % (128 - 16)
	pos.y = pos.y % 128
end