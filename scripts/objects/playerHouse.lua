-- PLAYER HOUSE CREATION --

local playerHouse = objectHandler.create("player_house", 0, 0, 840, 492, 12, 356, love.graphics.newImage("assets/images/clear_meadow_town/buildings/houses/single_floor//single_floor_spritesheet.png"), 0, 0, 743, 1, "static", 1, 0)
playerHouse:disable()
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- PLAYER HOUSE ANIMATIONS --

playerHouse.animations.idle = playerHouse.createAnimation(1, 1, 1, 1)
playerHouse.animations.openDoor = playerHouse.createAnimation(4, 2, 1, 1.5)
playerHouse.currentAnimation = playerHouse.animations.idle

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- PLAYER HOUSE FUNCTIONALITY --

function playerHouse.customDuplicate(object, duplicatePlayerHouse)
    duplicatePlayerHouse.door = door.create("player_house_door", duplicatePlayerHouse.x + 324, duplicatePlayerHouse.y + 252, 168, 240, duplicatePlayerHouse.x + 324, duplicatePlayerHouse.x + 492)

    function duplicatePlayerHouse.enable(this)
        if (this.physics ~= nil) then
            this.physics.body:setActive(true)
        end

        this.door.isOpen = false
        this.currentAnimation = this.animations.idle
    end

    function duplicatePlayerHouse.customUpdate(object, dt)
        if (love.keyboard.isDown("e")) then
            duplicatePlayerHouse.door:open()
        end

        if (duplicatePlayerHouse.door.isOpen) then
            duplicatePlayerHouse.door:update(duplicatePlayerHouse, dt)

            if (playerHouseInterior == nil) then
                playerHouseInterior = require("scripts/scenes/playerHouseInterior")
            end

            previousScene = clearMeadowTown
            nextScene = playerHouseInterior
        end
    end

    function duplicatePlayerHouse.setDrawPosition(object)
        table.insert(clearMeadowTown.bottomHalfUnderPlayerTorso, object)
        table.insert(clearMeadowTown.topHalfAbovePlayer, object)
    end
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

return playerHouse