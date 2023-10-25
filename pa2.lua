-- Screen dimensions
local WIDTH, HEIGHT = 1280, 720

--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

-- Scenes
local titleScreen = true
local titleScreenText = love.graphics.newImage("assets/images/splash_screen_title.png")
local titleScreenBackground = love.graphics.newImage("assets/images/graveyard/background/graveyard.jpg")

local gameOverScreen = false
local gameOverScreenImage = love.graphics.newImage("assets/images/game_over_screen.png")

local gameActive = false
local gameBackground1 = love.graphics.newImage("assets/images/graveyard/background/graveyard1.jpg")

--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

-- Timer (Score)
local timeAlive = 0
local ghostSpeedAdjusted = true     -- Used to help indicate that ghost speed has or hasn't already been adjusted after 10 seconds have passed.

--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

-- Font
local font = love.graphics.newFont("assets/fonts/showcard_gothic.ttf", 24)

--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

-- Audio
local backgroundMusic = love.audio.newSource("assets/audio/background_music.mp3", "stream") -- Ghostly Encounter - Paper Mario The Thousand-Year Door
backgroundMusic:setVolume(0.10)
backgroundMusic:setLooping(true)

local titleScreenMusic = love.audio.newSource("assets/audio/titlescreen_music.mp3", "stream")   -- Mansion (Exterior) - Luigi's Mansion
titleScreenMusic:setVolume(0.20)
titleScreenMusic:setLooping(true)

local evilLaugh = love.audio.newSource("assets/audio/evil_laugh.mp3", "stream")   -- Bowser laugh sound effect https://www.youtube.com/watch?v=h6wOR2bZhkg
evilLaugh:setVolume(0.20)
evilLaugh:setLooping(true)

--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

-- Raises a number to a power and gives the product
local function exponent(number, power)
    local product = number

    -- start at 2 since product is already set equal to the number so that would be the first iteration
    for i = 2, power do
        product = product * number
    end

    return product
end

--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

-- Gets the distance between two points
local function getDistance(object1X, object1Y, object2X, object2Y)
    return (math.sqrt(exponent(object2X - object1X, 2) + exponent(object2Y - object1Y, 2)))
end

--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

-- Graveyard
local function makeGraveyardAsset(pathToImage, x, y)
    local asset = {}
    asset.image = love.graphics.newImage(pathToImage)
    asset.width = asset.image:getWidth()
    asset.height = asset.image:getHeight()
    asset.x = x
    asset.y = y

    function asset.draw(asset) 
        love.graphics.draw(asset.image, asset.x, asset.y)
    end
    
    return asset
end

-- Checks the position of the background to see if it is about to be (or already is) fully offscreen. If true, the backgrounds shift
local function checkForBackgroundSwap()
    if (backgroundLeft.x <= (-WIDTH)) then
        local shiftDistance = (-WIDTH - backgroundLeft.x)
        local temp = backgroundLeft

        backgroundLeft = backgroundRight
        backgroundRight = temp

        backgroundLeft.x = 0
        backgroundLeft.y = 0

        backgroundRight.x = WIDTH
        backgroundRight.y = 0
    end
end

local function makeGhost()
    local ghost = {}
    ghost.radius = 25
    ghost.x = love.math.random((WIDTH + ghost.radius), (WIDTH + ghost.radius) + (WIDTH / 2))
    ghost.y = love.math.random(ghost.radius, HEIGHT - ghost.radius)
    ghost.color = {1, 1, 1, 0.8}
    ghost.speed = 150
    ghost.spawnDelay = 2

    -- Draws a ghost
    function ghost.draw()
        local prevColor = {love.graphics.getColor()}
        love.graphics.setColor(ghost.color)
        love.graphics.circle("fill", ghost.x, ghost.y, ghost.radius)
        love.graphics.setColor(prevColor)
    end

    -- Checks if the ghost is off screen. If it is, ghost's position is set to the right side of the window
    function ghost.handlePosition(ghost)
        -- Checks if the ghost is off of the left side of the screen
        if ((ghost.x + (ghost.radius * 2)) < 0) then
            ghost.x = love.math.random((WIDTH + ghost.radius), (WIDTH + ghost.radius) + (WIDTH / 2))
            ghost.y = love.math.random(ghost.radius, HEIGHT - ghost.radius)
        end
    end

    -- Moves the ghost left
    function ghost.floatLeft(dt)
        ghost.x = ghost.x - (ghost.speed * dt)
    end

    return ghost
end

--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

-- Player table 
local player = {}
player.width = 50
player.height = 50
player.x = 30
player.y = (HEIGHT/2) - (player.height / 2)
player.color = {0.5, 0.82, 0.82}
player.normalSpeed = 300
player.boostedSpeed = 400
player.currentSpeed = player.normalSpeed

-- Barriers
local topBarrier = 0
local bottomBarrier = (HEIGHT - player.height)
local leftBarrier = 0
local rightBarrier = (WIDTH/4)

