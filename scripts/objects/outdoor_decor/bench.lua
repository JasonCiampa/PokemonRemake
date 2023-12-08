-- BENCH CREATION --

local bench = objectHandler.create("bench", 0, 0, 360, 192, 12, 72, love.graphics.newImage("assets/images/outdoor_decor/bench/bench.png"), 0, 0, 358, 1, "static", 1, 0)        -- Creates the bench object
bench:disable()

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- BENCH ANIMATIONS --

bench.animations.idle = bench.createAnimation(1, 1, 1, 1)
bench.currentAnimation = bench.animations.idle

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--  BENCH FUNCTIONALITY --

function bench.setDrawPosition(object)
    if (player.y > object.y - object.splitPoint) then
        table.insert(activeScene.bottomHalfUnderPlayerTorso, object)
        table.insert(activeScene.topHalfUnderPlayerTorso, object)
    else
        table.insert(activeScene.bottomHalfAbovePlayer, object)
        table.insert(activeScene.topHalfAbovePlayer, object)
    end
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

return bench