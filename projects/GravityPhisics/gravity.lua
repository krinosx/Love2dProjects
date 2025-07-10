local Gravity = {
    G = 6.674
}

Gravity.localInfluence = function (self, x, y, x1, y1, mass)
    -- General formula of gravity
    --  F = G * (m1 * m2) / d²,
    -- on our case we will consider m2 as a point without mass

    local distance = self.distance(x,y,x1,y1);
    local Force = self.G * mass / (distance^2)

   local angle = math.atan2(y-y1, x-x1)

  
    return Force, angle
end

Gravity.distance = function(x, y, x1, y1) 
    return math.sqrt( (x - x1)^2 + (y - y1)^2 )
end

---
--- Draw a grid, cetered on the given body, with the gravitational influence on each cell
---@param gridW number #width of the grid in 'cells'
---@param gridH number #heigh of the grid in cells
---@param cellSize number #size, in pixels, of a cesll. Cells are square.
---@param body Body # the celestial body with mass and position information
---
Gravity.drawFieldGrid = function (gridW, gridH, cellSize, body)
    
  local bodyX, bodyY = body:getPosition()

  local gridPxWidth = gridW * cellSize
  local gridPxHeight = gridH * cellSize

  local gridStartPx_X = bodyX - (gridPxWidth/2)
  local gridStartPx_Y = bodyY - (gridPxHeight/2)

    -- print("BodyX,BodyY" .. bodyX .. "," .. bodyY)
    -- print("gridPxWidth,gridPxHeight" .. gridPxWidth .. "," .. gridPxHeight)
    -- print("gridStartPx_X,gridStartPx_Y" .. gridStartPx_X .. "," .. gridStartPx_Y)   


  for i = 0,gridW, 1 do
    for j=0, gridH, 1 do
       local loc_x, loc_y = gridStartPx_X + cellSize * i, gridStartPx_Y + cellSize * j
      -- love.graphics.rectangle("line",loc_x,loc_y, cellSize, cellSize)


      local force, angle =  Gravity:localInfluence(loc_x, loc_y, bodyX, bodyY, 1000)

       love.graphics.push()
       love.graphics.translate(loc_x, loc_y);
       love.graphics.rotate(angle)
       love.graphics.line(0,0,30,0)
       love.graphics.pop()
       


      love.graphics.print(string.format("%.3f",force), loc_x, loc_y )

      love.graphics.print(string.format("%.3f",angle), loc_x, loc_y +20 )
    end
  end

end




return Gravity