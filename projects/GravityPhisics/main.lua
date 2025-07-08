if os.getenv("LOCAL_LUA_DEBUGGER_VSCODE") == "1" then
    require("lldebugger").start()
  end

local world = love.physics.newWorld(0,0)

local gravity = require("gravity")

local printPhysics = false

-- Central gravity point
local sun = {    
}

local planet_1 = {    
}


local theta = 0


  
function love.load()
      -- Initialize game

      sun = {
            x = love.graphics.getWidth() / 2,
            y = love.graphics.getHeight() / 2,
            texture = love.graphics.newImage("Assets/Planets/Suns/Red/Sun_Red_01_256x256.png"),
      }
      sun.w, sun.h = sun.texture:getDimensions()
      sun.body = love.physics.newBody(world,sun.x,sun.y,"dynamic")
      sun.shape = love.physics.newCircleShape(sun.x, sun.y, sun.w / 2)
      sun.fixture = love.physics.newFixture(sun.body, sun.shape)

   
      planet_1 = {
            x = 200,
            y = 200,
            texture = love.graphics.newImage("Assets/Planets/Solid/Ocean/Ocean_01-128x128.png"),
      }
      planet_1.w, planet_1.h = planet_1.texture:getDimensions()
      planet_1.body = love.physics.newBody(world,planet_1.x,planet_1.y,"dynamic")
      planet_1.shape = love.physics.newCircleShape(planet_1.x, planet_1.y, planet_1.w / 2)
      planet_1.fixture = love.physics.newFixture(planet_1.body, planet_1.shape)



end



---
--- Get the x, y coordinates for a body orbiting the center_x, center_y coordinates given a angle 
--- theta at a distance of major_axis and minor_axis. When axis are the same, its a circular orbit.
--- When they are not the same you get an Elipse orbiting pattern.
---
---
---@param center_x number # The x position in local coordinates.
---@param center_y number # The y position in local coordinates.
---@param theta number # The angle for the calculated points
---@param major_axis number # The bigger axis of an elipse - it must be bigger than minor_axis. 
---@param minor_axis number # The smaller axis of am elipse - it must be smaller than major_axis.
---@return number x # The x position for the theta angle provided.
---@return number y # The y position for the theta angle provided.
function GetElipticalOrbitCoordinate(center_x, center_y, theta, major_axis, minor_axis)
      -- calculate the elipse intersecting coordinates 
      -- a = major axis, big radius
      -- b = minor axis, minor radius
      local a = major_axis
      local b = minor_axis
      local x, y = center_x, center_y

      -- Parametric equation for elipse
      -- x = h + a * cos(t), 
      -- y = k + b * sin(t)
      local X = x + a * math.cos(theta)
      local Y = y + b * math.sin(theta)

      return X, Y
end

  
function love.update(dt)
      -- Update physics simulation
      world:update(dt)

      -- Set positions back to the texture
      sun.x, sun.y = sun.body:getPosition()

      
      theta = theta + ( math.pi/ 8 * dt )
      local  p1_x, p1_y = GetElipticalOrbitCoordinate(sun.x, sun.y, theta, 500, 400)

      planet_1.body:setPosition(p1_x, p1_y)
      planet_1.x = p1_x
      planet_1.y = p1_y
   

end

Body = {
    x = 500,
    y = 500,
    mass = 1000,
    getPosition = function (self)
        return self.x, self.y
    end,

}
  
function love.draw()
      -- Draw game
      
      if printPhysics then
            --Draw physics
            local sun_body_x, sun_body_y = sun.body:getPosition()
            local sun_body_radius = sun.shape:getRadius()
            love.graphics.circle("line", sun_body_x, sun_body_y, sun_body_radius);     

            --Draw physics
            local p1_body_x, p1_body_y = sun.body:getPosition()
            local p1_body_radius = sun.shape:getRadius()
            love.graphics.circle("line", p1_body_x, p1_body_y, p1_body_radius);     


      else
            love.graphics.draw(sun.texture, sun.x - sun.w /2, sun.y - sun.h/2)
            love.graphics.draw(planet_1.texture, planet_1.x - planet_1.w /2, planet_1.y - planet_1.h/2)
      end
      
      
      gravity.drawFieldGrid(10, 10, 50, Body)


end


function love.keypressed(key, scancode, isrepeat)
      if key == "escape" then
            love.event.quit()
      end
      if key == "escape" then
            love.event.quit()
      end
      if key == "f1" then
            printPhysics = not printPhysics
      end
            
      
      
end