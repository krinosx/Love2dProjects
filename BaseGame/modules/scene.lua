local SceneManager = {
    sceneList = {},
    currentScene = nil
}
--
-- SCENE OBJECTS DEFINITIONS
---
local Scene = {
    id = 0,
    description = "Change me your lazy programmer",
    loaded = false
}
local scenemt = {__index = Scene}

function Scene.new(id)
    local s = {
        id = id
    }
    -- inherits from Scene
    setmetatable(s, scenemt)
    return s
end

function Scene:update(dt)
end
function Scene:draw()
    love.graphics.print(self.description,10,10)
end
function Scene:load()
    return false
end
function Scene:unload()
end
function Scene:checkEvent(event)
end

--
-- SCENE OBJECTS DEFINITIONS
---

--
-- Scene Manager utility functions
--
function SceneManager:createScene(id)
    local newscene = Scene.new(id)
    self:addScene(newscene)
    return newscene
end

-- Add a scene to a list
function SceneManager:addScene(scene)
    table.insert(SceneManager.sceneList,scene)
end

-- return a scene based on the id
function SceneManager:getScene(id)
    for _, v in ipairs(SceneManager.sceneList) do
        if( v.id == id ) then
            return v
        end
    end
    return nil
end

-- load a scene and set it as active
function SceneManager:loadScene(id)
    local loadingScene = self:getScene(id)
    if loadingScene ~= nil then
        -- if its already loaded, its all right
        if self.currentScene ~= nil and loadingScene.id == self.currentScene.id then
          return true
        end
        if loadingScene:load() then
            if self.currentScene ~= nil then
                self.currentScene:unload()
            end
            self.currentScene = loadingScene
            return true
        else
            return false
        end
    end
end

function SceneManager:drawCurrentScene()
    if self.currentScene ~= nil then
        self.currentScene:draw()
    else
        love.graphics.setColor(1,0,0,1);
        love.graphics.print("NO SCENE! You must load a scene first.", 10, 20)
    end
end

function SceneManager:updateCurrentScene(dt)
    if self.currentScene ~= nil then
        self.currentScene:update(dt)
    end
end

function SceneManager:pushEvent(event)
    if( self.createScene ~= nil ) then
        self.currentScene:checkEvent(event)
    end
end

return SceneManager;