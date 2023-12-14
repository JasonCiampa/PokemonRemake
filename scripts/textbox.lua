local textboxHandler = {}

function textboxHandler.create(startingText)
    local textbox = {}

    textbox.animations = {}
    textbox.animations.idle = animator.create(love.graphics.newImage("assets/images/textbox/textbox_spritesheet.png"), 1, 1920, 248, 8, 1, 1, 124, 1)
    textbox.animations.blinking = animator.create(love.graphics.newImage("assets/images/textbox/textbox_spritesheet.png"), 2, 1920, 248, 8, 1, 1, 124, 1)
    textbox.currentAnimation = textbox.animations.idle

    textbox.x = 0
    textbox.y = 825

    textbox.text = startingText

    textbox.active = false;

    textbox.moveTimer = 0

    function textbox.setText(newText)
        textbox.text = newText
    end

    function textbox.display(activeStatus)
        textbox.active = true
        textbox.moveTimer = 1
    end

    function textbox.hide(activeStatus)
        textbox.active = false
        textbox.moveTimer = 1
    end

    function textbox.getLifeSpan()
        
    end

    function textbox.update(dt)
        if (textbox.moveTimer > 0) then
            if (textbox.y < 1080) then
            
            elseif (textbox.y) then

            end
        end
    end

    function textbox.draw()

    end


    return textbox
end