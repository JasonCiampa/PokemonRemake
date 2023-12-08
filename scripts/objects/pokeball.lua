-- POKEBALL CREATION --

local pokeball = objectHandler.create("pokeball", 0, 0, 72, 60, 12, 30, love.graphics.newImage("assets/images/pokemon_items/pokeballs/pokeballs_spritesheet.png"))        -- Creates the pokeball object
pokeball:disable()

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- POKEBALL ANIMATIONS --

pokeball.animations.bug = pokeball.createAnimation(1, 1, 1, 1)
pokeball.animations.dark = pokeball.createAnimation(1, 2, 1, 1)
pokeball.animations.dragon = pokeball.createAnimation(1, 3, 1, 1)
pokeball.animations.electric = pokeball.createAnimation(1, 4, 1, 1)
pokeball.animations.fighting = pokeball.createAnimation(1, 5, 1, 1)
pokeball.animations.fire = pokeball.createAnimation(1, 6, 1, 1)
pokeball.animations.flying = pokeball.createAnimation(1, 7, 1, 1)
pokeball.animations.ghost = pokeball.createAnimation(1, 8, 1, 1)
pokeball.animations.grass = pokeball.createAnimation(1, 9, 1, 1)
pokeball.animations.ground = pokeball.createAnimation(1, 10, 1, 1)
pokeball.animations.ice = pokeball.createAnimation(1, 11, 1, 1)
pokeball.animations.normal = pokeball.createAnimation(1, 12, 1, 1)
pokeball.animations.poison = pokeball.createAnimation(1, 13, 1, 1)
pokeball.animations.psychic = pokeball.createAnimation(1, 14, 1, 1)
pokeball.animations.rock = pokeball.createAnimation(1, 15, 1, 1)
pokeball.animations.standard = pokeball.createAnimation(1, 16, 1, 1)
pokeball.animations.normal = pokeball.createAnimation(1, 17, 1, 1)
pokeball.animations.water = pokeball.createAnimation(1, 18, 1, 1)

pokeball.currentAnimation = pokeball.animations.standard

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--  POKEBALL FUNCTIONALITY --
function pokeball.customDuplicate(object, duplicatePokeball)
    function duplicatePokeball.setDrawPosition(object)
        table.insert(activeScene.bottomHalfAbovePlayer, object)
        table.insert(activeScene.topHalfAbovePlayer, object)
    end
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

return pokeball