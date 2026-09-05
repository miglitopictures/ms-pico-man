-- pacman --


-- creates the pacman table
function init_pacman(x,y)
	pac = {
		x=x,
		y=y,
		sp=2,
		lastmove={1,0}
	}
end

function update_pacman()

	if btnp(⬅️) then
		pac.x-=8 
	 pac.lastmove={-1,0}
	end
	if btnp(⬆️) then
		pac.y-=8
		pac.lastmove={0,-1}
	end
	if btnp(➡️) then
		pac.x+=8
		pac.lastmove={1,0}
	end
	if btnp(⬇️) then
		
		pac.y+=8
		pac.lastmove={0,1}
	
	end

end


function draw_pacman()

	spr(pac.sp,pac.x,pac.y)

end