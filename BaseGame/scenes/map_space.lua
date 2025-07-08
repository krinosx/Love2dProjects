local space = SceneManager:createScene(MAP_SPACE)

WF = require 'libraries/windfield'

space.description = "Orbit Simulation"

function space:load()
    space.font = love.graphics.newFont("ui/fonts/evilempire.ttf", 56)
    local window_width, window_height, window_flags = love.window.getMode()

    space.world = WF.newWorld(0,0,true)

    space.bodies = {}
    space.bodies.box = space.world:newRectangleCollider(400 - 50/2, 200, 50, 50)
    space.bodies.planet = space.world:newCircleCollider(window_width/2, window_height/2, 50)

    space.bodies.planet:setActive( false )


    return true
end

function space:unload()
    space.font = nil
end


function space:update(dt)
    -- update the phisical world
    self.world:update(dt)

    local box_speed = 100
    local px_box = space.bodies.box:getX()
    local py_box = space.bodies.box:getY()
    local px_planet = space.bodies.planet:getX()
    local py_planet = space.bodies.planet:getY()

    local force_angle = math.atan2(py_planet - py_box, px_planet - px_box)
    --print(force_angle)

    local x_force = math.cos(force_angle)
    local y_force = math.sin(force_angle)

    print ("X_forceFactor:"..x_force.."Y_forceFactor:"..y_force)

    space.bodies.box:applyForce(x_force * box_speed, y_force * box_speed)

end

function space:draw()
    local selectedColor = {255,0,0,255}
    local r,g,b,a = love.graphics.getColor()
    local originalFont = love.graphics.getFont()
	local font = space.font

    self.world:draw()
end


-- Check for engine events
function space:checkEvent(event)
    if event == "moveUp" then
        self:moveUp()
    end
    if event == "moveDown" then
        self:moveDown()
    end
    if event == "interact" then
       -- do nothing for now
    end
end

function space:moveUp()

end

function space:moveDown()
    space.bodies.box:applyLinearImpulse(0,500)
end

return space