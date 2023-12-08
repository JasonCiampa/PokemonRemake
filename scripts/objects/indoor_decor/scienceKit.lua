-- SCIENCE KIT SETUP --

local scienceKit = objectHandler.create("scienceKit", 0, 0, 168, 192, 12, 118, love.graphics.newImage("assets/images/clear_meadow_town/buildings/lab/lab_decor/science_kit/science_kit.png"), 0, 0, 168, 1, "static", 1, 0)
scienceKit:disable()
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- SCIENCE KIT ANIMATIONS --
scienceKit.animations.idle = scienceKit.createAnimation(1, 1, 1, 1)
scienceKit.currentAnimation = scienceKit.animations.idle

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- SCIENCE KIT FUNCTIONALITY --

function scienceKit.customDuplicate(object, duplicateScienceKit)
    function duplicateScienceKit.setDrawPosition(object)
        if (player.y > object.y) then
            table.insert(activeScene.bottomHalfUnderPlayerTorso, object)
            table.insert(activeScene.topHalfUnderPlayerTorso, object)
        else
            table.insert(activeScene.bottomHalfAbovePlayer, object)
            table.insert(activeScene.topHalfAbovePlayer, object)
        end
    end
end

return scienceKit