-- BED SETUP --

local bed = objectHandler.create("bed", 0, 0, 144, 204, 12, 102, love.graphics.newImage("assets/images/indoor_decor/bed/bed_spritesheet.png"), 0, 0, 144, 1, "static", 1, 0)
bed:disable()
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- BED ANIMATIONS --
bed.animations.idle_cyan = bed.createAnimation(1, 1, 1, 1)
bed.animations.idle_red = bed.createAnimation(1, 2, 1, 1)
bed.currentAnimation = bed.animations.idle

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- BED FUNCTIONALITY --

return bed