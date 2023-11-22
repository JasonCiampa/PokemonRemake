local physicsHandler = {}

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
        printDebug = false
        printDebugText = ""
    end
end

world = love.physics.newWorld(0, 0, true)
world:setCallbacks(beginContact, endContact, preSolve, postSolve)

function physicsHandler.create(name, objectX, objectY, objectWidth, objectHeight, splitPoint, spritesheet, hitboxX, hitboxY, hitboxWidth, hitboxHeight, physicsType, density, restitution)

    -- OBJECT SETUP --

    local object = {}

    object.physicsType = physicsType                                                                                                            -- Stores the physics type of the Object
    object.restitution = restitution                                                                                                            -- Stores the resitution value for the Object's physics fixture
    object.density = density                                                                                                                    -- Stores the density value for the Object's physics body

    object.color = {1, 1, 1, 1}                                                                                                                 -- Stores the color for the Object

    object.name = name                                                                                                                          -- Stores the name of the Object

    object.spritesheet = spritesheet                                                                                                            -- Stores the Object's spritesheet
    object.animations = {}                                                                                                                      -- A list to hold Animations that will be created for the Object
    object.currentAnimation = {}                                                                                                                -- Set the currently active Animation to be an empty table
    object.splitPoint = splitPoint

    object.width = objectWidth                                                                                                                  -- Sets the Object's width
    object.height = objectHeight                                                                                                                -- Sets the Object's height
    object.halfWidth = object.width / 2                                                                                                         -- Stores half of the Object's width
    object.halfHeight = object.height / 2                                                                                                       -- Stores half of the Object's height
    object.topLeftX = objectX                                                                                                                   -- Refers to the top left corner of the Object
    object.topLeftY = objectY                                                                                                                   -- Refers to the top left corner of the Object
    object.centerX = object.topLeftX + object.halfWidth                                                                                         -- Refers to the center of the Object
    object.centerY = object.topLeftY + object.halfHeight                                                                                        -- Refers to the center of the Object

    object.body = love.physics.newBody(world, object.centerX, object.centerY, physicsType)                                                      -- Creates a physics body for the Object (center registration point)
    object.body:setFixedRotation(true)

    -- USE GIMP XCF OF OBJECT TO DETERMINE HITBOX PROPERTIES
    object.hitbox = {}                                                                                                                          -- Creates an empty table to store all of the Object's Hitbox information
    object.hitbox.width = hitboxWidth                                                                                                           -- Stores the hitbox width
    object.hitbox.height = hitboxHeight                                                                                                         -- Stores the hitbox height

    object.hitbox.halfWidth = hitboxWidth  / 2                                                                                                  -- Stores half of the hitbox's width
    object.hitbox.halfHeight = hitboxHeight / 2                                                                                                 -- Stores half of the hitbox's height

    object.hitbox.topLeftX = hitboxX                                                                                                            -- Refers to the top left corner of the hitbox
    object.hitbox.topLeftY = hitboxY                                                                                                            -- Refers to the top left corner of the hitbox

    object.hitbox.centerX = (hitboxX + (hitboxWidth / 2))                                                                                       -- Refers to the center of the hitbox
    object.hitbox.centerY = (hitboxY + (hitboxHeight / 2))                                                                                      -- Refers to the center of the hitbox

    object.hitbox.offsetX = (hitboxX + (hitboxWidth / 2)) - (objectX + (objectWidth / 2))                                                       -- Stores how much the hitbox 
    object.hitbox.offsetY = (hitboxY + (hitboxHeight / 2)) - (objectY + (objectHeight / 2))                                                     -- Stores how much the hitbox y-coordinate should be offset based 

    object.shape = love.physics.newRectangleShape(object.hitbox.offsetX, object.hitbox.offsetY, object.hitbox.width, object.hitbox.height)      -- Creates a new physics shape (hitbox) for the Object
    object.fixture = love.physics.newFixture(object.body, object.shape, object.density)                                                         -- Creates a new physics fixture for the Object
    object.fixture:setUserData(object.name)                                                                                                     -- Sets the Object's fixture's userdata to equal to the name of the Object
    object.fixture:setRestitution(object.restitution)                                                                                           -- Sets the Object's restitution

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
        object.centerX = object.body:getX()                                                                                                     -- Updates the Object's centerX value to be the value of the body's x-coordinate
        object.centerY = object.body:getY()                                                                                                     -- Updates the Object's centerY value to be the value of the body's y-coordinate
        object.topLeftX = object.centerX - object.halfWidth                                                                                     -- Updates the Object's top left corner value by subtracting away from the center
        object.topLeftY = object.centerY - object.halfHeight                                                                                    -- Updates the Object's top left corner value by subtracting away from the center
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
        -- -- DEBUGGING LINES --
        -- love.graphics.setColor(object.color)
        -- love.graphics.rectangle("line", object.topLeftX, object.topLeftY, object.width, object.height)                                          -- Draws a white line around the entire Object      
        -- love.graphics.setColor(1, 0, 0, 1)                                                                                                      -- Sets the color back to default white
        -- love.graphics.rectangle("line", (object.hitbox.topLeftX), (object.hitbox.topLeftY), object.hitbox.width, object.hitbox.height)          -- Draws a red line around the entire hitbox
        -- love.graphics.setColor(1, 1, 1, 1)                                                                                                      -- Sets the color back to default white
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

-- Creates and returns an Object with the same duplicated fields as another Object (duplicated Object receives a new x and y position and new hitbox position, but doesn't receive functions)
function physicsHandler.duplicate(object, newX, newY, newHitboxX, newHitboxY)

    if (newHitboxX == nil and newHitboxY == nil) then
        newHitboxX = object.hitbox.topLeftX + (newX - object.topLeftX) 
        newHitboxY = object.hitbox.topLeftY + (newY - object.topLeftY)
    end

    return physicsHandler.create(object.name, newX, newY, object.width, object.height, object.splitPoint, object.spritesheet, newHitboxX, newHitboxY, object.hitbox.width, object.hitbox.height, object.physicsType, object.density, object.restitution)
end

return physicsHandler
