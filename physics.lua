local physicsHandler = {}

function beginContact(a, b, coll)
    local data = player.fixture:getUserData()
    if (data == a:getUserData() or data == b:getUserData()) then
        player.color = {1, 0, 0, 1}
        printDebug = true
    end
end 

function endContact(fixtureA, fixtureB, coll)
    for i = 1, #activeScene.objects do
        local data = activeScene.objects[i].fixture:getUserData()
        if (data == fixtureA:getUserData() or data == fixtureB:getUserData()) then
            player.color = {1, 1, 1, 1}
            printDebug = false
        end
    end
end

love.physics.setMeter(64)
world = love.physics.newWorld(0, 0, true)
world:setCallbacks(beginContact, endContact, preSolve, postSolve)

function physicsHandler.addObject(name, objectX, objectY, objectWidth, objectHeight, hitboxX, hitboxY, hitboxWidth, hitboxHeight, physicsType, density, restitution, animations)
        local object = {}
        object.restitution = restitution
        object.density = density

        object.color = {1, 1, 1, 1}

        object.name = name

        if (animations ~= nil) then
            object.animations = animations
            object.currentAnimation = object.animations[1]
        else
            object.animations = {}
            object.currentAnimation = {}
        end

        object.width = objectWidth
        object.height = objectHeight
        object.halfWidth = object.width / 2
        object.halfHeight = object.height / 2

        object.topLeftX = objectX                        -- Refers to the top left corner of the body
        object.topLeftY = objectY                        -- Refers to the top left corner of the body

        object.centerX = object.topLeftX + object.halfWidth      -- Refers to the center of the body
        object.centerY = object.topLeftY + object.halfHeight     -- Refers to the center of the body

        object.body = love.physics.newBody(world, object.centerX, object.centerY, physicsType)       -- Sets the body to be positioned top-left instead of center
        object.body:setFixedRotation(true)

        object.hitbox = {}
        object.hitbox.width = hitboxWidth
        object.hitbox.height = hitboxHeight
        object.hitbox.offsetX = (hitboxX + (hitboxWidth / 2)) - (objectX + (objectWidth / 2))
        object.hitbox.offsetY = (hitboxY + (hitboxHeight / 2)) - (objectY + (objectHeight / 2))

        object.shape = love.physics.newRectangleShape(object.hitbox.offsetX, object.hitbox.offsetY, object.hitbox.width, object.hitbox.height)
        object.fixture = love.physics.newFixture(object.body, object.shape, object.density)
        object.fixture:setUserData(object.name)
        object.fixture:setRestitution(object.restitution)

        object.tilemap = {}

        function object.createAnimation(pathToFile, fileType, frameCount, speed)
            return animator.create(pathToFile, fileType, frameCount, speed)  
        end

        -- Sets the position for the object to be drawn in (either above or underneath the player)
        function object.setDrawPosition()
            -- The logic for this code may vary for each object, so it should be defined manually
        end

        function object.update(dt)
            object.centerX = object.body:getX()
            object.centerY = object.body:getY()

            object.topLeftX = object.centerX - object.halfWidth
            object.topLeftY = object.centerY - object.halfHeight

            object.setDrawPosition()
        end

        function object.draw()
            love.graphics.setColor(object.color)
            
            object.currentAnimation.draw(object.topLeftX, object.topLeftY)

            love.graphics.setColor(1, 1, 1, 1)
            -- love.graphics.rectangle("line", object.topLeftX, object.topLeftY, object.width, object.height)
            -- love.graphics.line(2532, 647, 3275, 647)
            -- love.graphics.rectangle("line", (object.hitbox.topLeftX), (object.hitbox.topLeftY), object.hitbox.width, object.hitbox.height)
        end

        return object
end


function preSolve(fixtureA, fixtureB, coll)
    
end

function postSolve(fixtureA, fixtureB, coll, normalimpulse, tangentimpulse)
  
end

return physicsHandler
