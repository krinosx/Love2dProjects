local v = require "uservalues"
local s = require "scenes.base"

local oldFont, bigFont

local timeout = 3
local currentTimeout = 0
local canPass = false
local bg = nil
local dragon = nil

function s.load()
    v.currentMiniGame = "minigame"
    oldFont = love.graphics.getFont()
    bigFont = love.graphics.newFont("FunnyKid.ttf", 120)
    currentTimeout = 0
    canPass = false
    bg = love.graphics.newImage("img/wm_bg.png")
    dragon = love.graphics.newImage("img/dragon.png")
    love.graphics.setBackgroundColor(240,240,240)
end

function s.draw()
    love.graphics.draw(bg)
    love.graphics.draw(dragon,570,220,0,0.2,0.2)

    local r,g,b,a = love.graphics.getColor()
    love.graphics.setColor(0,139,139,255)
    love.graphics.setFont(bigFont)
    love.graphics.printf("Game\nOver",80,150, 400, "center")

    love.graphics.printf("Julien was not strong enough to cross the challenges and has fainted.",80,450,1000,"center",0,0.4,0.4)

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