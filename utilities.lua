-- Collision detection function.
-- Returns true if two boxes overlap, false if they don't
-- x1,y1 are the left-top coords of the first box, while w1,h1 are its width and height
-- x2,y2,w2 & h2 are the same, but for the second box
function CheckCollisionXYWH(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end

--This is exactly like the collision detection function above, except we pass in two
--bounding boxes rather than indiviual points
function CheckCollisionBoundingBox(BoundingBox1, BoundingBox2)
  return BoundingBox1.x < BoundingBox2.x + BoundingBox2.w and
         BoundingBox2.x < BoundingBox1.x + BoundingBox1.w and
         BoundingBox1.y < BoundingBox2.y +BoundingBox2.h and
         BoundingBox2.y < BoundingBox1.y + BoundingBox1.h
end

function GetTileXYFromXY(x, y)
	local tileX = math.floor(x / 16) +1
	local tileY = math.floor(y / 16) +1
	
	return tileX, tileY
end

function GetTileXYFromXY2(x, y)
	local tileX = math.floor(x / 16)
	local tileY = math.floor(y / 16)
	
	return tileX, tileY
end

function Darken()
	--love.graphics.setBlendMode("alpha")
	--love.graphics.setColor(50,50,50)
end

function Lighten()
	--love.graphics.setBlendMode("alpha")
	--love.graphics.setColor(190,190,190)
end