-- TREE SETUP --

local tree = objectHandler.create("tree", 0, 0, 400, 600, 20, 556, love.graphics.newImage("assets/images/outdoor_decor/greenery/trees/tree.png"), 0, 0, 400, 600, "static", 1, 0)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- TREE ANIMATIONS --

tree.animations.idle = tree.createAnimation(1, 1, 1, 1)
tree.currentAnimation = tree.animations.idle

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- TREE FUNCTIONALITY --

tree.physics.hitbox.x = 60
tree.physics.hitbox.y = 0

function tree.drawTop(object)                    -- This overrides the default function so that it is empty, because this is a blueprint and shouldn't be drawn.

end

function tree.drawBottom(object)                 -- This overrides the default function so that it is empty, because this is a blueprint and shouldn't be drawn.

end

function tree.draw(object)                       -- This overrides the default function so that it is empty, because this is a blueprint and shouldn't be drawn.

end

function tree.setDrawPosition(object)
    table.insert(activeScene.bottomHalfUnderPlayerTorso, object)
    table.insert(activeScene.topHalfAbovePlayer, object)
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

return tree