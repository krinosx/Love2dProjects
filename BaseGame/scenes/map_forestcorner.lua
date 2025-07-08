local forestcorner = SceneManager:createScene(MAP_FOREST_CORNER)

forestcorner.description = "Forest Corner"

function forestcorner:update(dt)
end

function forestcorner:draw()
    love.graphics.print(self.description,10,10)
    forestcorner.gamemap:draw(1,1,forestcorner.scalewidth,1.6)
end

function forestcorner:load()
    forestcorner.gamemap = sti("maps/forest_corner.lua")
    forestcorner.mapscreenwidth = forestcorner.gamemap.width * forestcorner.gamemap.tilewidth;
    forestcorner.mapscreenheight = forestcorner.gamemap.height * forestcorner.gamemap.tileheight;
    forestcorner.scalewidth = GAME_SCREEN_WIDTH/forestcorner.mapscreenwidth
    forestcorner.scaleheight = GAME_SCREEN_HEIGHT/forestcorner.mapscreenheight

    return true
end
function forestcorner:unload()
end

return forestcorner