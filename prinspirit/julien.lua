Julien = {}
local mt = {__index = Julien}

function Julien.new(sensibleArea)

    local r = {
               x = sensibleArea.x + sensibleArea.w,
               y = sensibleArea.y + sensibleArea.h,
               imag = nil
              }

    setmetatable(r,mt)


    r.imag = love.graphics.newImage("img/julien.png")

    r.y = r.y - r.imag:getHeight() * 0.2


    return r
end
setmetatable(Julien,{__call = function(_,...) return Julien.new(...) end})

function Julien.moveTo(self, sensibleArea )
    self.x = sensibleArea.x + sensibleArea.w
    self.y = sensibleArea.y + sensibleArea.h - self.imag:getHeight() * 0.2
end

function Julien.draw(self)

    love.graphics.draw(self.imag,
                       self.x, 
                       self.y, 
                       0, 
                       -0.2, 
                       0.2)


end
