if os.getenv("LOCAL_LUA_DEBUGGER_VSCODE") == "1" then
      require("lldebugger").start()
end

local world = love.physics.newWorld(0, 0)
local CelBody = require("CelestialBody")
local gravity = require("gravity")

local printPhysics = false

-- SUN Central gravity point
local sun = CelBody:new()
-- Orbiting planet
local planet_1 = CelBody:new()

local theta = 0
Shader = nil

local gravity_shader = [[
      extern vec2 body_pos;
      extern vec2 body2_pos;
      extern vec4 g_color[2]; 

      vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords )
      {

          number distance = sqrt(  pow( abs( ( body_pos[0] - screen_coords[0] ) ) ,2) + pow( abs( ( body_pos[1] - (screen_coords[1]) ) ) , 2 ) );
          number force = 6674 / pow(distance, 2) ;

          number distance2 = sqrt(  pow( abs( ( body2_pos[0] - screen_coords[0] ) ) ,2) + pow( abs( ( body2_pos[1] - (screen_coords[1]) ) ) , 2 ) );
          number force2 = 6674 / pow(distance2, 2);
 
          force = force - force2;

      // local Force = self.G * mass / (distance ^ 2)

            vec4 texturecolor = Texel(texture, texture_coords);
            if(force > 0.008) {
                  return texturecolor * g_color[0] * 1.5;
            }
            if(force < -0.04 ) {
                  return texturecolor * g_color[1] * 1.5;
            }
            return texturecolor * color;
      }
]]



function love.load()
      -- Initialize game

      Shader = love.graphics.newShader(gravity_shader)
      

      local sun_x = love.graphics.getWidth() / 2
      local sun_y = love.graphics.getHeight() / 2
      local sun_texture = love.graphics.newImage("Assets/Planets/Suns/Red/Sun_Red_01_256x256.png")
      local sun_w = sun_texture:getWidth()
      local sun_body = love.physics.newBody(world, sun_x, sun_y, "kinematic")
      local sun_shape = love.physics.newCircleShape(sun_x, sun_y, sun_w / 2)

      sun:init(sun_x, sun_y, 1000,
            sun_texture,
            sun_body,
            sun_shape
      )


      local p1_x = 400
      local p1_y = 400
      local p1_texture = love.graphics.newImage("Assets/Planets/Solid/Ocean/Ocean_01-128x128.png")
      local p1_body = love.physics.newBody(world, p1_x, p1_y, "kinematic")
      local p1_w = p1_texture:getWidth()
      local p1_shape = love.physics.newCircleShape(p1_x, p1_y, p1_w / 2)

      planet_1:init(p1_x, p1_y, 1000,
            p1_texture,
            p1_body,
            p1_shape)

      Shader:send( "body_pos" , { sun_x, sun_y } )
      Shader:sendColor( "g_color", {0.84, 0.87, 0.16,1}, {0.125, 0.737, 0.851,1})
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
      sun.x, sun.y = sun.p_body:getPosition()

      theta = theta + (math.pi / 20 * dt)
      local p1_x, p1_y = GetElipticalOrbitCoordinate(sun.x, sun.y, theta, 600, 400)
      planet_1:updatePosition(p1_x, p1_y)
       Shader:send( "body2_pos" , { p1_x, p1_y } )
end

function love.draw()
      


      love.graphics.setShader(Shader)
      love.graphics.rectangle("fill",0,0,love.graphics:getWidth(), love.graphics:getHeight())
      -- Draw game

      love.graphics.setShader()
            love.graphics.setColor(0,0,0,1)
      gravity.drawFieldGrid(40, 24, 50, sun, planet_1)
      love.graphics.setColor(1,1,1,1)
      love.graphics.print(string.format("sun %d,%d", sun.x,sun.y), 100, 10)
      if printPhysics then
            --Draw physics
            local sun_body_x, sun_body_y = sun.p_body:getPosition()
            local sun_body_radius = sun.p_shape:getRadius()
            love.graphics.circle("line", sun_body_x, sun_body_y, sun_body_radius);

            --Draw physics
            local p1_body_x, p1_body_y = planet_1.p_body:getPosition()
            local p1_body_radius = planet_1.p_shape:getRadius()
            love.graphics.circle("line", p1_body_x, p1_body_y, p1_body_radius);
      else
            love.graphics.draw(sun.g_texture, sun.x - sun.g_w / 2, sun.y - sun.g_h / 2)
            love.graphics.draw(planet_1.g_texture, planet_1.x - planet_1.g_w / 2, planet_1.y - planet_1.g_h / 2)
      end
      -- draw fps
      love.graphics.setColor(0,0,0,1)
      love.graphics.rectangle("fill",0,0,80,40)
      love.graphics.setColor(1,1,1,1)
      love.graphics.print(string.format("FPS: %d", love.timer.getFPS()), 10, 10)


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
