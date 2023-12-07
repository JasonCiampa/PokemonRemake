-- HORIZONTAL HALF FENCE SETUP --

local fenceHalfHorizontal = objectHandler.create("fence_half_horizontal", 0, 0, 180, 100, 10, 5, love.graphics.newImage("assets/images/outdoor_decor/fence/horizontal/fenceHalfHorizontal.png"), 0, 50, 180, 1, "static", 1, 0)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- HORIZONTAL HALF FENCE ANIMATIONS --

fenceHalfHorizontal.animations.idle = fenceHalfHorizontal.createAnimation(1, 1, 1, 1)
fenceHalfHorizontal.currentAnimation = fenceHalfHorizontal.animations.idle

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- HORIZONTAL HALF FENCE FUNCTIONALITY --

function fenceHalfHorizontal.drawTop(object)                    -- This overrides the default function so that it is empty, because this is a blueprint and shouldn't be drawn.

end

function fenceHalfHorizontal.drawBottom(object)                 -- This overrides the default function so that it is empty, because this is a blueprint and shouldn't be drawn.

end

function fenceHalfHorizontal.draw(object)                       -- This overrides the default function so that it is empty, because this is a blueprint and shouldn't be drawn.

end

function fenceHalfHorizontal.setDrawPosition(object)
    if(player.y > object.y) then
        table.insert(activeScene.bottomHalfUnderPlayerTorso, object)
        table.insert(activeScene.topHalfUnderPlayerTorso, object)
    else
        table.insert(activeScene.bottomHalfAbovePlayer, object)
        table.insert(activeScene.topHalfAbovePlayer, object)
    end
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

return fenceHalfHorizontal