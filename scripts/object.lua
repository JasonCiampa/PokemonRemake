local objectHandler = {}

-- CALLBACKS CURRENTLY ARE ONLY BEING USED FOR DEBUGGING --
function beginContact(a, b, coll)
    if (a:getUserData() == "player" or b:getUserData()) then
        player.color = {1, 0, 0, 1}
        printDebug = false
        printDebugText = (a:getUserData() .. " is colliding with " .. b:getUserData())
    end
end 

function endContact(a, b, coll)
    if (a:getUserData() == "player" or b:getUserData()) then
        player.color = {1, 1, 1, 1}
        printDebug = false
        printDebugText = ""
    end
end

-- function preSolve(fixtureA, fixtureB, coll)
    
-- end

-- function postSolve(fixtureA, fixtureB, coll, normalimpulse, tangentimpulse)
  
-- end

-- love.physics.setMeter(64)
world = love.physics.newWorld(0, 0, true)
world:setCallbacks(beginContact, endContact, preSolve, postSolve)
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- OBJECTHANDLER CREATE FUNCTION --

function objectHandler.create(name, objectX, objectY, objectWidth, objectHeight, splitPoint, spritesheet, hitboxX, hitboxY, hitboxWidth, hitboxHeight, physicsType, density, restitution)

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

    if (physicsType ~= nil) then
        object.physics = {}
        object.physics.x = object.x + object.halfWidth                                                                                         -- Refers to the center of the Object
        object.physics.y = object.y + object.halfHeight                                                                                        -- Refers to the center of the Object

        object.physics.type = physicsType                                                                                                      -- Stores the physics type of the Object
        object.physics.density = density                                                                                                                    -- Stores the density value for the Object's physics body
        object.physics.restitution = restitution                                                                                                            -- Stores the resitution value for the Object's physics fixture

        object.physics.body = love.physics.newBody(world, object.physics.x, object.physics.y, object.physics.type)                                      -- Creates a physics body for the Object (center registration point)
        object.physics.body:setFixedRotation(true)

        object.physics.hitbox = {}                                                                                                                          -- Creates an empty table to store all of the Object's Hitbox information
        object.physics.hitbox.width = hitboxWidth                                                                                                           -- Stores the hitbox width
        object.physics.hitbox.height = hitboxHeight                                                                                                         -- Stores the hitbox height

        object.physics.hitbox.halfWidth = hitboxWidth  / 2                                                                                          -- Stores half of the hitbox's width
        object.physics.hitbox.halfHeight = hitboxHeight / 2                                                                                         -- Stores half of the hitbox's height

        object.physics.hitbox.x = (hitboxX + (hitboxWidth  / 2))                                                                -- Refers to the center of the hitbox
        object.physics.hitbox.y = (hitboxY + (hitboxHeight / 2))                                                           -- Refers to the center of the hitbox

        object.physics.hitbox.offsetX = (hitboxX + hitboxWidth  / 2) - (object.x + object.halfWidth)                                                       -- Stores how much the hitbox is offset from the center of the physics body
        object.physics.hitbox.offsetY = (hitboxY + hitboxHeight / 2) - (object.y + object.halfHeight)                                                     -- Stores how much the hitbox y-coordinate should be offset based 

        object.physics.shape = love.physics.newRectangleShape((hitboxX + hitboxWidth  / 2) - (object.x + object.halfWidth), (hitboxY + hitboxHeight / 2) - (object.y + object.halfHeight), hitboxWidth, hitboxHeight)      -- Creates a new physics shape (hitbox) for the Object
        object.physics.fixture = love.physics.newFixture(object.physics.body, object.physics.shape, object.physics.density)                                                         -- Creates a new physics fixture for the Object
        object.physics.fixture:setUserData(object.name)                                                                                                     -- Sets the Object's fixture's userdata to equal to the name of the Object
        object.physics.fixture:setRestitution(object.physics.restitution)                                                                                           -- Sets the Object's restitution
    end

    --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    -- OBJECT FUNCTIONS --

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
    function object.drawTop(object)
        object.currentAnimation:drawTop(object.x, object.y)
    end

    -- Draw the state of the bottom half of the Object
    function object.drawBottom(object)
        object.currentAnimation:drawBottom(object.x, object.y)
    end

    -- Draws the Object's state
    function object.draw(object)
        object.currentAnimation.draw(object.x, object.y)                                                                          -- Draws the currently active Animation
    end

    -- Produces a duplicate of the Object
    function object.customDuplicate(object, duplicateObject)
        -- This code should be defined manually for each Object since there are certain functions/values that might need to be added to a duplicate manually
    end

    return object
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- OBJECTHANDLER DUPLICATE FUNCTION --

-- Creates and returns an Object with the same duplicated fields as another Object (duplicated Object receives a new x and y position and new hitbox position, but doesn't receive functions)
function objectHandler.duplicate(object, newX, newY, newHitboxX, newHitboxY)
    local duplicateObject = {}

    if (object.physics ~= nil) then
        if (newHitboxX == nil and newHitboxY == nil) then
            newHitboxX = object.physics.hitbox.x + (newX - object.x) 
            newHitboxY = object.physics.hitbox.y + (newY - object.y)
        end

        duplicateObject = objectHandler.create(object.name, newX, newY, object.width, object.height, object.splitPoint, object.spritesheet, newHitboxX, newHitboxY, object.physics.hitbox.width, object.physics.hitbox.height, object.physics.type, object.physics.density, object.physics.restitution)

    else
        duplicateObject = objectHandler.create(object.name, newX, newY, object.width, object.height, object.splitPoint, object.spritesheet)
    end

    duplicateObject.animations = object.animations
    duplicateObject.currentAnimation = object.currentAnimation
    duplicateObject.setDrawPosition = object.setDrawPosition

    object:customDuplicate(duplicateObject)

    return duplicateObject
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- OBJECT WORLD AND PHYSICS --



return objectHandler
