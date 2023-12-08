-- VERTICAL HALF FENCE SETUP --

local fenceHalfVertical = objectHandler.create("fence_half_vertical", 0, 0, 80, 130, 10, 90, love.graphics.newImage("assets/images/outdoor_decor/fence/vertical/fenceHalfVertical.png"), 50, 0, 1, 130, "static", 1, 0)
fenceHalfVertical:disable()
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- VERTICAL HALF FENCE ANIMATIONS --

fenceHalfVertical.animations.idle = fenceHalfVertical.createAnimation(1, 1, 1, 1)
fenceHalfVertical.currentAnimation = fenceHalfVertical.animations.idle

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- VERTICAL HALF FENCE FUNCTIONALITY --

function fenceHalfVertical.drawTop(object)                    -- This overrides the default function so that it is empty, because this is a blueprint and shouldn't be drawn.

end

function fenceHalfVertical.drawBottom(object)                 -- This overrides the default function so that it is empty, because this is a blueprint and shouldn't be drawn.

end

function fenceHalfVertical.draw(object)                       -- This overrides the default function so that it is empty, because this is a blueprint and shouldn't be drawn.

end

function fenceHalfVertical.setDrawPosition(object)
    table.insert(activeScene.bottomHalfUnderPlayerTorso, object)
    table.insert(activeScene.topHalfUnderPlayerTorso, object)
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

return fenceHalfVertical