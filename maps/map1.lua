	local tileString = [[
################################
####                          ##
####                          ##
####     ########             ##
####     ########             ##
####     ########             ##
####     ########             ##
######                        ##
######                        ##
######                        ##
######                        ##
######                        ##
######                        ##
######                        ##
########                      ##
########                      ##
################################
]]

	local quadInfo = {
	  { '#',  6 * 16, 1 * 16 }, -- 1 = blue box 
	  { ' ', 10 * 16, 15 * 16 } -- 2 = black box
	}

	NewMap(16, 16, '/images/sheet.png',quadInfo,tileString)
