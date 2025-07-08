-- To off screen rendering
--local buffer = nil;

local shader = nil
local image = nil;
local flickTimeout = 0.3
local curFlickTime = 0
local curFlickVal = 200

function love.load()

	love.window.setMode( 800, 600, {resizable=false, vsync=false, minwidth=800, minheight=600}  )

	image = love.graphics.newImage("image.png")
    shader = love.graphics.newShader( "lantern.shader" )
    shader:send("light_power", 1.0 )
	shader:send("light_size", 200 )
	shader:send("light_color", {1,1,0.5} )
end



function love.update(dt)
	curFlickTime = curFlickTime + dt
	if curFlickTime >= flickTimeout then
		curFlickTime = 0
		curFlickVal = curFlickVal == 200 and 190 or 200
		shader:send("light_size",curFlickVal)
		flickTimeout = math.random(5,20) / 100
	end
end


function love.draw()
    love.graphics.setShader( shader )
    -- Off screen rendering
    --love.graphics.setCanvas(buffer)
       local r,g,b,a = love.graphics.getColor()
       --buffer:clear()
        love.graphics.setColor(255, 0, 0, 128)
        love.graphics.rectangle('fill', 200, 200, 300, 300)
        love.graphics.setColor(r,g,b,a)
        love.graphics.draw( image )
        -- return to default output 
    --love.graphics.setCanvas()

    -- Light position
    local x, y = love.mouse.getPosition( )
    shader:send("light_pos", {x , y} )
    --love.graphics.draw( buffer )
    love.graphics.setShader()
    love.graphics.print("luz com flick")
    love.graphics.print("FPS: "..love.timer.getFPS(), 10, 20)
end

function love.keypressed( key )
   if key == 'escape' then
		  love.event.quit()
   end
end