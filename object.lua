local objectHandler = {}

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- OBJECTHANDLER CREATE FUNCTION --

function objectHandler.create(name, objectX, objectY, objectWidth, objectHeight, splitPoint, spritesheet, duplicate)

    -- OBJECT SETUP --

    local object = {}

    object.color = {1, 1, 1, 1}                                                                                                                 -- Stores the color for the Object
    object.name = name                                                                                                                          -- Stores the name of the Object
    object.spritesheet = spritesheet                                                                                                            -- Stores the Object's spritesheet
    object.animations = {}                                                                                                                      -- A list to hold Animations that will be created for the Object
    object.currentAnimation = {}                                                                                                                -- Set the currently active Animation to be an empty table
    object.splitPoint = splitPoint                                                                                                              -- Stores the point at which the object should be split into top and bottom portions
    object.width = objectWidth                                                                                                                  -- Sets the Object's width
    object.height = objectHeight                                                                                                                -- Sets the Object's height
    object.halfWidth = object.width / 2                                                                                                         -- Stores half of the Object's width
    object.halfHeight = object.height / 2                                                                                                       -- Stores half of the Object's height
    object.x = objectX                                                                                                                          -- Refers to the top left corner of the Object
    object.y = objectY                                                                                                                          -- Refers to the top left corner of the Object
    object.duplicate = (duplicate or false)                                                                                                     -- Stores whether or not an object is a duplicate

    --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    -- OBJECT FUNCTIONS --

    function object.createHitbox(object, hitboxX, hitboxY, hitboxWidth, hitboxHeight)
        -- USE GIMP XCF OF OBJECT TO DETERMINE HITBOX PROPERTIES
        object.physics.hitbox = {}                                                                                                                          -- Creates an empty table to store all of the Object's Hitbox information
        object.physics.hitbox.width = hitboxWidth                                                                                                           -- Stores the hitbox width
        object.physics.hitbox.height = hitboxHeight                                                                                                         -- Stores the hitbox height
    
        object.physics.hitbox.halfWidth = object.physics.hitbox.width  / 2                                                                                          -- Stores half of the hitbox's width
        object.physics.hitbox.halfHeight = object.physics.hitbox.height / 2                                                                                         -- Stores half of the hitbox's height
    
        object.physics.hitbox.x = (hitboxX + (object.physics.hitbox.halfWidth))                                                                -- Refers to the center of the hitbox
        object.physics.hitbox.y = (hitboxY + (object.physics.hitbox.halfHeight))                                                           -- Refers to the center of the hitbox
    
        object.physics.hitbox.offsetX = (object.physics.hitbox.x + object.physics.hitbox.halfWidth) - (object.x + object.halfWidth / 2)                                                       -- Stores how much the hitbox is offset from the center of the physics body
        object.physics.hitbox.offsetY = (object.physics.hitbox.y + object.physics.hitbox.halfHeight) - (object.y + object.halfHeight)                                                     -- Stores how much the hitbox y-coordinate should be offset based 
    
        object.physics.shape = love.physics.newRectangleShape(object.physics.hitbox.offsetX, object.physics.hitbox.offsetY, object.physics.hitbox.width, object.physics.hitbox.height)      -- Creates a new physics shape (hitbox) for the Object
        object.physics.fixture = love.physics.newFixture(object.physics.body, object.physics.shape, object.physics.density)                                                         -- Creates a new physics fixture for the Object
        object.physics.fixture:setUserData(object.name)                                                                                                     -- Sets the Object's fixture's userdata to equal to the name of the Object
        object.physics.fixture:setRestitution(object.physics.restitution)                                                                                           -- Sets the Object's restitution
    end

    -- Makes an object into a physics object
    function object.physicsify(object, physicsType, density, restitution, hitboxX, hitboxY, hitboxWidth, hitboxHeight)
        object.physics = {}
        object.physics.x = object.x + object.halfWidth                                                                                         -- Refers to the center of the Object
        object.physics.y = object.y + object.halfHeight                                                                                        -- Refers to the center of the Object

        object.physics.type = physicsType                                                                                                      -- Stores the physics type of the Object
        object.physics.density = density                                                                                                                    -- Stores the density value for the Object's physics body
        object.physics.restitution = restitution                                                                                                            -- Stores the resitution value for the Object's physics fixture

        object.physics.body = love.physics.newBody(world, object.physics.centerX, object.physics.centerY, object.physics.type)                                      -- Creates a physics body for the Object (center registration point)
        object.physics.body:setFixedRotation(true)
       
        object.physics.hitbox = object:createHitbox(hitboxX, hitboxY, hitboxWidth, hitboxHeight)
    end

    -- Creates and returns a new Animation for the Object
    function object.createAnimation(frameCount, row, col, speed)
        return animator.create(object.spritesheet, frameCount, object.width, object.height, row, col, object.splitPoint, speed)  
    end

    -- Sets all of the object's animations to be updatable
    function object.resetAnimation()
        for animations, animation in pairs(object.animations) do
            animation.updatable = true                                          -- Sets each animation to be updatable
        end
    end

    -- Sets the position for the Object to be drawn in (either above or underneath the player)
    function object.setDrawPosition(object)
        -- The logic for this code may vary for each object, so it should be defined manually
    end

    -- Updates the Object's state
    function object.customUpdate(object, dt)
        -- This code should be defined in instances where an object needs further updating that what is provided in the default object.update() method.
    end

    -- Updates the Object's state
    function object.update(object, dt)
        if (object.physics ~= nil) then
            object.physics.x = object.physics.body:getX()                                                                                                     -- Updates the Object's centerX value to be the value of the body's x-coordinate
            object.physics.y = object.physics.body:getY()                                                                                                     -- Updates the Object's centerY value to be the value of the body's y-coordinate
            object.x = object.physics.x - object.halfWidth                                                                                     -- Updates the Object's top left corner value by subtracting away from the center
            object.y = object.physics.y - object.halfHeight                                                                                    -- Updates the Object's top left corner value by subtracting away from the center
        end

        object:setDrawPosition()                                                                                                                -- Updates the Object's draw position (above or below the player)
        object.resetAnimation()
        object:customUpdate(dt)
    end

    -- Draw the state of the top half of the Object
    function object.drawTopHalf(object)
        object.currentAnimation:drawTopHalf(object.topLeftX, object.topLeftY)
        -- -- DEBUGGING LINES --
        -- love.graphics.setColor(object.color)
        -- love.graphics.rectangle("line", object.topLeftX, object.topLeftY, object.width, object.height)                                          -- Draws a white line around the entire Object      
        -- love.graphics.setColor(1, 0, 0, 1)                                                                                                      -- Sets the color back to default white
        -- love.graphics.rectangle("line", (object.hitbox.topLeftX), (object.hitbox.topLeftY), object.hitbox.width, object.hitbox.height)          -- Draws a red line around the entire hitbox
        -- love.graphics.setColor(1, 1, 1, 1)                                                                                                      -- Sets the color back to default white
    end

    -- Draw the state of the bottom half of the Object
    function object.drawBottomHalf(object)
        object.currentAnimation:drawBottomHalf(object.topLeftX, object.topLeftY)
    end

    -- Draws the Object's state
    function object.draw(object)
        love.graphics.setColor(object.color)                                                                                                    -- Sets the drawing color to the Object's color
        object.currentAnimation.draw(object.topLeftX, object.topLeftY)                                                                          -- Draws the currently active Animation
        love.graphics.setColor(1, 1, 1, 1)                                                                                                      -- Sets the color back to default white
    end

    -- Produces a duplicate of the Object
    function object.duplicate(object, newX, newY, newHitboxX, newHitboxY)
        -- This code should be defined manually for each Object since there are certain functions/values that might need to be added to a duplicate manually
    end

    return object
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- OBJECTHANDLER DUPLICATE FUNCTION --

