require "rect"

local s = require "scenes.base"
local v = require "uservalues"
local oldFont, buttonFont, bigFont
local startButton, exitButton
local bg, princess, julien

s.soundtrack = nil

function s.load()
    oldFont = love.graphics.getFont()
    buttonFont = love.graphics.newFont("FunnyKid.ttf",50)
    bigFont = love.graphics.newFont("FunnyKid.ttf",120)
    creditsFont = love.graphics.newFont("FunnyKid.ttf",24)

    startButton = Rect(love.graphics.getWidth()/2-70,400,140,50)
    startButton.text = "Start"

    exitButton = Rect(love.graphics.getWidth()/2-50,550,100,50)
    exitButton.text = "Exit"

    bg = love.graphics.newImage("img/wm_bg.png")
    princess = love.graphics.newImage("img/prinspirit.png")
    julien = love.graphics.newImage("img/julien.png")
    love.graphics.setBackgroundColor(240,240,240)

    local data = love.sound.newSoundData("audio/menu.mp3")
	s.soundtrack = love.audio.newSource(data)
	s.soundtrack:setLooping(true)
    s.soundtrack:play()

    v.reloadGame = true

end

function s.unload()
    love.graphics.setFont(oldFont)
    buttonFont = nil
    bigFont = nil
end

function s.mousepressed(x,y,k)
    if startButton:isInside(x,y) then
    	v.reloadGame = true
        loadScene("tutorial")
    end
    if exitButton:isInside(x,y) then
        love.event.quit()
    end
end

function s.update(dt)
end

function s.draw()

    love.graphics.draw(bg)
    love.graphics.draw(princess,love.graphics.getWidth()-120,260,0,-0.6,0.6)
    love.graphics.draw(julien,julien:getWidth()*0.6 + 60,220,0,-0.6,0.6)

    local r,g,b,a = love.graphics.getColor()
    love.graphics.setFont(bigFont)
    love.graphics.setColor(153, 110, 93, 255)
    love.graphics.printf("Prin",0,130,love.graphics.getWidth()/2 - 30,"right")
    love.graphics.setColor(255,255,255,192)
    love.graphics.printf("s",0,130,love.graphics.getWidth(),"center")
    love.graphics.setColor(93, 128, 125, 255)
    love.graphics.printf("pirit",love.graphics.getWidth()/2 + 30,130,love.graphics.getWidth(),"left")

    love.graphics.setFont(buttonFont)
    love.graphics.printf(startButton.text, startButton.x, startButton.y, startButton.w,"center")
    love.graphics.printf(exitButton.text, exitButton.x, exitButton.y, exitButton.w,"center")

    love.graphics.setFont(creditsFont)
    love.graphics.setColor(93, 128, 125, 255)
    love.graphics.printf("Arthur Ferrai, Giuliano Bortolassi, Vitor Navarro - GGJ2014",0,love.graphics.getHeight()-40,love.graphics.getWidth(),"center")

    love.graphics.setColor(r,g,b,a)
    love.graphics.setFont(oldFont)

    startButton:draw()
    exitButton:draw()


end

function s.keypressed(key, isrepeat)
    if key == "escape" then
        love.event.quit()
    end
end

return s