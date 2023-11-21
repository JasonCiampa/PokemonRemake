local animator = {}

-- Creates an Animation
function animator.create(spritesheet, frameCount, width, height, row, col, speed)
    -- spritesheet: Object's spritesheet
    -- frameCount: the number of frames to turn into an animation (Number)
    -- width: width of each frame
    -- height: height of each frame
    -- row: the row number in the spritesheet for the first frame to animate
    -- col: the column number in the spritesheet for the first frame to animate
    -- speed: multiplier for the fps value (0.5 = half of fps, 1 = same fps, 2 = double the fps, 3 = triple the fps, etc.)


    --parallel lists
    local animation = {}

    animation.spritesheet = spritesheet
    animation.frames = {}                                                                   -- A list to hold all of the animation frames
    animation.totalFrames = frameCount                                                      -- Stores the total number of frames in the animation
    animation.speed = speed * animation.totalFrames                                         -- Calculates the animation speed in frames per second
    animation.frameLifetime = ((1 / animation.totalFrames) * speed)                         -- Calculates the lifetime for each individual frame
    animation.currentFrameNum = 1                                                           -- Stores the index of the currentFrame
    animation.currentFrameTime = 0                                                          -- Stores the amount of time a frame has been active for
    animation.updatable = false                                                             -- Determines if an animation can be played or not (typically starts as true at the start of a love.update() call and is modified to false once the animation.update() function has run once in the love.update() call)
    
    local y = ((row - 1) * height)
    local x = ((col - 1) * width)
    
    for i = x, (x + ((frameCount * width) - 1)), width do
        table.insert(animation.frames, love.graphics.newQuad(i, y, width, height, animation.spritesheet:getDimensions()))
    end

    -- Updates the Animation state if it's updatable state is true
    function animation.update(dt)
        if (animation.updatable) then
            animation.currentFrameTime = animation.currentFrameTime + (dt * animation.speed)            -- Increases the currentFrameTime by however much longer the currentFrame has lived for

            if(animation.currentFrameTime >= animation.frameLifetime) then                              -- If the current frame has been alive longer than the frame's lifetime is set to be...
                animation.currentFrameNum = animation.currentFrameNum + 1                                   -- Set the current frame to be the next frame in line
                animation.currentFrameTime = (animation.frameLifetime - animation.currentFrameTime)         -- Reset the current frame timer for the newly set current frame

                if (animation.currentFrameNum > animation.totalFrames) then                                 -- If our newly set current frame doesn't exist...
                    animation.currentFrameNum = 1                                                               -- Reset currentFrameNum to the first frame: 1
                end
            end

            animation.updatable = false             -- Animation has been updated, so animation.updatable is set to false until and is only set to true again when its time for another update
        end
    end

    -- Draws the currentFrame for the Animation
    function animation.draw(x, y, r, sx, ox, oy)
        love.graphics.draw(animation.spritesheet, animation.frames[animation.currentFrameNum], x, y, r, sx, sy, ox, oy)
    end

    return animation
end

return animator















