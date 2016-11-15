require 'mapping'
require 'player'
require 'lightSource'
--require 'utilities'

function love.load()
	LoadMap('/maps/map1.lua')
	LoadPlayer()
	LightLoad()	
end

function love.update(dt)
	
	MapUpdate(dt)
	PlayerUpdate(dt)
	LightUpdate()
end

function love.draw()	
	--love.graphics.setBlendMode("multiply")

	DrawMap()
	DrawPlayer()
	LightSourceDraw()
	--LightSourceDraw()

	
	--love.window.showMessageBox('Light Sources', #LightSources, "error")
end
