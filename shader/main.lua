local shader = nil
-- To off screen rendering
local imageBuffer = nil;

local image = nil;

function love.load()
	love.window.setMode( 800, 600, {resizable=false, vsync=false, minwidth=800, minheight=600}  )
	
	
	image = love.graphics.newImage("marioMap.jpg")
	i_w, i_h = image:getDimensions( );
	imageBuffer = love.graphics.newCanvas(i_w,i_h);
	love.graphics.setCanvas( imageBuffer );
	love.graphics.draw( image )
	love.graphics.setCanvas( );
	

	local pixel_color_code = [[
 		
        vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords )
        {
        	
			vec4 texcolor = Texel(texture, texture_coords);
			
			number r = texcolor.r;
			number g = texcolor.g;
			number b = texcolor.b;
			
			
            return vec4( 1.0 -r  , 1.0 - g, 1.0-b, 1.0);
        }
    ]]
	
	
	local pixel_waves = [[
		extern number height_adjust;
		extern vec2 screen_size;
		extern number time;
		extern vec4 water_color;
		extern vec4 water_border;
		extern number water_border_size;

		extern number wave_period;
		extern number wave_amplitude;
		extern number wave_velocity;

		vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords )
		{	

			vec2 screen_coords1 = vec2( screen_size.x - screen_coords.x , screen_size.y - screen_coords.y );
			// Normalized position. ranges goes from 0.0 to 1.0
			vec2 pos = ( screen_coords1.xy / screen_size.xy ); 
		
			// Adjust the position of sin curve
			pos.y -= height_adjust; 
			
			// Calculate sin value for given X
			float val = wave_amplitude * sin( pos.x * wave_period + ( time * wave_velocity ) ); 
			
			
			// Check if Y value is part of sin curve and change the color
			vec4 col = color; 
			if( pos.y > val ) { 
                col = water_color;
			} 
			if( pos.y < ( val + water_border_size ) && pos.y > val )
			{
				col = water_border;
			}
			
			vec4 texcolor = Texel(texture, texture_coords);
			return  texcolor * col;			
		}
	]]
	
	
	local pixelcode = [[
 		extern vec2 light_pos;
		extern number light_power;
		
        vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords )
        {
        	number distance =  sqrt(  pow( abs( ( light_pos[0] - screen_coords[0] ) ) ,2) + pow( abs( ( light_pos[1] - ( 600 - screen_coords[1]) ) ) , 2 ) );
			
			number intensity =  pow (( 1.0 - ( clamp( (distance/800), 0, 1) )),4);
			
			vec4 texcolor = Texel(texture, texture_coords);
			
            return texcolor * vec4( light_power * intensity * clamp(color.r,0,1) , light_power * intensity * clamp(color.g,0,1), light_power * intensity * clamp(color.b,0,1), 1.0  ) ;
        }
    ]]

    local vertexcode = [[
        vec4 position( mat4 transform_projection, vec4 vertex_position )
        {
            return transform_projection * vertex_position;
        }
    ]]

    shader = love.graphics.newShader( pixelcode, vertexcode )
	shader:send("light_power", 1.0 )
	
	shader_color = love.graphics.newShader( pixel_color_code, vertexcode )
	
	shader_wave = love.graphics.newShader( pixel_waves, vertexcode )
 
	w_width, w_height, flags = love.window.getMode( );
	
	shader_wave:send( "screen_size", { i_w, i_h } )
	shader_wave:send( "water_color", { 0.5, 0.5, 1.0, 0.8 } )
	shader_wave:send( "water_border", { 0.0, 0.0, 1.0, 1.0 } )
	shader_wave:send( "height_adjust", 0.87 )
	shader_wave:send( "water_border_size", 0.01 )
	shader_wave:send( "wave_amplitude", 0.01 )
	shader_wave:send( "wave_period", 90.0 )
	shader_wave:send( "wave_velocity", 1.5 )
	
	
	
	
	
end



function love.draw()
	love.graphics.setShader(  )
	x, y = love.mouse.getPosition( )
	--shader_wave:send("mousePosition", { x, y } )
	
	
	love.graphics.setCanvas( imageBuffer )
		love.graphics.setShader( shader_wave )
		love.graphics.draw( image, 0 ,0 )
		love.graphics.setShader(  )
		
	love.graphics.setCanvas()
		
	love.graphics.draw( imageBuffer, 0, 0 );
	
	

	--love.graphics.setShader( shader )

	-- shader:send( "light_pos", {x , y} )
	--r,g,b,a = love.graphics.getColor( )
    
    --love.graphics.setColor(255, 0, 0, 128)
    --love.graphics.rectangle('fill', 200, 200, 300, 300)
	--love.graphics.setColor(r,g,b,a)
		
	--love.graphics.setShader( shader_color )
	
	
	--love.graphics.setShader( shader_wave )
	--love.graphics.draw( image, 300, 300 )
	
	love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 10, 10)
	
end

function love.update(dt)
	shader_wave:send("time", love.timer.getTime( ) );
end

function love.keypressed( key )
   if key == 'escape' then
		  love.event.quit()
   end
end
