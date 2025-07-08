local scene_preferences = {
    title = "Game Menu"
}

-- used to load the assets for this scene
scene_preferences.load = function (self)
    
end

-- used to dispose of the assets (free memory) for this scene
scene_preferences.dispose = function (self)
    
end

-- Draw Scene content
scene_preferences.draw = function (self)
    -- fill bg with black
    love.graphics.setColor({0,0,0,1})
    love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())

    love.graphics.setColor({255,255,255,255})
    love.graphics.rectangle("fill", 50, 50, 200, 200);
    
end

-- -- Handle key press for the menu
-- scene_preferences.handle_keyboard = function(self, key)

-- end

return scene_preferences