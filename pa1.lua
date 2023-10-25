WIDTH, HEIGHT = 1280, 720
local rooms = {}
local currentRoom = {}

-- Makes a key object/table.
local key = {}
key.image = love.graphics.newImage("assets/images/key.png")
key.scale = 0.25
key.width = key.image:getWidth() * key.scale
key.height = key.image:getHeight() * key.scale
key.x = (WIDTH / 2) - ((key.width) / 2)
key.y = (HEIGHT / 2) - ((key.height) / 2)
key.rotation = 0

-- Makes a lock object/table
local lock = {}
lock.image = love.graphics.newImage("assets/images/lock.png")
lock.scale = 0.08
lock.width = lock.image:getWidth() * lock.scale
lock.height = lock.image:getHeight() * lock.scale

-- Makes image variables.
local treasureImage = love.graphics.newImage("assets/images/treasure.png")
local winImage = love.graphics.newImage("assets/images/win.png")
local loseImage = love.graphics.newImage("assets/images/lose.png")

-- Makes audio variables
local backgroundAudio = love.audio.newSource("assets/audio/background.mp3", "stream")
backgroundAudio:setVolume(0.25)
backgroundAudio:setLooping(true)

local winAudio = love.audio.newSource("assets/audio/win.mp3", "stream")
winAudio:setVolume(0.35)
winAudio:setLooping(true)

local loseAudio = love.audio.newSource("assets/audio/lose.mp3", "stream")
loseAudio:setVolume(0.20)
loseAudio:setLooping(true)

local unlockAudio = love.audio.newSource("assets/audio/unlock.mp3", "static")
unlockAudio:setVolume(1)

local keyPickupAudio = love.audio.newSource("assets/audio/key_pickup.mp3", "static")
keyPickupAudio:setVolume(0.25)

local needAKeyAudio = love.audio.newSource("assets/audio/you_need_a_key.mp3", "static")
needAKeyAudio:setVolume(1)

local doorOpenAudio = love.audio.newSource("assets/audio/door_open.mp3", "static")
doorOpenAudio:setVolume(0.25)

-- Keeps track of how many keys the player has at once.
local keysInInventory = 0

-- Activates whenever the mouse is pressed.
function love.mousepressed(mouseX, mouseY, btn)
    if(btn ~= 1) then
        test()
        return
    end

    -- Calls the current room's mouse pressed function.
    currentRoom.mousepressed(mouseX, mouseY)
end

-- Checks if an object was clicked on (used for either a door or a key in this game).
local function isClickOnObject(mouseX, mouseY, object)
    return ((mouseX >= object.x) and (mouseX <= object.x + object.width)) and ((mouseY >= object.y) and (mouseY <= object.y + object.height))
end

-- Creates a room object/table.
local function createRoom(roomNumber, roomType, hasKey, roomColor, northDoor, westDoor, southDoor, eastDoor)
    local newRoom = {}
    newRoom.roomType = roomType       -- roomType: a string indicating the type of room ("win", "lose", or "normal").
    newRoom.roomNumber = roomNumber   -- roomNumber: an int indicating the number of the room.
    newRoom.hasKey = hasKey           -- hasKey: a boolean indicating if a room has a key (true) or not (false).
    newRoom.roomColor = roomColor     -- roomColor: a table with RGB values that indicate the color of the room.
    newRoom.northDoor = northDoor     -- northDoor a table with all of the north door's necessary information OR an int value of 0 indicating that there is no north door.
    newRoom.westDoor = westDoor       -- westDoor a table with all of the west door's necessary information OR an int value of 0 indicating that there is no west door.
    newRoom.southDoor = southDoor     -- southDoor a table with all of the south door's necessary information OR an int value of 0 indicating that there is no south door.
    newRoom.eastDoor = eastDoor       -- eastDoor a table with all of the east door's necessary information OR an int value of 0 indicating that there is no east door.

    -- Has a room draw itself.
    function newRoom.draw()
        love.graphics.setBackgroundColor(newRoom.roomColor)
        -- Puts the room number in the top left of the screen.
        love.graphics.print("Room " .. newRoom.roomNumber, 25, 25)

        -- If the room has a key then it will be drawn in the center of the room.
        if newRoom.hasKey then
            love.graphics.draw(key.image, key.x, key.y, key.rotation, key.scale, key.scale)
        end

        -- If the northDoor exists it will be drawn.
        if newRoom.northDoor ~= 0 then
            newRoom.northDoor:drawDoor()
        end

        -- If the westDoor exists it will be drawn.
        if newRoom.westDoor ~= 0 then
            newRoom.westDoor:drawDoor()
        end

        -- If the southDoor exists it will be drawn.
        if newRoom.southDoor ~= 0 then
            newRoom.southDoor:drawDoor()
        end

        -- If the eastDoor exists it will be drawn.
        if newRoom.eastDoor ~= 0 then
            newRoom.eastDoor:drawDoor()
        end
    end

    -- Has a room determine where a click was and what to do about it.
    function newRoom.mousepressed(mouseX, mouseY)
        -- Checks if a room has a key and if that key was clicked on.
        if(currentRoom.hasKey and isClickOnObject(mouseX, mouseY, key)) then
            -- Increases number of keys in inventory by 1.
            love.audio.play(keyPickupAudio)
            keysInInventory = keysInInventory + 1

            -- Removes key from the room.
            currentRoom.hasKey = false
            return
        end

        -- Checks if northDoor exists in the room
        if (currentRoom.northDoor ~= 0) then
            -- Checks if northDoor was clicked on and handles it if it was.
            if(currentRoom.northDoor.handleClick(mouseX, mouseY, currentRoom.northDoor)) then
                return
            end   
        end

        if (currentRoom.westDoor ~= 0) then
            -- Checks if westDoor was clicked on and handles it if it was.
            if(currentRoom.westDoor.handleClick(mouseX, mouseY, currentRoom.westDoor)) then
                return
            end
        end

        if (currentRoom.southDoor ~= 0) then
            -- Checks if southDoor was clicked on and handles it if it was.
            if(currentRoom.southDoor.handleClick(mouseX, mouseY, currentRoom.southDoor)) then
                return
            end 
        end       

        if (currentRoom.eastDoor ~= 0) then
            -- Checks if eastDoor was clicked on and handles it if it was.
            if(currentRoom.eastDoor.handleClick(mouseX, mouseY, currentRoom.eastDoor)) then
                return
            end 
        end       
    end

    return newRoom
