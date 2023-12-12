-- LONG TABLE SETUP --

local longTable = objectHandler.create("longTable", 0, 0, 720, 120, 12, 60, love.graphics.newImage("assets/images/indoor_decor/long_table/long_table.png"), 0, 0, 720, 1, "static", 1, 0)
longTable:disable()
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- LONG TABLE ANIMATIONS --
longTable.animations.idle = longTable.createAnimation(1, 1, 1, 1)
longTable.currentAnimation = longTable.animations.idle

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- LONG TABLE FUNCTIONALITY --

return longTable