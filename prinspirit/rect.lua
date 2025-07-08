Rect = {}
local mt = {__index = Rect}

function Rect.new(x,y,w,h)
    local r = {
               x = x,
               y = y,
               w = w,
               h = h,
               image = nil
              }

    setmetatable(r,mt)
    return r
end
setmetatable(Rect,{__call = function(_,...) return Rect.new(...) end})

function Rect.isInside(self,x,y)
    return not (self.x > x or
                self.x + self.w < x or
                self.y > y or
                self.y + self.h < y)
end

function Rect.draw(self)
    --local r,g,b,a = love.graphics.getColor()
    --love.graphics.setColor(0,255,0,255)
    --love.graphics.rectangle("line",self.x, self.y, self.w, self.h)
    --love.graphics.setColor(r,g,b,a)
end