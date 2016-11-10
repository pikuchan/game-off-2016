require 'mapping'
require 'player'


function love.load()
	LoadMap('/maps/map1.lua')
	LoadPlayer()
end

function love.update(dt)
	PlayerUpdate(dt)
end

function love.draw()
	DrawMap()

	DrawPlayer()
end
