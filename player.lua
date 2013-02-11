player = {

	gx = 7 ;
	gy = 4 ;
	gz = 4 ;
}

-- check if the player is somewhere
function player:check(gx, gy, gz)

	return
	
	gx == self.gx and
	gy == self.gy and
	gz == self.gz
end

function player:move(mx, my, mz)

	local dx, dy, dz =
	self.gx + mx,
	self.gy + my,
	self.gz + mz

	local dv = block_getValue(dx, dy, dz)

	if dv == "empty" or dv == "water" then
	
		self.gx = dx
		self.gy = dy
		self.gz = dz
	end
end
