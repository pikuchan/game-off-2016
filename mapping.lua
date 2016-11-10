local TileWidth, TileHeight
MapWidth = 0
MapHeight = 0
MapWidthPixels = 0
MapHeightPixels = 0

TileTable = {}

function LoadMap(path)
	love.filesystem.load(path)()
end

function GetTileBoundingBox(TileColumn, TileRow)
	local x, y = 0, 0
	
	bbY = (TileRow) * TileHeight
    bbX = (TileColumn) * TileWidth
	
	local TileBoundingBox = { x = bbX, y = bbY, w = TileWidth, h = TileHeight }
	return TileBoundingBox
end

function NewMap(tileWidth, tileHeight, tileSetPath, quadInfo, tileString)
	Tileset = love.graphics.newImage(tileSetPath)
	
	TileHeight = tileHeight
	TileWidth = tileWidth
	
	local tilesetW, tilesetH = Tileset:getWidth(), Tileset:getHeight()
	
	Quads = {}
	for _,info in ipairs(quadInfo) do
	  -- info[1] = x, info[2] = y
	  Quads[info[1]] = love.graphics.newQuad(info[2], info[3], TileWidth, TileHeight, tilesetW, tilesetH)
	end

	local width = #(tileString:match("[^\n]+"))
	MapWidth = width
	MapWidthPixels = width * TileWidth

	for x = 1,width,1 do TileTable[x] = {} end  

	local rowIndex,columnIndex = 1,1
	for row in tileString:gmatch("[^\n]+") do
	  assert(#row == width, 'Map is not aligned: width of row ' .. tostring(rowIndex) .. ' should be ' .. tostring(width) .. ', but it is ' .. tostring(#row))
	  columnIndex = 1
	  
	  for character in row:gmatch(".") do
		if character == ' ' then
			TileTable[columnIndex][rowIndex] = { TableCharacter = character, walkable = true }
		else 
			TileTable[columnIndex][rowIndex] = { TableCharacter = character, walkable = false }
		end
		--TileTable[columnIndex][rowIndex] = character
		columnIndex = columnIndex + 1
	  end
	  
	  MapHeight = rowIndex
	  MapHeightPixels = MapHeight * tileHeight
	  
	  rowIndex=rowIndex+1
	end
end

function DrawMap()
	for columnIndex,column in ipairs(TileTable) do
		for rowIndex,row in ipairs(column) do
		  local x,y = (columnIndex-1)*TileWidth, (rowIndex-1)*TileHeight
		  local character = TileTable[columnIndex][rowIndex].TableCharacter
		  love.graphics.draw(Tileset, Quads[character], x, y)
		end
	end
end