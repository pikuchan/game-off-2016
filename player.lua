require 'mapping'
require 'utilities'

local player = {x = 0, y = 0, width = 0, height = 0, playerBoundingBox = { x =0, y =0, w =0, h =0}}
local speedModifier = 65

function LoadPlayer()
	playerImage = love.graphics.newImage('images/player8x8.png')
	player.width = playerImage:getWidth()
	player.height = playerImage:getHeight()
	
	DeterminePlayerStartingPosition()
  
	player.playerBoundingBox.w = player.width
	player.playerBoundingBox.h = player.height 
end

function DeterminePlayerStartingPosition()
	local goodStartingSpot = false
	
	repeat
		local randX = love.math.random(1, MapWidthPixels - (player.width /2))
		local randY = love.math.random(1, MapHeightPixels - (player.width /2))
		randX = randX
		randY = randY
		
		local tileX, tileY = GetTileXYFromXY(randX, randY)
		--local tileX = math.floor(randX / 16) +1
		--local tileY = math.floor(randY / 16) +1

		--if TileTable[tileX][tileY].TableCharacter ~= '#' then
		if CanPlayerMoveThere(randX, randY, tileX, tileY) == true then
		  player.x = randX
		  player.y = randY

		  goodStartingSpot = true
		end
	until goodStartingSpot == true
end

function PlayerUpdate(dt)
  local startingX = player.x
  local startingY = player.y
  local newX = player.x
  local newY = player.y
  local movementDirection
  
  if love.keyboard.isDown('s') then
    newY = player.y + dt * speedModifier
	movementDirection = 'down'
  elseif love.keyboard.isDown('w') then
    newY = player.y - dt * speedModifier
	movementDirection = 'up'
  elseif love.keyboard.isDown('a') then
    newX = player.x - dt * speedModifier
	movementDirection = 'left'
  elseif love.keyboard.isDown('d') then
    newX = player.x + dt * speedModifier
	movementDirection = 'right'
  end

  local tileX, tileY = GetTileXYFromXY(newX, newY)
  
  if CanPlayerMoveThere(newX, newY, tileX, tileY, movementDirection) == false then
    newX = startingX - dt
    newY = startingY - dt
  end

  player.x = newX
  player.y = newY  
  UpdatePlayerBoundingBox()
end


function CanPlayerMoveThere(playerX, playerY, TileX, TileY, direction)
	if (playerX > MapWidthPixels) or (playerX < 1) then
		return false
	end

	if (playerY > MapHeightPixels) or (playerY < 1) then
		return false
	end
	
	--instead of checking for collisions with all non-walkable tiles, let's only check the tiles surrounding the player,
	--check to see if they're walkable. If they're not, then check to see if the bounding boxes have a collision. Stop movement if so
	for x= -1, 1, 1 do
		for y= -1, 1, 1 do
			local modTileX = TileX + x
			local modTileY = TileY + y
			
			if TileTable[modTileX][modTileY].walkable == false then
				local tileBB = GetTileBoundingBox(modTileX -1, modTileY -1)
				if CheckCollisionBoundingBox(player.playerBoundingBox, tileBB)  == true then
					--love.window.showMessageBox('Collision Hit', 'Player X ' .. player.playerBoundingBox.x .. 'Player Y ' .. player.playerBoundingBox.y.. 'Player W ' .. player.playerBoundingBox.w.. 'Player H ' .. player.playerBoundingBox.h .. 'Tile X ' .. tileBB.x .. 'Tile Y ' .. tileBB.y.. 'Tile W ' .. tileBB.w.. 'Tile H ' .. tileBB.h, "error")
					return false
				end
			end
		end
    end
	
	if TileTable[TileX][TileY].walkable == true then
		return true
	end

	return false
  
end

function UpdatePlayerBoundingBox()
	player.playerBoundingBox = { x = player.x, y = player.y, w =player.width, h = player.height}
end

function IsPlayerInTheLight()
	for i,v in ipairs(LightSources) do		
		if(CheckCollisionBoundingBox(player.playerBoundingBox, v.lightBox)) then
			return true
		end
	end
	
	return false
end

function DrawPlayer()
	local tileX, tileY = GetTileXYFromXY(player.x, player.y)
	
	--if IsPlayerInTheLight() == true thens
		--Lighten()
		love.graphics.setColor(255, 255, 255)
		love.graphics.draw(playerImage, player.x, player.y)
	--else
		--Darken()
		--love.graphics.draw(playerImage, player.x, player.y)
	--end
	
	
	
	--Lighten()
	love.graphics.print("X:"..player.x.." Y: "..player.y, 10, 10)
	love.graphics.print("X:"..tileX.." Y: "..tileY, 10, 30)
	--love.graphics.print("In the dark?:"..tileX.." Y: "..tileY, 10, 30)
	--Darken()
	
	love.graphics.rectangle("line", player.playerBoundingBox.x, player.playerBoundingBox.y, player.playerBoundingBox.w, player.playerBoundingBox.h )
end