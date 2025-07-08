

_G.Scene_list = {}
_G.Current_scene = nil

if os.getenv("LOCAL_LUA_DEBUGGER_VSCODE") == "1" then
    require("lldebugger").start()
  end
  

function Load_scene(scene_id)
      if Current_scene ~= nil then
            Current_scene:dispose()
      end
      Current_scene = Scene_list[scene_id]
      if Current_scene ~= nil then
            Current_scene:load()
      else
            print("Failed to load scene!")
            love.event.quit(-1)
      end
      
end



function love.load()
      -- Initialize game
      -- Load scene references
      print("loading")
      Scene_list["menu"] = require("menu");
      Scene_list["preferences"] = require("preferences");

      -- Define current scene
      Load_scene("menu")
      print("Load complete")
      
end
  
function love.update(dt)
      -- Update game state
end
  
function love.draw()
      -- Draw game
      Current_scene:draw()
end

function love.keypressed(key, scancode, isrepeat)
      if key == "escape" then
            love.event.quit()
      end
      if Current_scene ~= nil then
            if Current_scene.handle_keyboard ~= nil then
                  Current_scene:handle_keyboard(key)
            else
                  print("Scene does not handle keyboard actions")
            end
      end
end


