local animator = {}

-- Creates an Animation
function animator.create(pathToFile, fileType, frameCount, speed)
    -- pathToFile: the path to the file (ending just before the image number, for example: take the "assets/images/jump" as the file path out from "assets/images/jump1.png")) (String)
    -- fileType: the file type of the frames, like ".png" or ".jpg" (String)
    -- frameCount: the number of frames to turn into an animation (Number)
    -- speed: multiplier for the fps value (0.5 = half of fps, 1 = same fps, 2 = double the fps, 3 = triple the fps, etc.)


    --parallel lists
    local animation = {}

    animation.frames = {}                                                                   -- A list to hold all of the animation frames
    animation.totalFrames = frameCount                                                      -- Stores the total number of frames in the animation
    animation.speed = speed * animation.totalFrames                                         -- Calculates the animation speed in frames per second
    animation.frameLifetime = ((1 / animation.totalFrames) * speed)                         -- Calculates the lifetime for each individual frame
    animation.currentFrameNum = 1                                                           -- Stores the index of the currentFrame
    animation.currentFrameTime = 0                                                          -- Stores the amount of time a frame has been active for
    animation.updatable = false                                                             -- Determines if an animation can be played or not (typically starts as true at the start of a love.update() call and is modified to false once the animation.update() function has run once in the love.update() call)
    
    for i = 1, animation.totalFrames do                                                            -- For every frame...
        table.insert(animation.frames, love.graphics.newImage(pathToFile.. i .. fileType))              -- Insert the frame into the animation.frames table
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
        love.graphics.draw(animation.frames[animation.currentFrameNum], x, y, r, sx, sy, ox, oy)
    end

    return animation
end

return animator















