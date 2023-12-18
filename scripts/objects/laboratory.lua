-- PLAYER HOUSE CREATION --

local laboratory = objectHandler.create("laboratory", 0, 0, 1800, 984, 12, 809, love.graphics.newImage("assets/images/clear_meadow_town/buildings/lab/exterior/lab_exterior.png"), 0, 0, 1560, 830, "static", 1, 0)
laboratory:disable()

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- PLAYER HOUSE ANIMATIONS --

laboratory.animations.idle = laboratory.createAnimation(1, 1, 1, 1)
laboratory.currentAnimation = laboratory.animations.idle

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- PLAYER HOUSE FUNCTIONALITY --

function laboratory.customDuplicate(object, duplicateLaboratory)
    duplicateLaboratory.door = door.create("laboratory_door", duplicateLaboratory.x + 1189, duplicateLaboratory.y + 744, 336, 240, duplicateLaboratory.x + 612, duplicateLaboratory.x + 948)

    function duplicateLaboratory.enable(this)
        if (this.physics ~= nil) then
            this.physics.body:setActive(true)
        end

        this.door.isOpen = false
        this.currentAnimation = this.animations.idle
    end

    function duplicateLaboratory.customUpdate(object, dt)
        if (love.keyboard.isDown("e")) then
            duplicateLaboratory.door:open()
            printDebugText = tostring(duplicateLaboratory.door.isOpen)
        end
        
        if (duplicateLaboratory.door.isOpen) then
            duplicateLaboratory.door:update(duplicateLaboratory, dt)

            if (laboratoryInterior == nil) then
                laboratoryInterior = require("scripts/scenes/laboratoryInterior")
            end

            previousScene = clearMeadowTown
            nextScene = laboratoryInterior
        end
    end

    function duplicateLaboratory.setDrawPosition(object)
        table.insert(clearMeadowTown.bottomHalfUnderPlayerTorso, object)
        table.insert(clearMeadowTown.topHalfAbovePlayer, object)
    end
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

return laboratory