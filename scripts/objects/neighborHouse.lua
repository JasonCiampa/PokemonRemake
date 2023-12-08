-- NEIGHBOR HOUSE CREATION --

local neighborHouse = objectHandler.create("neighbor_house", 0, 0, 1680, 492, 12, 355, love.graphics.newImage("assets/images/clear_meadow_town/buildings/houses/single_floor_long/single_floor_long_spritesheet.png"), 0, 0, 1608, 1, "static", 1, 0)
neighborHouse:disable()
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- NEIGHBOR HOUSE ANIMATIONS --

neighborHouse.animations.idle = neighborHouse.createAnimation(1, 1, 1, 1)
neighborHouse.animations.openDoor = neighborHouse.createAnimation(4, 2, 1, 1.5)
neighborHouse.currentAnimation = neighborHouse.animations.idle

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- NEIGHBOR HOUSE FUNCTIONALITY --

function neighborHouse.customDuplicate(object, duplicateNeighborHouse)
    duplicateNeighborHouse.door = door.create("neighbor_house_door", duplicateNeighborHouse.x + 444, duplicateNeighborHouse.y + 252, 168, 240, duplicateNeighborHouse.x + 444, duplicateNeighborHouse.x + 612)

    function duplicateNeighborHouse.enable(this)
        if (this.physics ~= nil) then
            this.physics.body:setActive(true)
        end

        this.door.isOpen = false
        this.currentAnimation = this.animations.idle
    end

    function duplicateNeighborHouse.customUpdate(object, dt)
        if (love.keyboard.isDown("e")) then
            duplicateNeighborHouse.door:open()
        end

        if (duplicateNeighborHouse.door.isOpen) then
            duplicateNeighborHouse.door:update(duplicateNeighborHouse, dt)

            if (neighborHouseInterior == nil) then
                neighborHouseInterior = require("scripts/scenes/neighborHouseInterior")
            end

            previousScene = clearMeadowTown
            nextScene = neighborHouseInterior
        end
    end

    function duplicateNeighborHouse.setDrawPosition(object)
        table.insert(clearMeadowTown.bottomHalfUnderPlayerTorso, object)
        table.insert(clearMeadowTown.topHalfAbovePlayer, object)
    end
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

return neighborHouse