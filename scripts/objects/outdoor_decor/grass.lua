-- in grass's custom update, check for player stepping inside of grass
-- if player is inside of grass, randomly roll to see if there is a pokemon encounter
-- if yes, call battle.start between playerPokemon[1] and opposingPokemon (opposingPokemon will be a randomly generated pokemon from the scene's list of valid pokemon)

-- GRASS CREATION --

local grass = objectHandler.create("grass", 0, 0, 160, 180, 4, 105, love.graphics.newImage("assets/images/outdoor_decor/greenery/grass/grass_spritesheet.png"), 0, 0, 160, 180, "static", 1, 0)        -- Creates the grass object
grass:disable()


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- GRASS FUNCTIONALITY -- 

function grass.customDuplicate(object, duplicateObject)

    -- GRASS ANIMATIONS --
    duplicateObject.animations.idle = duplicateObject.createAnimation(1, 1, 1, 1)
    duplicateObject.currentAnimation = duplicateObject.animations.idle

    -- GRASS PHYSICS --
    duplicateObject.physics.fixture:setSensor(true)

    -- GRASS DRAWING --
    function grass.setDrawPosition(object)
        table.insert(activeScene.bottomHalfUnderPlayerHead, object)
        table.insert(activeScene.topHalfUnderPlayerHead, object)
    end
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

return grass