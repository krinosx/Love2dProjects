local scene_menu = {
    title = "Game Menu"
}

-- used to load the assets for this scene
scene_menu.load = function (self)
    
end

-- used to dispose of the assets (free memory) for this scene
scene_menu.dispose = function (self)
    
end

-- Draw Scene content
scene_menu.draw = function (self)
    -- fill bg with black
    love.graphics.setColor({0,125,125,1})
    love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())

    love.graphics.setColor({255,0,255,255})
    love.graphics.rectangle("fill", 50, 50, 200, 200);
    
end
-- Handle key press for the menu
scene_menu.handle_keyboard = function(self, key)
    if key == "return" then
       Load_scene("preferences") 
    end
end

return scene_menu