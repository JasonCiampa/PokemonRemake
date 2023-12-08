-- SCIENCE TABLE SETUP --

local scienceTable = objectHandler.create("scienceTable", 0, 0, 288, 84, 12, 42, love.graphics.newImage("assets/images/clear_meadow_town/buildings/lab/lab_decor/science_table/science_table.png"), 0, 0, 288, 1, "static", 1, 0)
scienceTable:disable()
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- SCIENCE TABLE ANIMATIONS --
scienceTable.animations.idle = scienceTable.createAnimation(1, 1, 1, 1)
scienceTable.currentAnimation = scienceTable.animations.idle

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- SCIENCE TABLE FUNCTIONALITY --

function scienceTable.customDuplicate(object, duplicateScienceTable)
    function duplicateScienceTable.setDrawPosition(object)
        if (player.y > object.y) then
            table.insert(activeScene.bottomHalfUnderPlayerTorso, object)
            table.insert(activeScene.topHalfUnderPlayerTorso, object)
        else
            table.insert(activeScene.bottomHalfAbovePlayer, object)
            table.insert(activeScene.topHalfAbovePlayer, object)
        end
    end
end

return scienceTable