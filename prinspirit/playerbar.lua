PlayerBar = {}
local mt = {__index = PlayerBar}

function PlayerBar.new(_x,_y,kind)
    local b = {
        x = _x, 
        y = _y,
        health = love.graphics.newImage("img/hp_bar.png"),
        power = love.graphics.newImage("img/power_bar.png"),
        bg = love.graphics.newImage("img/full_bg_bar.png"),
        healthQuad = nil,
        powerQuad = nil
    }
    b.healthQuad = love.graphics.newQuad(0,0,b.health:getWidth(),b.health:getHeight(),b.health:getWidth(),b.health:getHeight())
    b.powerQuad = love.graphics.newQuad(0,0,b.power:getWidth(),b.power:getHeight(),b.power:getWidth(),b.power:getHeight())
    b.healthMax = b.health:getWidth()
    b.powerMax = b.power:getWidth()
    b.healthVal = 100
    b.powerVal = 0
    setmetatable(b,mt)
    return b
end
setmetatable(PlayerBar,{__call = function(_,...) return PlayerBar.new(...) end})

function PlayerBar:draw()
    love.graphics.draw(self.bg, self.x, self.y)
    love.graphics.draw(self.health, self.healthQuad, self.x + 90, self.y + 48)
    love.graphics.draw(self.power, self.powerQuad, self.x + 95, self.y + 64 )
end

function PlayerBar:setHealth(val)
    self.healthVal = val
    self.healthQuad:setViewport(0,0,self.healthMax * val / 100, self.health:getHeight())
end

function PlayerBar:setPower(val)
    self.powerVal = val
    self.powerQuad:setViewport(0,0,self.powerMax * val / 100, self.power:getHeight())
end

