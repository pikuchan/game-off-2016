LightSources = {}

function LightLoad()
	mask = love.graphics.newCanvas()
	love.graphics.setCanvas(mask)
	love.graphics.clear(0,0,0)
	love.graphics.setCanvas()

	hole = love.graphics.newImage('images/Hole.png')
	
	SetUpLighting()
end


function LightUpdate()
	love.graphics.setCanvas(mask)
    love.graphics.clear(0, 0, 0, 255)
    love.graphics.setBlendMode("multiply")
	
	for i,v in ipairs(LightSources) do
		love.graphics.draw(hole, v.x, v.y, 0, .75, .75, hole:getWidth()/v.divisor, hole:getHeight()/v.divisor )
	end
	
    love.graphics.setBlendMode("alpha")
    love.graphics.setCanvas()
end

function AddnewLight(x, y, divisor)
	table.insert(LightSources, {x = x, y = y, divisor = divisor})
end

function SetUpLighting()
	AddnewLight(472, 32, 3)
	AddnewLight(100, 200, 5)
	AddnewLight(375, 200, 3)
	AddnewLight(25, 25, 25)
end

function LightSourceDraw()
  	love.graphics.setColor(255, 255, 255, 200)
    love.graphics.draw(mask)
    love.graphics.setColor(255, 255, 255)
end