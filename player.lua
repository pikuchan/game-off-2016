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
		
		local tileX = math.floor(randX / 16) +1
		local tileY = math.floor(randY / 16) +1

		if TileTable[tileX][tileY].TableCharacter ~= '#' then
		--if CanPlayerMoveThere(randX, randY, tileX, tileY) == true then
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
  
  if love.keyboard.isDown('s') then
    newY = player.y + dt * speedModifier
  elseif love.keyboard.isDown('w') then
    newY = player.y - dt * speedModifier
  elseif love.keyboard.isDown('a') then
    newX = player.x - dt * speedModifier
  elseif love.keyboard.isDown('d') then
    newX = player.x + dt * speedModifier
  end

  local tileX = math.floor(newX / 16) +1
  local tileY = math.floor(newY / 16) +1
  
  if CanPlayerMoveThere(newX, newY, tileX, tileY) == false then
    newX = startingX
    newY = startingY
  end

  player.x = newX
  player.y = newY  
  UpdatePlayerBoundingBox()
end


function CanPlayerMoveThere(playerX, playerY, TileX, TileY)

  if (playerX > MapWidthPixels) or (playerX < 1) then
    return false
  end

  if (playerY > MapHeightPixels) or (playerY < 1) then
    return false
  end
  
  if TileTable[TileX][TileY].walkable == true then
      return true
  end

  return false
  
end

function UpdatePlayerBoundingBox()
	player.playerBoundingBox = { x = player.x, y = player.y, w =player.width, h = player.height}
end

function DrawPlayer()

	local tileX = math.floor(player.x / 16) +1
	local tileY = math.floor(player.y / 16) +1
	
	love.graphics.draw(playerImage, player.x, player.y)
	
	love.graphics.print("X:"..player.x.." Y: "..player.y, 10, 10)
	love.graphics.print("X:"..tileX.." Y: "..tileY, 10, 30)
	
end