end

-- Creates a door object/table
local function createDoor(isLocked, leadsTo, doorType)
    local newDoor = {}
    newDoor.isLocked = isLocked   -- isLocked: a boolean indicating if the door is locked (true) or isn't locked (false).
    newDoor.leadsTo = leadsTo     -- leadsTo: an int indicating which the number of the room that this door will lead to when clicked on.
    newDoor.doorType = doorType   -- doorType is a string that indicates what type of door is being created ("north", "west", "south", or "east").

    -- These if statements check the value of doorType to determine what x, y, width, and height properties to give the door.
    if doorType == "north" then
        newDoor.width = 300
        newDoor.height = 50
        newDoor.x = (WIDTH / 2) - (newDoor.width / 2)
        newDoor.y = 25

    elseif doorType == "west" then
        newDoor.width = 50
        newDoor.height = 300
        newDoor.x = 25
        newDoor.y = (HEIGHT / 2) - (newDoor.height / 2)


    elseif doorType == "south" then
        newDoor.width = 300
        newDoor.height = 50
        newDoor.x = (WIDTH / 2) - (newDoor.width / 2)
        newDoor.y = (HEIGHT - newDoor.height) - 25

    elseif doorType == "east" then
        newDoor.width = 50
        newDoor.height = 300
        newDoor.x = (WIDTH - newDoor.width) - 25
        newDoor.y = (HEIGHT / 2) - (newDoor.height / 2)
    end

    function newDoor.drawDoor(door)
        -- Draws the door.
        love.graphics.rectangle("fill", door.x, door.y, door.width, door.height)

        -- Checks if door is locked. If it is, a lock is drawn on the door.
        if door.isLocked and door.doorType == "north" then
            love.graphics.draw(lock.image, (door.x + (door.width / 2)) - (lock.width / 2), door.y + 5, 0, lock.scale, lock.scale)

        elseif door.isLocked and door.doorType == "west" then
            love.graphics.draw(lock.image, (door.x + 5), (door.y + (door.height / 2)) + (lock.height / 2), -1.5708, lock.scale, lock.scale)

        elseif door.isLocked and door.doorType == "south" then
            love.graphics.draw(lock.image, door.x + (door.width / 2) + (lock.width / 2), (door.y + (door.height)) - 5, 3.14159, lock.scale, lock.scale)

        elseif door.isLocked and door.doorType == "east" then
            love.graphics.draw(lock.image, (door.x + (door.width)) - 5, (door.y + (door.height / 2)) - (lock.height / 2), 1.5708, lock.scale, lock.scale)
        end
    end

    function newDoor.handleClick(mouseX, mouseY, door)
        -- Checks if door was clicked on
        if (isClickOnObject(mouseX, mouseY, door)) then
    
            -- Checks if door is locked. If it is and the player has at least 1 key, it unlocks.
            if (door.isLocked and keysInInventory >= 1) then
                keysInInventory = keysInInventory - 1
                door.isLocked = false
                love.audio.play(unlockAudio)
                love.timer.sleep(0.65)
            elseif door.isLocked then
                love.audio.play(needAKeyAudio)
            end

            -- Checks if door is unlocked. If it is, the player moves through the door.
            if(not door.isLocked) then
                -- Changes the currentRoom to the room with a roomNumber value equal to door.leadsTo.
                for i=1, #rooms do
                    if door.leadsTo == rooms[i].roomNumber then
                        love.audio.play(doorOpenAudio)
                        love.timer.sleep(0.25)
                        currentRoom = rooms[i]
                        return
                    end
                end
            end

            -- Returns true to indicate that the passed in door was clicked on.
            return true
        end

        -- Returns false to indicate that the passed in door wasn't clicked on.
        return false
    end

    return newDoor
