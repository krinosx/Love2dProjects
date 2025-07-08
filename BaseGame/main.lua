
if arg[#arg] == "vsc_debug" then require("lldebugger").start() end

-- SCENE IDS
MAIN_MENU = 1
SETTINGS = 2
CREDITS = 3
MAP_FOREST_CORNER = 4
MAP_CITY_STREET = 5
MAP_SPACE = 6

-- globals
_G.GAME_SCREEN_WIDTH = 1920
_G.GAME_SCREEN_HEIGHT = 1080

SceneManager = require("modules.scene")
GameState = require("gamestate")
sti = require("libraries/sti")

function love.load()
    local mainMenu = require("scenes.mainmenu")
    local settings = require("scenes.settings")
    local forestcorner = require("scenes.map_forestcorner")
    local citystreet = require("scenes.map_citystreet")
    local spacesim = require("scenes.map_space")

    GameState:load()
    SceneManager:loadScene(citystreet.id)
end



function love.update(dt)
    SceneManager:updateCurrentScene(dt)
    GameState.data.currentPoints = GameState.data.currentPoints + 1 * dt
end

function love.draw()
    SceneManager:drawCurrentScene()
end


-- Event handling

-- (key: love.KeyConstant, scancode: love.Scancode, isrepeat: boolean)
function love.keypressed(key, scancode, isrepeat)
    if( scancode == "up" ) then
        SceneManager:pushEvent("moveUp")
    end
    if( scancode == "down") then
        SceneManager:pushEvent("moveDown")
    end
    if( scancode == "return" ) then
        SceneManager:pushEvent("interact")
    end

    if( scancode == "escape" ) then
        GameState:save()
        SceneManager:pushEvent("menu")
    end

    -- debugging
    print(key,scancode, isrepeat)
end