-- Checks the player's position and adjusts them to stay in the boundaries of the barriers when necessary.
function player.handlePosition(dt)

    -- Movement Handler
    if love.keyboard.isDown("d") then
        player.x = player.x + (player.currentSpeed * dt)
    end

    if love.keyboard.isDown("a") then
        player.x = player.x - (player.currentSpeed * dt)
    end

    if love.keyboard.isDown("w") then
        player.y = player.y - (player.currentSpeed * dt)
    end

    if love.keyboard.isDown("s")  then
        player.y = player.y + (player.currentSpeed * dt)
    end

    -- Boundary Check and Position Correction
    -- Checks if the player is above the top of the screen
    if (player.y < topBarrier) then
        player.y = topBarrier

    end 

    -- Checks if the player is beneath the bottom of the screen
    if (player.y > bottomBarrier) then
        player.y = bottomBarrier
    end

    -- Checks if the player is off of the left side of the screen
    if (player.x < leftBarrier) then
        player.x = leftBarrier
    end

    -- Checks if player is to the right of the middle of the screen
    if (player.x > rightBarrier) then 

        local scrollDistance = (player.x - rightBarrier) * 0.4
        -- Scrolls the background to the left
        backgroundLeft.x = backgroundLeft.x - scrollDistance
        backgroundRight.x = backgroundRight.x  - scrollDistance
        
        -- Checks if backgrounds need to be swapped
        checkForBackgroundSwap()

        -- Keeps player in place, not moving further than the right barrier
        player.x = rightBarrier
    end
end

-- Detects if the player is touching a ghost, returns true or false.
function player.isTouchingGhost(player, ghost)
    -- Each statement checks if the distance from one of the player's corners to the ghost's's corner is less than the ghost's's width, and if so, they're touching

    -- Top Left Corner
    if (getDistance(player.x, player.y, ghost.x, ghost.y) < ghost.radius) then  
        return true

    -- Top Right Corner
    elseif (getDistance(player.x + player.width, player.y, ghost.x, ghost.y) < ghost.radius) then   
        return true

    -- Bottom Left Corner
    elseif (getDistance(player.x, player.y + player.height, ghost.x, ghost.y) < ghost.radius) then  
        return true

    --Bottom Right Corner
    elseif (getDistance(player.x + player.width, player.y + player.height, ghost.x, ghost.y) < ghost.radius) then   
        return true
    end
   
    return false
end

--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

-- Checks the timer and if the amount of time is a multiple of 10 (meaning 10 seconds has passed), ghost speed is increased 
local function checkTime(dt)
    timeAlive = timeAlive + dt
    if ((math.floor(timeAlive) % 10) == 0) then
        if (not ghostSpeedAdjusted) then        -- If the speed has already been adjusted, don't do it again until the next 10 seconds pass
            for i=1, #ghosts do
                ghosts[i].speed = ghosts[i].speed + 50
            end
        end
        ghostSpeedAdjusted = true
    else
        ghostSpeedAdjusted = false
    end
end

--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
local defaultColor
local graveyardBackground1
local graveyardBackground2

function love.load()
    love.window.setMode(WIDTH, HEIGHT)

    defaultColor = {love.graphics.getColor()}

    graveyardBackground1 = makeGraveyardAsset("assets/images/graveyard/background/graveyard1.jpg", 0, 0)
    graveyardBackground2 = makeGraveyardAsset("assets/images/graveyard/background/graveyard2.jpg", WIDTH, 0)

    backgroundLeft = graveyardBackground1
    backgroundRight = graveyardBackground2

    love.audio.stop()

    player.x = 100
    player.y = 100

    timeAlive = 0

    ghosts = {}
    for i = 1, 6 do
        table.insert(ghosts, makeGhost())
    end
end

--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

function love.update(dt)
    if(gameActive) then
        love.audio.stop(titleScreenMusic)
        love.audio.play(backgroundMusic)
        checkTime(dt)

        player.handlePosition(dt)

        for i=1, #ghosts do
            -- Moves ghosts leftward and resets them on the right when they go too far left
            ghosts[i].floatLeft(dt)
            ghosts[i]:handlePosition()

            -- Checks if ghosts have crossed into the player's area. If true, checks if ghosts are touching player. If true, the game ends.
            if (player:isTouchingGhost(ghosts[i])) then
                gameOver = true
                gameActive = false
            end
        end
    end

    if (titleScreen) then
        if (love.keyboard.isDown("space")) then
            titleScreen = false
            gameActive = true
            return
        end
    end

    if(gameOver) then
        if (love.keyboard.isDown("escape")) then
            titleScreen = true
            gameOver = false
            love.load()
            return
        end
    end
end

--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

function love.draw()
    if (gameActive or gameOver) then
        
        backgroundLeft:draw()
        backgroundRight:draw()

        love.graphics.setColor(player.color)
        love.graphics.rectangle("fill", player.x, player.y, player.width, player.height)
        love.graphics.setColor(defaultColor)

        for i = 1, #ghosts do 
            ghosts[i].draw()
        end

        love.graphics.print("Time Survived: " .. math.floor(timeAlive), font, 10, 10)
    end

    if (gameOver) then
        love.audio.stop(backgroundMusic)
        love.audio.play(evilLaugh)
        love.graphics.draw(gameOverScreenImage, ((WIDTH/2) - (gameOverScreenImage:getWidth() / 2)), (HEIGHT/2) - (gameOverScreenImage:getHeight() * 0.8))
    
    end

    if (titleScreen) then
        love.audio.play(titleScreenMusic)
        love.graphics.draw(titleScreenBackground)
        love.graphics.draw(titleScreenText, ((WIDTH/2) - (titleScreenText:getWidth() / 2)), (HEIGHT/2) - (titleScreenText:getHeight() * 0.8))
        return
    end
end

--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

-- background art from https://www.artstation.com/artwork/oA6eGW
