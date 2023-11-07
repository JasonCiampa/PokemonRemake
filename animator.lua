local animator = {}
-- pathToFile: the path to the file (ending just before the image name, because that is the next argument) (String)
-- animationName: the name of the animation images , like "jump" or "idle" (String)
-- fileType: the file type of the animation images, like ".png" or ".jpg" (String)
-- frameCount: the number of animation images to turn into an animation (Int)
function animator.makeAnimation(pathToFile, animationName, fileType, frameCount)
    local animation = {}
    animation.name = animationName
    animation.frames = {}
    animation.currentFrame = 1
    animation.totalFrames = frameCount
    animation.speed = 1

    for i = 1, frameCount do
        table.insert(animation.frames, love.graphics.newImage(pathToFile.. animationName .. i .. fileType))
    end

    -- animationSpeed: how fast the animation should go, so 1, 2, or 3 would speed it up by 1x, 2x, or 3x (int)
    function animation.play(dt, animationSpeed)
        animation.currentFrame = animation.currentFrame + dt
        animation.currentFrame = animation.currentFrame + (dt * animation.speed) -- Multiplying dt by a value will increase or decrease speed of the animation

        if (animation.currentFrame >= animation.totalFrames) then
            animation.currentFrame = 1
        end
    end

    -- object: the object that the animation belongs to
    function animation.draw(object)
        love.graphics.draw(animation.frames[math.floor(animation.currentFrame)], object.x - object.width / 2, object.y - object.height / 2)
    end

    return animation
end

return animator















