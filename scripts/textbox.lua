local textboxHandler = {}

function textboxHandler.create(startingText)
    local textbox = {}

    textbox.width = 1920                                                                                                                    -- Sets the width of the textbox
    textbox.height = 248                                                                                                                    -- Sets the height of the textbox
    textbox.x = 7                                                                                                                           -- Sets the x-coordinate of the textbox
    textbox.y = 1080                                                                                                                        -- Sets the y-coordinate of the textbox
    textbox.dx = 0                                                                                                                          -- Sets the dx value of the textbox
    textbox.dy = 800                                                                                                                        -- Sets the dy value of the textbox

    textbox.spritesheet = love.graphics.newImage("assets/images/textbox/textbox_spritesheet.png")                                           -- Loads in the textbox spritesheet
    textbox.animations = {}                                                                                                                 -- Creates a table to store the textbox animations
    textbox.animations.idle = animator.create(textbox.spritesheet, 1, textbox.width, textbox.height, 8, 1, 1, 124, 1)                       -- Creates an idle animation
    textbox.animations.blinking = animator.create(textbox.spritesheet, 2, textbox.width, textbox.height, 8, 1, 1, 124, 1.25)                -- Creates a blinking animation
    textbox.currentAnimation = textbox.animations.blinking                                                                                  -- Sets the current animation to the blinking animation
    textbox.text = startingText                                                                                                             -- Sets the text to the starting text that was passed in
    textbox.textBuilder = ""                                                                                                                -- Stores each character of the textbox.text one by one each update
    textbox.characterDelay = 0.025                                                                                                           -- Delays each character's addition to textbox.textBuilder by the set amount 
    textbox.characterDelayTimer = textbox.characterDelay                                                                                    -- Timer to update characterDelay


    textbox.active = false                                                                                                                  -- Sets the textbox to be inactive                                                                  
    textbox.movingDown = false                                                                                                              -- Sets the textbox to be not moving down
    textbox.movingUp = false                                                                                                                -- Sets the textbox to be not moving up
    textbox.timeAlive = 0                                                                                                                   -- Sets the textbox's amount of time spent alive

    --=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--

    -- FUNCTIONS --

    -- Sets the text for the textbox
    function textbox.setText(newText)
        textbox.text = newText
        textbox.textBuilder = ""
    end

    -- Displays the textbox on the screen and triggers a timer for how long its been alive for
    function textbox.display()
        textbox.active = true
        textbox.movingUp = true
    end

    -- Hides the textbox from the screen
    function textbox.hide()
        textbox.movingDown = true
    end

    -- Returns how long the textbox has been alive for
    function textbox.getLifeSpan()
        return textbox.timeAlive
    end

    -- Checks if the textbox is supposed to be moving and makes necessary position updates
    function textbox.move(dt)
        if (textbox.movingDown) then                                                                                                        -- If the textbox is currently moving down...                                                                           
            if (textbox.y < 1080) then                                                                                                          -- If the textbox's y-coordinate is less than 1080...
                textbox.y = textbox.y + (textbox.dy * dt)                                                                                           -- Shift the textbox down further
            else                                                                                                                                -- Otherwise...
                textbox.y = 1080                                                                                                                    -- Set the textbox's y-coordinate to 1080                    
                textbox.movingDown = false                                                                                                          -- Set the textbox's moving down status to false
                textbox.active = false                                                                                                              -- Set the textbox's active status to false
            end 
        elseif (textbox.movingUp) then                                                                                                      -- Otherwise, if the textbox is currently moving up...            
            if (textbox.y > 825) then                                                                                                           -- If the textbox's y-coordinate is greater than 825...
                textbox.y = textbox.y - (textbox.dy * dt)                                                                                           -- Shift the textbox up further
            else                                                                                                                                -- Otherwise...
                textbox.y = 825                                                                                                                     -- Set the textbox's y-coordinate to 825
                textbox.movingUp = false                                                                                                            -- Set the textbox's moving up status to false
            end
        end
    end

    --=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--

    -- STATE HANDLING FUNCTIONS --

    function textbox.update(thisTextbox, dt)
        for animations, animation in pairs(thisTextbox.animations) do                                                                       -- For all of the textbox's animations...
            animation.updatable = true                                                                                                          -- Set the animation to be updatable
        end



        if (thisTextbox.active) then                                                                                                            -- If the textbox is currently active...                                   
            thisTextbox.timeAlive = thisTextbox.timeAlive + dt                                                                                          -- Increment the textbox's time alive counter by dt
            thisTextbox.currentAnimation.update(dt)                                                                                             -- Update the textbox's animation       
            thisTextbox.move(dt)                                                                                                                -- Handle the textbox's movement
        else                                                                                                                                -- Otherwise...
            thisTextbox.timeAlive = 0                                                                                                               -- Set the textbox's time alive counter to 0 (since it is not alive)
        end

        if (string.len(thisTextbox.textBuilder) ~= string.len(thisTextbox.text)) then
            if (thisTextbox.characterDelayTimer < 0) then
                textbox.textBuilder = thisTextbox.text:sub(1, string.len(thisTextbox.textBuilder) + 1)
                thisTextbox.characterDelayTimer = thisTextbox.characterDelay
            else
                thisTextbox.characterDelayTimer = thisTextbox.characterDelayTimer - dt
            end
        end

    end

    function textbox.draw(thisTextbox)
        if (thisTextbox.active) then                                                                                                        -- If the textbox is currently active...
            thisTextbox.currentAnimation:draw(textbox.x, textbox.y)                                                                             -- Draw the textbox's current animation
            love.graphics.setColor(0.1, 0.1, 0.1)                                                                                               -- Set the color to a dark gray
            love.graphics.printf(thisTextbox.textBuilder, font, thisTextbox.x + 50, thisTextbox.y + 50, thisTextbox.width - 100, "left")               -- Print the text onto the text box            
        end
    end

    --=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--

    return textbox
end

--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--

return textboxHandler