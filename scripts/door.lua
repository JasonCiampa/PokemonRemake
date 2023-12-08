local doorHandler = {}

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- OBJECTHANDLER CREATE FUNCTION --

function doorHandler.create(name, x, y, width, height)
    local door = {}

    door = {}
    door.name = name
    door.x = x
    door.y = y
    door.width = width
    door.height = height
    door.halfWidth = door.width / 2
    door.halfHeight = door.height / 2
    door.leftEdge = door.x
    door.rightEdge = door.x + door.width
    door.isOpen = false
    door.openSFX = love.audio.newSource("assets/audio/sfx/minecraft_doorOpen.mp3", "static")   -- https://www.youtube.com/watch?v=LZbqJbs7evs
    door.openSFX:setVolume(0.50)
    door.openSFX:setLooping(false)

    function door.open(door)
        if (((player.x >= door.leftEdge) and (player.x <= door.rightEdge))) and ((player.y >= door.y) and (player.y <= door.y + door.height)) then
            door.isOpen = true
            love.audio.play(door.openSFX)
            return
        end

        door.isOpen = false
    end

    function door.update(door, building, dt)
        if (building.currentAnimation.currentFrameNum == 4) then
            building.currentAnimation.updatable = false

        elseif (building.currentAnimation == building.animations.idle) then
            building.currentAnimation = building.animations.openDoor
        end

        building.currentAnimation.update(dt)
    end


    return door
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

return doorHandler