local s = require "scenes.base"

local timeout = 3
local currentTimeout = 0
local canPass = false
local bg = love.graphics.newImage("img/tutorial.png")

function s.load()
    currentTimeout = 0
    canPass = false
end

function s.draw()
    love.graphics.draw(bg)
end

function s.update(dt)
    currentTimeout = currentTimeout + dt
    if currentTimeout >= timeout then
        canPass = true
    end
end

function s.keypressed(key)
    if key == "escape" or key == "return" then
        if canPass then
            loadScene("overview")
        end
    end
end

function s.mousepressed( ... )
    if canPass then
        loadScene("overview")
    end
end

return s