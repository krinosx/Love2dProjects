local Gravity = {
  G = 6.674
}

CelestialBody = require("CelestialBody")


Gravity.localInfluence = function(self, x, y, x1, y1, mass)
  -- General formula of gravity
  --  F = G * (m1 * m2) / d²,
  -- on our case we will consider m2 as a point without mass

  local distVec = self.distanceVector(x,y,x1,y1)

  local distance = self.distance(x, y, x1, y1);
  local Force = self.G * mass / (distance ^ 2)



  local ForceX = 0
  if distVec.x > 0 then
   ForceX = self.G * mass / (distVec.x^2)
  end

  local ForceY = 0
  if distVec.y > 0 then
    ForceY = self.G * mass / (distVec.y^2)
  end

  local angle = math.atan2(y1 - y, x1 - x)


  return {Force=Force, angle=angle, ForceX=ForceX, ForceY=ForceY, distVec=distVec}
end

Gravity.distance = function(x, y, x1, y1)
  return math.sqrt((x - x1) ^ 2 + (y - y1) ^ 2)
end


Gravity.distanceVector = function(x, y, x1, y1)
  return { x=math.abs(x-x1), y=math.abs(y-y1) }
end

---
--- Draw a grid, cetered on the given body, with the gravitational influence on each cell
---@param gridW number #width of the grid in 'cells'
---@param gridH number #heigh of the grid in cells
---@param cellSize number #size, in pixels, of a cesll. Cells are square.
---@param body CelestialBody # the celestial body with mass and position information
---
Gravity.drawFieldGrid = function(gridW, gridH, cellSize, body, body2)
  local bodyX, bodyY = body:getPosition()
  local body2x, body2Y = body2:getPosition()

  local gridPxWidth = gridW * cellSize
  local gridPxHeight = gridH * cellSize

  local gridStartPx_X = bodyX - (gridPxWidth / 2)
  local gridStartPx_Y = bodyY - (gridPxHeight / 2)

  -- print("BodyX,BodyY" .. bodyX .. "," .. bodyY)
  -- print("gridPxWidth,gridPxHeight" .. gridPxWidth .. "," .. gridPxHeight)
  -- print("gridStartPx_X,gridStartPx_Y" .. gridStartPx_X .. "," .. gridStartPx_Y)


  for i = 0, gridW, 1 do
    for j = 0, gridH, 1 do
      local loc_x, loc_y = gridStartPx_X + cellSize * i, gridStartPx_Y + cellSize * j
      -- love.graphics.rectangle("line",loc_x,loc_y, cellSize, cellSize)


      --local force, angle = Gravity:localInfluence(loc_x, loc_y, bodyX, bodyY, 1000)
      --local force1, angle1 = Gravity:localInfluence(loc_x, loc_y, body2x, body2Y, 500)

      local influence = Gravity:localInfluence(loc_x, loc_y, bodyX, bodyY, 1000)
      local influence_p1 = Gravity:localInfluence(loc_x, loc_y, body2x, body2Y, 300)

      local force = influence.Force
      local angle = influence.angle

      local force_p1 = influence_p1.Force
      local angle_p1 = influence_p1.angle


      force = force - force_p1
      --angle = angle - angle1

      local force_x = influence.ForceX - influence_p1.ForceX
      local force_y = influence.ForceY - influence_p1.ForceY


      local r,g,b,a = love.graphics.getColor()

      

      if math.abs(force) < 0.01 then
        love.graphics.setColor(0,1,0,1)
      else
        if force < 0 then
          love.graphics.setColor(0,0.5,0.5,1)
        end
        if force > 0.01 then
          love.graphics.setColor(0.5,0,0.5,1)
        end
      
      end
      

      -- love.graphics.push()
      -- love.graphics.translate(loc_x, loc_y);
      -- love.graphics.rotate(angle)
      -- love.graphics.line(0, 0, 30, 0)
      -- love.graphics.circle("fill", 0, 0, 4);
      -- love.graphics.pop()

      love.graphics.print(string.format("x:%.3f\ny:%.3f", force_x, force_y), loc_x, loc_y)
      --love.graphics.print(string.format("(%d,%d)", loc_x, loc_y), loc_x, loc_y)
      --love.graphics.print(string.format("%.3f", force), loc_x, loc_y)
      --love.graphics.print(string.format("%.3f", angle), loc_x, loc_y + 15)
      --love.graphics.print(string.format("%.3f", angle1), loc_x, loc_y + 25)
      love.graphics.setColor(r,g,b,a)
    end
  end
end




return Gravity
