CelBody = {
    x = 0,     -- x position
    y = 0,     -- y position
    mass = 0, -- body mas
    p_body = nil,
    p_shape = nil,
    p_fixture = nil,
    g_w = 0,         -- graphics width
    g_h = 0,         -- graphics height
    g_texture = nil, -- texture to represent the body
}

function CelBody:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function CelBody:getPosition()
    return self.x, self.y
end

-- Draw the body in the map
function CelBody:draw()
    -- implement
end

function CelBody:init(x, y, mass, texture, body, shape)
    self.x = x
    self.y = y
    self.mass = mass
    self.g_texture = texture
    self.g_w, self.g_h = self.g_texture:getDimensions()
    self.p_body = body
    self.p_shape = shape
    self.fixture = love.physics.newFixture(self.p_body, self.p_shape)
end

--
-- Update position of a static body
-- Set both its physical body and texture coordinates
--
function CelBody:updatePosition(x, y)
    self.p_body:setPosition(x, y)
    self.x = x
    self.y = y
end


return CelBody;
