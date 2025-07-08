local v = require "uservalues"
local s = require "scenes.base"

local oldFont, bigFont

local timeout = 3
local currentTimeout = 0
local canPass = false
local bg = nil
local julien = nil
local princess = nil
local heart = nil

function s.load()
    v.currentMiniGame = "minigame"
    oldFont = love.graphics.getFont()
    bigFont = love.graphics.newFont("FunnyKid.ttf", 100)
    currentTimeout = 0
    canPass = false
    bg = love.graphics.newImage("img/wm_bg.png")
    julien = love.graphics.newImage("img/julien_dead.png")
    princess = love.graphics.newImage("img/prinspirit.png")
    heart = love.graphics.newImage("img/heart.png")
    love.graphics.setBackgroundColor(240,240,240)
end

function s.draw()
    love.graphics.draw(bg)
    love.graphics.draw(julien,800,300,0,-0.5,0.5)
    love.graphics.draw(princess,950,310,0,-0.5,0.5)
    love.graphics.draw(heart,700,170)


    local r,g,b,a = love.graphics.getColor()
    love.graphics.setColor(0,139,139,255)
    love.graphics.setFont(bigFont)
    love.graphics.printf("Victory!",80,150, 400, "center")

    love.graphics.printf("Despite the dragon being much stronger than Julien, with the princess' help, our hero was brave enough, and now they can stay together and 'live' happy forever.",80,320,1000,"center",0,0.4,0.4)

    love.graphics.setFont(oldFont)
    love.graphics.setColor(r,g,b,a)
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
            loadScene("menu")
        end
    end
end

function s.mousepressed( ... )
    if canPass then
        loadScene("menu")
    end    
end
return s