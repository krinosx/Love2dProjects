
local v = require "uservalues"

currentScene = nil
showDebug = false

finishedFont = nil

local function clamp(min, max, val)
    return (min > val) and min or ((val > max) and max or val)
end

-- unloads current screen and loads new screen (screens are in "screens" folder)
function loadScene(name)
    if currentScene then
        currentScene.unload()
    end
    
    local chunk = love.filesystem.load("scenes/"..name..".lua")
    currentScene = chunk()
    currentScene.load()
 
end
-- first called function
function love.load()
    love.graphics.setNewFont("FunnyKid.ttf",20)
    finishedFont = love.graphics.newFont("FunnyKid.ttf",40)
    love.window.setMode(1024,768,{
        fullscreen = false,
        resizable = false
        })
    love.window.setTitle("PrinSpirit")
    loadScene("menu")
end

-- called at every screen update
function love.draw()
    if currentScene then
        currentScene.draw()
    end
    if showDebug then
        debug()
    end

end

-- main game loop (dt = delta time)
function love.update(dt)
    if currentScene then
        currentScene.update(dt)
    end
end

-- make sure the scene is unloaded before quit
function love.quit()
    if currentScene then
        currentScene.unload()
    end
end

function love.keypressed(...)
    if currentScene then
        currentScene.keypressed(...)
    end
end

function love.keyreleased( ... )
    if currentScene then
        currentScene.keyreleased(...)
    end
end

function love.mousepressed( ... )
    if currentScene then
        currentScene.mousepressed(...)
    end
end

function love.mousereleased( ... )
    if currentScene then
        currentScene.mousereleased(...)
    end
end

function debug()
   i = love.window.getHeight( ) - 15;
   for k, val in pairs( v ) do

        if type(val) ~= "table" then
            love.graphics.print( k..": "..val, 10, i )
        else
            love.graphics.print( k..": tabela. ", 10, i )
        end

    i = i-15
   end
end


function evaluateLevel( sensibleArea )
    alive = true
    deltaPower = 0
    deltaHp = 0

    if sensibleArea.powerIdx then 
        v.currentPower =  clamp(0, 100, v.currentPower + v.powerButtons[ sensibleArea.powerIdx ].powerup)
        v.currentHP = clamp(0, 100, v.currentHP + v.powerButtons[ sensibleArea.powerIdx ].hpup )

        alive = v.currentHP > 0
        deltaPower = v.powerButtons[ sensibleArea.powerIdx ].powerup
        deltaHp = v.powerButtons[ sensibleArea.powerIdx ].hpup
    end
    return alive, deltaPower, deltaHp

end


function popUpTransitionScreen( deltaPower, deltaHp, starEarned )
        local oldFont = love.graphics.getFont()
        r, g, b, a = love.graphics.getColor( )
        love.graphics.setColor( 255 , 255 , 255, a * 0.8 )
        love.graphics.rectangle("fill", 200, 100, 390, 490 )


        love.graphics.setColor( 210 , 180 , 140, a * 0.8 )
        love.graphics.rectangle("fill", 230, 130, 330, 430 )

        love.graphics.setLineWidth(3 )
        love.graphics.setLineStyle( "smooth")
        love.graphics.setColor( 0 , 0 , 0, a * 0.8 )
        love.graphics.rectangle("line", 230, 130, 330, 430 )

        love.graphics.setFont(finishedFont)

        love.graphics.setColor(0,139,139,200)
        love.graphics.print(" Stage Clear ", 250, 150)


        if starEarned then
            love.graphics.setColor(r,g,b,a)
            love.graphics.draw( v.starImage , 350, 200 )
            love.graphics.setColor(0,139,139,200)
        else
            love.graphics.setColor(0,0,0,200)
            love.graphics.draw( v.starImage , 350, 200 )
            love.graphics.setColor(0,139,139,200)
        end

        love.graphics.print( " Power Up: "..deltaPower , 300, 330, 0, 0.75)
        love.graphics.print( " HP Loss: "..deltaHp , 300, 360, 0, 0.75)


        love.graphics.setColor( 255, 255, 255, 200 )
        love.graphics.rectangle( "fill", 300, 460, 200, 60 )

        love.graphics.setColor( 210 , 180 , 140, a * 0.8 )
        love.graphics.rectangle( "fill", 310, 470, 180, 40 )

        love.graphics.setColor( 0, 0, 0, 200 )
        love.graphics.rectangle( "line", 300, 460, 200, 60 )
        love.graphics.rectangle( "line", 310, 470, 180, 40 )


        love.graphics.setColor(0,139,139,200)
        love.graphics.print ( " Next >> ", 340, 475, 0, 0.75, 0.75 )

        love.graphics.setLineWidth( 1 )
        love.graphics.setLineStyle("smooth")
        
        love.graphics.setColor(r,g,b,a)
        love.graphics.setFont(oldFont)
end


