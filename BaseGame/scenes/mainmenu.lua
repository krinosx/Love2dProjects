local mainmenu = SceneManager:createScene(MAIN_MENU)

local BTN_WIDTH = 400
local BTN_HEIGHT = 200
local BTN_MARGIN = 50


mainmenu.description = "MAIN MENU"
mainmenu.buttons = {}
mainmenu.selectedButton = 1  -- Default selected button = btn_newGame
mainmenu.MAX_BUTTON_INDEX = 3

function mainmenu:load()

    mainmenu.font = love.graphics.newFont("ui/fonts/evilempire.ttf", 56)
    mainmenu.baseButton = love.graphics.newImage("ui/buttons/menu_btn_base.png")
    mainmenu.highButton = love.graphics.newImage("ui/buttons/menu_btn_selected.png")

    local btnImgWidth = mainmenu.baseButton:getWidth()
    local btnImgHeight = mainmenu.baseButton:getHeight()
    BTN_WIDTH = btnImgWidth
    BTN_HEIGHT = btnImgHeight

    local window_width, window_height, window_flags = love.window.getMode()
    mainmenu.xBtnPos = (window_width/2) - (BTN_WIDTH/2)

    local btn_newGame = {
        text = "New Game",
        width = BTN_WIDTH,
        height = BTN_HEIGHT,
        selected = false,
        action = function()
            SceneManager:loadScene(MAP_CITY_STREET)
        end
    }

    local btn_settings = {
        text = "Settings",
        width = BTN_WIDTH,
        height = BTN_HEIGHT,
        selected = false,
        action = function()
            SceneManager:loadScene(SETTINGS)
        end
    }

    local btn_exit = {
        text = "Exit",
        width = BTN_WIDTH,
        height = BTN_HEIGHT,
        selected = false,
        action = function()
            love.event.quit()
        end
    }


    mainmenu.buttons = {
        btn_newGame,
        btn_settings,
        btn_exit
    }

    btn_newGame.selected = true

    return true
end

function mainmenu:unload()
    mainmenu.font = nil
    mainmenu.baseButton = nil
    mainmenu.highButton = nil
end


function mainmenu:update(dt)
end

function mainmenu:draw()
    local selectedColor = {255,0,0,255}
    local r,g,b,a = love.graphics.getColor()

    local originalFont = love.graphics.getFont()

	local font = mainmenu.font

    love.graphics.setFont(font)

    local ypos = 30;
    for i, btn in ipairs(mainmenu.buttons) do

        local textWidth  = font:getWidth(btn.text)
        local textHeight = font:getHeight()

        if( btn.selected ) then
           love.graphics.draw(self.highButton, self.xBtnPos, ypos)
           love.graphics.setColor(0,0,0,255)
           love.graphics.print(btn.text, self.xBtnPos + ( BTN_WIDTH/2 ) - (textWidth/2)   , ypos + ( BTN_HEIGHT/2 ) - (textHeight/2))
        else
            love.graphics.draw(self.baseButton, self.xBtnPos, ypos)
            
            love.graphics.setColor(0.5,0.5,0.5,1)

            love.graphics.print(btn.text, self.xBtnPos + ( BTN_WIDTH/2 ) - (textWidth/2)   , ypos + ( BTN_HEIGHT/2 ) - (textHeight/2))
        end
        love.graphics.setColor(r,g,b,a)
        ypos = ypos + btn.height + BTN_MARGIN;
    end

    -- restore default fonts
    love.graphics.setFont(originalFont)
end


-- Check for engine events
function mainmenu:checkEvent(event)
    if event == "moveUp" then
        self:moveUp()
    end
    if event == "moveDown" then
        self:moveDown()
    end
    if event == "interact" then
        self.buttons[self.selectedButton]:action()
    end
end

function mainmenu:checkButtonsBoundary()
    if( self.selectedButton <= 0 ) then
        self.selectedButton = self.MAX_BUTTON_INDEX
    end
    if( self.selectedButton > self.MAX_BUTTON_INDEX ) then
        self.selectedButton = 1
    end
end

function mainmenu:moveUp()
    self.selectedButton = self.selectedButton - 1
    self:checkButtonsBoundary()
    self:updateSelectedtButton()
end

function mainmenu:moveDown()
    self.selectedButton = self.selectedButton + 1
    self:checkButtonsBoundary()
    self:updateSelectedtButton()
end


function mainmenu:updateSelectedtButton()
    for i = 1, self.MAX_BUTTON_INDEX, 1 do
        self.buttons[i].selected = false
    end
    self.buttons[self.selectedButton].selected = true

end


function mainmenu:drawButton(button)

end


return mainmenu