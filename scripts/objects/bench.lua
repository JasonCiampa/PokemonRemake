-- BENCH CREATION --

local bench = objectHandler.create("bench", 1050, 150, 360, 192, 72, love.graphics.newImage("assets/images/outdoor_decor/bench/bench1.png"), 1051, 221, 358, 1, "static", 1, 0)        -- Creates the bench object

-- local bench2 = clearMeadowTown.createDuplicateObject(bench1, 1526, 74) 
-- local bench3 = clearMeadowTown.createDuplicateObject(bench1, 1961, 74)
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