-- Creates and returns an Object with the same duplicated fields as another Object (duplicated Object receives a new x and y position and new hitbox position, but doesn't receive functions)
function objectHandler.duplicate(object, newX, newY, newHitboxX, newHitboxY)

    if (newHitboxX == nil and newHitboxY == nil) then
        newHitboxX = object.hitbox.topLeftX + (newX - object.topLeftX) 
        newHitboxY = object.hitbox.topLeftY + (newY - object.topLeftY)
    end

    return object.create(object.name, newX, newY, object.width, object.height, object.splitPoint, object.spritesheet, newHitboxX, newHitboxY, object.hitbox.width, object.hitbox.height, object.physicsType, object.density, object.restitution)
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- OBJECT WORLD AND PHYSICS --

-- CALLBACKS CURRENTLY ARE ONLY BEING USED FOR DEBUGGING --
function beginContact(a, b, coll)
    if (a:getUserData() == "player" or b:getUserData()) then
        player.color = {1, 0, 0, 1}
        printDebug = true
        printDebugText = (a:getUserData() .. " is colliding with " .. b:getUserData())
    end
end 

function endContact(a, b, coll)
    if (a:getUserData() == "player" or b:getUserData()) then
        player.color = {1, 1, 1, 1}
        printDebug = true
        printDebugText = ""
    end
end

world = love.physics.newWorld(0, 0, true)
world:setCallbacks(beginContact, endContact, preSolve, postSolve)

return objectHandler
