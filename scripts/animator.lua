local animator = {}

-- Creates an Animation
function animator.create(spritesheet, frameCount, width, height, scaleFactor, row, col, splitPoint, speed)

    -- ANIMATION FIELDS --

    local animation = {}                                                                                                                                    -- A table to store all of the Animations relevant information

    animation.frames_top = {}                                                                                                                               -- A list to hold the top halves of all of the Animation frames
    animation.frames_bottom = {}                                                                                                                            -- A list to hold the bottom halves of all of the Animation frames

    animation.spritesheet = spritesheet                                                                                                                     -- Spritesheet that the Animation is to be made from
    animation.totalFrames = frameCount                                                                                                                      -- Stores the total number of frames in the Animation
    animation.speed = speed * animation.totalFrames                                                                                                         -- Calculates the Animation speed in frames per second
    animation.frameLifetime = ((1 / animation.totalFrames) / speed)                                                                                         -- Calculates the lifetime for each individual frame
    animation.currentFrameNum = 1                                                                                                                           -- Stores the index of the currentFrame
    animation.currentFrameTime = 0                                                                                                                          -- Stores the amount of time a frame has been active for
    animation.updatable = false                                                                                                                             -- Determines if an Animation can be played or not (typically starts as true at the start of a love.update() call and is modified to false once the animation.update() function has run once in the love.update() call)
    width = (width / scaleFactor)
    height = (height / scaleFactor)
    splitPoint = (splitPoint / scaleFactor)
    ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    -- ANIMATION FRAME CREATION --

    -- y = 1
    local y = ((row - 1) * height) + ((row * 2) - 1)                                                                                                                   -- Stores the row number where the Animation frames will start being pulled from (this value will not change, animations in spritesheets will be contained to one row)
    
    -- x = 243
    local startX = ((col - 1) * width) + ((col * 2) - 1)                                                                                                             -- Stores the column number where the Animation frames will start being pulled from
 
    -- startX = 243
    for x = startX, (startX + ((frameCount * width))), width + 2 do                                                                                             -- For every Sprite from this starting position until the inputted number of sprites...
        table.insert(animation.frames_top, love.graphics.newQuad(x, y, width, splitPoint, animation.spritesheet:getDimensions()))                                -- Create the top half of the new frame/quad/sprite and add it to the animation.frames_top list (splitPoint is used as a dividing point between top and bottom half)
        table.insert(animation.frames_bottom, love.graphics.newQuad(x, y + splitPoint, width, height - splitPoint, animation.spritesheet:getDimensions()))    -- Create the bottom half of the new frame/quad/sprite and add it to the animation.frames_top list (splitPoint is used as a dividing point between top and bottom half)
    end

    ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    -- ANIMATION UPDATE FUNCTION --

    -- Updates the Animation state if it's updatable state is true
    function animation.update(dt)
        if (animation.updatable) then                                                                                                                       -- If the Animation is currently updatable...
            animation.currentFrameTime = animation.currentFrameTime + dt                                                                                        -- Increases the currentFrameTime by however much longer the currentFrame has lived for

            if(animation.currentFrameTime >= animation.frameLifetime) then                                                                                      -- If the current frame has been alive longer than the frame's lifetime is set to be...
                animation.currentFrameNum = animation.currentFrameNum + 1                                                                                           -- Set the current frame to be the next frame in line
                animation.currentFrameTime = (animation.currentFrameTime - animation.frameLifetime)                                                                 -- Reset the current frame timer for the newly set current frame

                if (animation.currentFrameNum > animation.totalFrames) then                                                                                         -- If our newly set current frame doesn't exist...
                    animation.currentFrameNum = 1                                                                                                                       -- Reset currentFrameNum to the first frame: 1
                end
            end

            animation.updatable = false                                                                                                                         -- Animation has been updated, so animation.updatable is set to false until and is only set to true again when its time for another update
        end
    end

    ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    
    -- ANIMATION DRAW FUNCTIONS --

    -- Draw the state of the top half of the Animation
    function animation.drawTop(animation, x, y, r, sx, sy, ox, oy)
        if (r == nil and sx == nil and sy == nil and ox == nil and oy == nil) then                                                                          -- If no values were passed in after x and y...
            r = 0                                                                                                                                               -- Set those values to their defaults
            sx = scaleFactor
            sy = scaleFactor
            ox = 0
            oy = 0
        end

        love.graphics.draw(animation.spritesheet, animation.frames_top[animation.currentFrameNum], x, y, r, sx, sy, ox, oy)                                 -- Draw the top half of the Animation
    end
    
    -- Draw the state of the bottom half of the Animation
    function animation.drawBottom(animation, x, y, r, sx, sy, ox, oy)
        if (r == nil and sx == nil and sy == nil and ox == nil and oy == nil) then                                                                          -- If no values were passed in after x and y...
            r = 0                                                                                                                                               -- Set those values to their defaults
            sx = scaleFactor
            sy = scaleFactor
            ox = 0
            oy = 0
        end

        love.graphics.draw(animation.spritesheet, animation.frames_bottom[animation.currentFrameNum], x, y, r, sx, sy, ox, oy -splitPoint)                  -- Draw the bottom half of the Animation
    end

    -- Draws the currentFrame for the Animation
    function animation.draw(animation, x, y, r, sx, sy, ox, oy)
        if (r == nil and sx == nil and sy == nil and ox == nil and oy == nil) then
            r = 0
            sx = scaleFactor
            sy = scaleFactor
            ox = 0
            oy = 0
        end

        love.graphics.draw(animation.spritesheet, animation.frames_bottom[animation.currentFrameNum], x, y, r, sx, sy, ox, oy -splitPoint)                  -- Draw the bottom half of the Animation
        love.graphics.draw(animation.spritesheet, animation.frames_top[animation.currentFrameNum], x, y, r, sx, sy, ox, oy)                                 -- Draw the top half of the Animation
    end

    return animation
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

return animator















