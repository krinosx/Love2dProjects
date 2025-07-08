local citystreet = SceneManager:createScene(MAP_CITY_STREET)

citystreet.description = "City Street"

function citystreet:update(dt)
end

function citystreet:draw()
    love.graphics.print(self.description,10,10)
    citystreet.gamemap:draw(1,1,citystreet.scalewidth,citystreet.scaleheight)
end

function citystreet:load()
    citystreet.gamemap = sti("maps/city_street.lua")
    citystreet.mapscreenwidth = citystreet.gamemap.width * citystreet.gamemap.tilewidth;
    citystreet.mapscreenheight = citystreet.gamemap.height * citystreet.gamemap.tileheight;
    citystreet.scalewidth = GAME_SCREEN_WIDTH/citystreet.mapscreenwidth
    citystreet.scaleheight = GAME_SCREEN_HEIGHT/citystreet.mapscreenheight

    return true
end
function citystreet:unload()
    citystreet.gamemap = nil
end


-- Check for engine events
function citystreet:checkEvent(event)
    if event == "moveUp" then
        self:moveUp()
    end
    if event == "moveDown" then
        self:moveDown()
    end
    if event == "interact" then
        self:interact()
    end

    if( event == "menu" ) then
        self:loadMenu()
    end
end


function citystreet:moveUp()
    print("Citystreep - MoveUp")
end

function citystreet:moveDown()
    print("Citystreep - MoveDown")
end

function citystreet:interact()
    print("Citystreep - interact")
end

function citystreet:loadMenu()
    GameState:save()
    print("Citystreep - Saving and Loading Menu")
    SceneManager:loadScene(MAIN_MENU)
end

return citystreet