end

local function checkRoomType()
    if currentRoom.roomType == "win" then
        love.graphics.draw(treasureImage, (WIDTH / 2) - ((treasureImage:getWidth() * 0.5) / 2), (HEIGHT / 2) - ((treasureImage:getHeight() * 0.5) / 2), 0, 0.5, 0.5)
        love.graphics.draw(winImage, (WIDTH / 2) - ((winImage:getWidth() * 0.75) / 2), -100, 0, 0.75, 0.75)
        currentRoom.northDoor = 0
        currentRoom.westDoor = 0
        currentRoom.southDoor = 0
        currentRoom.eastDoor = 0
        backgroundAudio:pause()
        love.audio.play(winAudio)

    elseif currentRoom.roomType == "lose" then
        love.graphics.draw(loseImage, (WIDTH / 2) - ((loseImage:getWidth() * 0.75) / 2), (HEIGHT / 2) - ((loseImage:getHeight() * 0.75) / 2), 0, 0.75, 0.75)
        currentRoom.northDoor = 0
        currentRoom.westDoor = 0
        currentRoom.southDoor = 0
        currentRoom.eastDoor = 0
        backgroundAudio:pause()
        love.audio.play(loseAudio)
    end
end

function love.load()
    love.window.setMode(WIDTH, HEIGHT)
    local room1 = createRoom(1, "normal", false, {1,0,0}, 0, 0, createDoor(false, 6, "south"), createDoor(false, 2, "east"))
    local room2 = createRoom(2, "normal", false, {1, 0.42, 0}, 0, createDoor(false, 1, "west"), 0, createDoor(false, 3, "east"))
    local room3 = createRoom(3, "normal", false, {1, 0.85, 0}, 0, createDoor(false, 2, "west"), createDoor(false, 7, "south"), 0)
    local room4 = createRoom(4, "lose", false, {0, 0.5, 0.1}, 0, 0, createDoor(false, 9, "south"), 0)
    local room5 = createRoom(5, "normal", false, {0.3, 1, 0}, 0, 0, 0, createDoor(false, 6, "east"))
    local room6 = createRoom(6, "normal", false, {0, 1, 1}, createDoor(false, 1, "north"), createDoor(false, 5, "west"), createDoor(false, 10, "south"), 0)
    local room7 = createRoom(7, "normal", false, {0, 0.58, 1}, createDoor(false, 3, "north"), 0, 0, createDoor(false, 8, "east"))
    local room8 = createRoom(8, "normal", true, {0, 0.15, 1}, 0, createDoor(false, 7, "west"), createDoor(false, 12, "south"), createDoor(false, 9, "east"))
    local room9 = createRoom(9, "normal", false, {0, 0.1, 0.5}, createDoor(false, 4, "north"), createDoor(false, 8, "west"), 0, 0)
    local room10 = createRoom(10, "normal", false, {0.13, 0, 0.5}, createDoor(false, 6, "north"), 0, 0, createDoor(false, 11, "east"))
    local room11 = createRoom(11, "normal", false, {0.28, 0, 1}, 0, createDoor(false, 10, "west"), createDoor(false, 13, "south"), 0)
    local room12 = createRoom(12, "normal", false, {0.34, 0, 0.5}, createDoor(false, 8, "north"), 0, createDoor(false, 15, "south"), 0)
    local room13 = createRoom(13, "normal", false, {0.7, 0, 1}, createDoor(false, 11, "north"), 0, 0, createDoor(false, 14, "east"))
    local room14 = createRoom(14, "normal", false, {1, 0, 0.86}, 0, createDoor(false, 13, "west"), 0, createDoor(false, 15, "east"))
    local room15 = createRoom(15, "normal", false, {1, 0, 0.43}, createDoor(false, 12, "north"), createDoor(false, 14, "west"), createDoor(true, 16, "south"), 0)
    local room16 = createRoom(16, "win", false, {0.5, 0, 0.22}, createDoor(false, 15, "north"), 0, 0, 0)

    table.insert(rooms, room1)
    table.insert(rooms, room2)
    table.insert(rooms, room3)
    table.insert(rooms, room4)
    table.insert(rooms, room5)
    table.insert(rooms, room6)
    table.insert(rooms, room7)
    table.insert(rooms, room8)
    table.insert(rooms, room9)
    table.insert(rooms, room10)
    table.insert(rooms, room11)
    table.insert(rooms, room12)
    table.insert(rooms, room13)
    table.insert(rooms, room14)
    table.insert(rooms, room15)
    table.insert(rooms, room16)

    currentRoom = room11

    love.audio.play(backgroundAudio)
end

function love.draw()
    currentRoom.draw()
    love.graphics.print("Keys: " .. keysInInventory, 25, 50)
    checkRoomType()
end