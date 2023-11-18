local physicsHandler = {}

love.physics.setMeter(64)
WORLD = love.physics.newWorld(0, 0, true)
WORLD:setCallbacks(beginContact, endContact, preSolve, postSolve)

-- local physicsHandler = require("physics")

function physicsHandler.addObject(name, width, height, x, y, physicsType, density, restitution, animations)
        local object = {}

        object.name = name

        if (animations ~= nil) then
            object.animations = animations
            object.currentAnimation = object.animations[1]
        else
            object.animations = {}
            object.currentAnimation = {}
        end


        object.width = width
        object.height = height
        object.x = x
        object.y = y
        object.restitution = restitution
        object.density = density

        object.body = love.physics.newBody(WORLD, object.x, object.y, physicsType)
        object.body:setFixedRotation(true)

        object.shape = love.physics.newRectangleShape(0, 0, object.width, object.height)
        object.fixture = love.physics.newFixture(object.body, object.shape, object.density)
        object.fixture:setUserData(object.name)
        object.fixture:setRestitution(object.restitution)

        object.tilemap = {}


        function object.createAnimation(pathToFile, fileType, frameCount, speed)
            return animator.create(pathToFile, fileType, frameCount, speed)  
        end

        function object.update(dt)
            object.x = object.body:getX()
            object.y = object.body:getY()
        end

        function object.draw()
            -- love.graphics.setColor(1, 1, 1, 0.3)
            object.currentAnimation.draw(object.x, object.y, object.body:getAngle())

            -- love.graphics.setColor(1, 1, 1, 1)
            -- love.graphics.rectangle("line", object.body:getX(), object.body:getY(), object.width, object.height)
        end
        
        return object
end

function beginContact(fixtureA, fixtureB, coll)
    -- if(fixtureA:getUserData() == "player") then 
    --     local playerFixture = fixtureA
    --     player.color = {1, 1, 1, 1}

    --     for i = 1, #activeScene.objects do
    --         if (activeScene.objects[i].fixture:getUserData() == fixtureB:getUserData()) then
    --             activeScene.objects[i].color = {1, 1, 1, 1}
    --         end
    --     end

    -- elseif (fixtureB:getUserData() == "player") then
    --     local playerFixture = fixtureB
    --     player.color = {1, 1, 1, 1}

    --     for i = 1, #activeScene.objects do
    --         if (activeScene.objects[i].fixture:getUserData() == fixtureA:getUserData()) then
    --             activeScene.objects[i].color = {1, 1, 1, 1}
    --         end
    --     end
    -- end

end 

function endContact(fixtureA, fixtureB, coll)
    -- if(fixtureA:getUserData() == "player") then 
    --     local playerFixture = fixtureA
    --     player.color = {1, 1, 1, 0.3}

    --     for i = 1, #activeScene.objects do
    --         if (activeScene.objects[i].fixture:getUserData() == fixtureB:getUserData()) then
    --             activeScene.objects[i].color = {1, 1, 1, 1}
    --         end
    --     end

    -- elseif (fixtureB:getUserData() == "player") then
    --     local playerFixture = fixtureB
    --     player.color = {1, 1, 1, 1}

    --     for i = 1, #activeScene.objects do
    --         if (activeScene.objects[i].fixture:getUserData() == fixtureA:getUserData()) then
    --             activeScene.objects[i].color = {1, 1, 1, 1}
    --         end
    --     end
    -- end

end

function preSolve(fixtureA, fixtureB, coll)
    
end

function postSolve(fixtureA, fixtureB, coll, normalimpulse, tangentimpulse)
  
end

return physicsHandler

-- FOR PLAYER:
-- objects.ball.body:setFixedRotation(true)
