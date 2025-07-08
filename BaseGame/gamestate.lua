local lume = require("libraries.lume")

local gamestate = {
    data = {
        currentScene = nil,
        currentPoints = 0
    }
}

function gamestate:save()
    local serializedData = lume.serialize(self.data)
    love.filesystem.write("savedata.txt", serializedData)
end

function gamestate:load()
    if love.filesystem.getInfo("savedata.txt") ~= nil then
        local filecontent = love.filesystem.read("savedata.txt")
        self.data = lume.deserialize(filecontent)
    end
end

return gamestate