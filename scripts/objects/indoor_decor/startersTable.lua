-- STARTERS TABLE SETUP --

local startersTable = objectHandler.create("startersTable", 0, 0, 312, 192, 12, 96, love.graphics.newImage("assets/images/clear_meadow_town/buildings/lab/lab_decor/starters_table/starters_table.png"), 0, 0, 312, 1, "static", 1, 0)
startersTable:disable()
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- STARTERS TABLE ANIMATIONS --
startersTable.animations.idle = startersTable.createAnimation(1, 1, 1, 1)
startersTable.currentAnimation = startersTable.animations.idle

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- STARTERS TABLE FUNCTIONALITY --

function startersTable.customDuplicate(object, duplicateStartersTable)
    function duplicateStartersTable.setDrawPosition(object)
        if (player.y > object.y) then
            table.insert(activeScene.bottomHalfUnderPlayerTorso, object)
            table.insert(activeScene.topHalfUnderPlayerTorso, object)
        else
            table.insert(activeScene.bottomHalfAbovePlayer, object)
            table.insert(activeScene.topHalfAbovePlayer, object)
        end
    end
end

return startersTable