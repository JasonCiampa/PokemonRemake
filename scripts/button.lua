local buttonHandler = {}

-- Creates and returns a Button
function buttonHandler.create(width, height, x, y, backgroundColor, textColor, text, textAlignment, fontSize)
    local button = {}

    button.width = width       -- Button width is set
    button.height = height     -- Button height is set
    button.x = x               -- Button x-coordinate is set
    button.y = y               -- Button y-coordinate is set 

    button.backgroundColor = backgroundColor                                                                            -- Button background color is set
    button.backgroundHoverColor = {backgroundColor[1] * 0.5, backgroundColor[2] * 0.5, backgroundColor[3] * 0.5}        -- Button background hover color is set to be 50% dimmer than the Button's regular background color

    button.textColor = textColor                                                            -- Button text color is set
    button.textHoverColor = {textColor[1] * 0.5, textColor[2] * 0.5, textColor[3] * 0.5}    -- Button text hover color is set to be 50% dimmer than the regular text color

    button.currentBackgroundColor = backgroundColor     -- Button current background color is set
    button.currentTextColor = textColor                 -- Button current text color is set

    button.text = text
    
    if (textAlignment == nil) then
        button.textAlignment = "center"
    else
        button.textAlignment = textAlignment
    end

    button.sfxClick = love.audio.newSource("assets/audio/sfx/minecraft_buttonClick.mp3", "static")       -- Button click sound effect is set     (Minecraft Button Click Sfx https://www.youtube.com/watch?v=rG-856TmuzA)
    button.sfxClick:setVolume(0.50)                                                             -- Button click sound effect volume is set to half
    button.sfxClick:setLooping(false)                                                           -- Button click sound effect is set to not loop

    if (fontSize == nil) then
        button.fontSize = 60                                                                      -- Button text font size
    else
        button.fontSize = fontSize
    end
    
    button.font = love.graphics.newFont("assets/fonts/showcard_gothic.ttf", button.fontSize)    -- Button text font is set
    button.fonts = {}                                                                           -- Button font list is created

    button.active = true                                                                        -- Button is set to be active

    -- This code is to be initialized manually by whoever creates the button, as this code will execute code to achieve whatever the button's unique purpose is
    function button.performAction(button, mouseX, mouseY)

    end

    -- Plays the Button click sound effect and calls for the Button's action to be performed whenever the Button is pressed
    function button.isPressed(button, mouseX, mouseY)
        love.audio.play(button.sfxClick)
        button:performAction(mouseX, mouseY)
    end

    -- Checks if the mouse is hovering over the Button and potentially alters the Button's color
    function button.mouseHovering(button)
        if (isMouseHovering(button)) then
            button.currentBackgroundColor = button.backgroundHoverColor
            button.currentTextColor = button.textHoverColor
        else
            button.currentBackgroundColor = button.backgroundColor
            button.currentTextColor = button.textColor
        end
    end

    function button.update(button, dt)
        if (button.active) then
            button:mouseHovering()
        end
    end

    -- Draws the Button on the screen.
    function button.draw(button)
        if (button.active) then
            local previousColor = getCurrentColor()
            love.graphics.setColor(button.currentBackgroundColor)
            love.graphics.rectangle("fill", x, y, width, height)

            love.graphics.setColor(button.currentTextColor)
            love.graphics.printf(button.text, button.font, button.x, (button.y + (button.height / 2)) - (button.fontSize * 0.4), button.width, button.textAlignment)
        end
    end

    return button
end

return buttonHandler