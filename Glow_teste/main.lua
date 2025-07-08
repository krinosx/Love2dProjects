local shader = nil
-- To off screen rendering
local imageBuffer = nil;
local offscreen2 = nil;
local image = nil;
local image_bg = nil;

local blur = false
local full_blur = false

local frontscreen = nil;
local offscreen = nil;
local offscreenGlow = nil

shader_blend = nil

function love.load()
	love.window.setMode( 800, 600, {resizable=false, vsync=false, minwidth=800, minheight=600}  )
	
	local pixel_glow = [[

		number Gaussian (number x, number deviation) 
		{ 
			return (1.0 / sqrt(2.0 * 3.141592 * deviation)) * exp(-((x * x) / (2.0 * deviation)));     
		} 
		
		vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords )
		{	
				// Parametros do efeito, devem ser retirados do shader
				number BlurAmount = 5; 
				number BlurStrength = 10.0; 
				number halfBlur = BlurAmount * 0.5; 
				
				number BlurScale = 0.003; 
				
				vec3 eyeSpaceLigthDirection = vec3(0.0,0.0,1.0); 

				number deviation = halfBlur * 0.35; 
				deviation *= deviation; 
				number strength = 1.0 - BlurStrength; 
				
				
				vec4 textColor = vec4(0.0); 
				vec4 colour = vec4(0.0); 
				vec4 textureColor = Texel(texture, texture_coords); 
    	
		
			   for( number i = 0; i < 10; ++i ) 
				{ 
					
					if( i >= BlurAmount ) { 
						break; 
					} 
					
					number offset = ( i - halfBlur ) * BlurScale; 

					vec4 textColor = Texel(texture, texture_coords + vec2(offset, 0.0) ) * Gaussian(offset * strength, deviation); 
					
					colour += textColor*1.0; 
				} 
				vec4 finalColour = colour; 
				
			return clamp( finalColour, 0.0, 1.0 ); 

		}
	]]
	
	
	local pixel_blend = [[
		extern Image glow_map;
		
		vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords )
		{	
		
			vec2 newCoords = (vec2(1.0,1.0) - texture_coords);
		
			vec4 textureColor = Texel( glow_map, texture_coords ); 
			vec4 finalColour = Texel( texture, texture_coords ); 
			
			
			//vec4 finalEffect =  clamp( ( (textureColor + finalColour) - ( finalColour * finalColour ) ), 0.0, 0.5 ) ;
			vec4 finalEffect = min(textureColor + finalColour, 1.0); 
			return finalEffect;
		}
	]]
	
    local vertexcode = [[
        vec4 position( mat4 transform_projection, vec4 vertex_position )
        {
            return transform_projection * vertex_position;
        }
    ]]

	
	shader_glow = love.graphics.newShader( pixel_glow, vertexcode )
	shader_blend = love.graphics.newShader( pixel_blend, vertexcode )
	
	image_gem = love.graphics.newImage("GemBlue.png");
	image_bug = love.graphics.newImage("bug.png")
	image_bg = love.graphics.newImage("bg_map.png")

	
	i_w, i_h = 800,600
	-- off screen render
	offscreen = love.graphics.newCanvas(i_w,i_h);
	offscreen2 = love.graphics.newCanvas(i_w,i_h);
	offscreenGlow = love.graphics.newCanvas(i_w,i_h);
	frontscreen = love.graphics.newCanvas(i_w,i_h);
	
	gem_x, gem_y = 15,85
	gem_sx, gem_xy = 1,1
	
	bug_x, bug_y = 215,185
	bug_sx, bug_xy = 1,1
	
end



function love.draw()
	love.graphics.setShader(  )

	-- First pass: calculate the blur effect
	-- draw to offscreen
	-- v0.9 offscreenGlow:clear(0,0,0,255)
	if blur then
		love.graphics.setCanvas( offscreenGlow )
		love.graphics.clear(0,0,0,255)
		    love.graphics.setShader( shader_glow )
			-- Objects to participate in blur calculations
			love.graphics.draw( image_gem, gem_x, gem_y, 0, gem_sx, gem_sy )
			love.graphics.draw( image_bug, bug_x, bug_y, 0, bug_sx, bug_sy )

		-- Return to original state	
		love.graphics.setShader()
		love.graphics.setCanvas()
	end

	-- Generate the image to blend with glow effect ( the full scene )
	-- v0.9 frontscreen:clear()
	love.graphics.setCanvas( frontscreen )
		love.graphics.clear()
		love.graphics.draw( image_bg, 0, 0 )
		love.graphics.draw( image_gem, gem_x, gem_y, 0, gem_sx, gem_sy )
		love.graphics.draw( image_bug, bug_x, bug_y, 0, bug_sx, bug_sy )


	-- Now blend canvas with original scene to create a GLOW effect
	--v0.9 offscreen:clear()
	love.graphics.setCanvas( offscreen )
	love.graphics.clear()
		if blur then
			love.graphics.setShader( shader_blend )
			shader_blend:send("glow_map", offscreenGlow )
		end
		love.graphics.draw( frontscreen )
		love.graphics.setShader()

	-- return to original state
	love.graphics.setCanvas()
	-- Finally draw the image to the real screen
	love.graphics.draw( offscreen )


	love.graphics.print("Glow Map "..bug_x,500, 0)
	love.graphics.print("Press ENTER to toggle GLOW effect ",10, 500)
	love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 10, 550)

end


local delta_time = 0;
function love.update(dt)
	delta_time = delta_time + dt;
	--print( tostring(delta_time) )
	if delta_time > 0.01 then
		bug_x = bug_x + 1;
		if bug_x > 800 then
			bug_x = -100;
		end
		delta_time = 0;
	end
	
end

function love.keypressed( key )
   if key == 'escape' then
		  love.event.quit()
   end
   
   if key == "return" then
	blur = not blur;
   end
   
end
