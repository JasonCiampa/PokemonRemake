local fontSize = 60
local font = love.graphics.newFont("assets/fonts/showcard_gothic.ttf", fontSize)

--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--

-- Returns the current color.
local function getCurrentColor()
    return {love.graphics.getColor()}
end

--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--

-- Detects whether an object was clicked on (true) or not (false).
local function mouseInObject(object, mouseX, mouseY)
    return ((mouseX >= object.x) and (mouseX <= object.x + object.width)) and ((mouseY >= object.y) and (mouseY <= object.y + object.height))
end

--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--

-- Determines whether the mouse is hovering over an object (true) or not (false).
function isMouseHovering(object)
    local mouseX, mouseY = love.mouse.getPosition()
    if (mouseInObject(object, mouseX, mouseY)) then
        return true
    else
        return false
    end
end
--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--

-- Creates a new Scene
local sceneMaker = {}
function sceneMaker.makeScene(backgroundImage, x, y, backgroundMusic)
    local scene = {}
    scene.active = false

    -- Background Image of Scene
    scene.background = love.graphics.newImage(backgroundImage)

    scene.width = scene.background:getWidth()
    scene.height = scene.background:getHeight()
    scene.x = x
    scene.y = y

    if (backgroundMusic ~= nil) then
        scene.backgroundMusic = backgroundMusic
        scene.backgroundMusic:setVolume(0.50)
        scene.backgroundMusic:setLooping(true)
    end
    
    scene.buttons = {}

    -- Creates a new Button within the scene
    function scene.makeButton(scene, width, height, x, y, backgroundColor, backgroundHoverColor, textColor, textHoverColor, text)
        local button = {}

        button.width = width
        button.height = height
        button.x = x
        button.y = y

        button.backgroundColor = backgroundColor
        button.backgroundHoverColor = backgroundHoverColor

        button.textColor = textColor
        button.textHoverColor = textHoverColor

        button.currentBackgroundColor = backgroundColor
        button.currentTextColor = textColor

        button.text = text

        button.sfx = love.audio.newSource("assets/audio/sfx/button_click.mp3", "static")  -- Minecraft Button Click SFX https://www.youtube.com/watch?v=rG-856TmuzA
        button.sfx:setVolume(0.50)
        button.sfx:setLooping(false)

        -- This code is to be initialized manually by whoever creates the button, as this code will execute code to achieve whatever the button's unique purpose is.
        function button.performAction(button, mouseX, mouseY)

        end

        -- This function executes code whenever the Button is pressed.
        function button.isPressed(button, mouseX, mouseY)
            if (mouseInObject(button, mouseX, mouseY)) then
                love.audio.play(button.sfx)

                button:performAction(mouseX, mouseY)
            end
        end

        function button.mouseHovering(button)
            if (isMouseHovering(button)) then
                button.currentBackgroundColor = button.backgroundHoverColor
                button.currentTextColor = button.textHoverColor
            else
                button.currentBackgroundColor = button.backgroundColor
                button.currentTextColor = button.textColor
            end
        end

        -- Draws the Button on the screen.
        function button.draw(button)
            local previousColor = getCurrentColor()
            love.graphics.setColor(button.currentBackgroundColor)
            love.graphics.rectangle("fill", x, y, width, height)

            love.graphics.setColor(button.currentTextColor)
            love.graphics.printf(button.text, font, button.x, (button.y + (button.height / 2)) - (fontSize * 0.4), button.width, "center")
            love.graphics.setColor(previousColor)
        end

        return button
    end

    -- This function is only called after a left-click has been detected by the love.mousepressed function.
    function scene.mousepressed(mouseX, mouseY)
        for buttonKey, button in pairs(scene.buttons) do 
            button:isPressed(mouseX, mouseY)
        end
    end

    -- Draws the Scene on the screen.
    function scene.draw(scene)
        love.graphics.draw(scene.background, scene.x, scene.y)

        for buttonKey, button in pairs(scene.buttons) do -- Found out how to iterate over key and value pairs from here: https://opensource.com/article/22/11/iterate-over-tables-lua 
            button:draw()
        end
    end

    return scene
end

return sceneMaker