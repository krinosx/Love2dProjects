local settings = SceneManager:createScene(SETTINGS)

settings.description = "Settings and CONFIGS"

function settings:update(dt)
end

function settings:draw()
    love.graphics.print(self.description,10,10)
end

function settings:load()
    return true
end
function settings:unload()
end


-- Check for engine events
function settings:checkEvent(event)
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

function settings:moveUp()
    print("settings - MoveUp")
end

function settings:moveDown()
    print("settings - MoveDown")
end

function settings:interact()
    print("settings - interact")
end

function settings:loadMenu()
    GameState:save()
    print("settings - Saving and Loading Menu")
    SceneManager:loadScene(MAIN_MENU)
end



return settings