local shader = nil
-- To off screen rendering
--local buffer = nil;

local image = nil;

function love.load()

--	buffer = love.graphics.newCanvas(800,600);
	image = love.graphics.newImage("image.png")

    shader = love.graphics.newShader( "sky_color.shader" )
    shader:send("sky_color", {0.0,0.0,1.0,1} )
	
end

function love.draw()
    love.graphics.setShader( shader )
    -- Off screen rendering
    --love.graphics.setCanvas(buffer)
        local r, g, b, a = love.graphics.getColor()
       --buffer:clear()
        love.graphics.setColor(255, 0, 0, 128)
        love.graphics.rectangle('fill', 200, 200, 300, 300)
        love.graphics.setColor(r, g, b, a)
        love.graphics.draw( image )
        -- return to default output 
    --love.graphics.setCanvas()

    --love.graphics.draw( buffer )
    love.graphics.setShader()
    love.graphics.print("Mude o sky_color para trocar a cor da tela")
end

function love.keypressed( key )
   if key == 'escape' then
		  love.event.quit()
   end
end