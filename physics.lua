local physicsHandler = {}

function physicsHandler.addObject(name, width, height, x, y, physicsType, density, restitution)
        local object = {}

        object.name = name
        object.animations = {}
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


        function object.createAnimation(pathToFile, fileType, frameCount, speed)
            return animator.create(pathToFile, fileType, frameCount, speed)  
        end

        function object.update(dt)
            object.x = object.body:getX()
            object.y = object.body:getY()
        end

        function object.draw()
            love.graphics.draw(object.image, object.body:getX(), object.body:getY(), object.body:getAngle(), 1, 1, objectImage:getWidth(), objectImage:getHeight())
        end
        

        return object
end

-- FOR REFERENCE --
physicsHandler.addObject("player", 120, 160, 0, 0, "dynamic", 1, 1, 0)


return physicsHandler

-- FOR PLAYER:
-- objects.ball.body:setFixedRotation(true)
