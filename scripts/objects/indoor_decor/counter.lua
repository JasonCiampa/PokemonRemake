-- COUNTER SETUP --

local counter = objectHandler.create("counter", 0, 0, 120, 120, 12, 60, love.graphics.newImage("assets/images/indoor_decor/counter/counter.png"), 0, 0, 120, 1, "static", 1, 0)
counter:disable()
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- COUNTER ANIMATIONS --
counter.animations.idle = counter.createAnimation(1, 1, 1, 1)
counter.currentAnimation = counter.animations.idle

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- COUNTER FUNCTIONALITY --

return counter