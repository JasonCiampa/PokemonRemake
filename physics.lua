local physicsHandler = {}

love.physics.setMeter(64)
WORLD = love.physics.newWorld(0, 0, true)
-- WORLD:setCallbacks(beginContact, endContact, preSolve, postSolve)

-- local physicsHandler = require("physics")

function physicsHandler.addObject(name, width, height, x, y, physicsType, density, restitution, animations)
        local object = {}

        object.name = name

        if (animations ~= nil) then
            object.animations = animations
        else
            object.animations = {}
        end

        object.currentAnimation = {}

        object.width = width
        object.height = height
        object.x = x
        object.y = y
        object.restitution = restitution
        object.density = density

        object.body = love.physics.newBody(WORLD, object.x, object.y, physicsType)
        object.shape = love.physics.newRectangleShape(object.width, object.height)
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
            object.currentAnimation.draw(object.x, object.y)
        end
        
        return object
end


return physicsHandler

-- FOR PLAYER:
-- objects.ball.body:setFixedRotation(true)
