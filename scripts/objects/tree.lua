-- TREE SETUP --

local tree = objectHandler.create("tree", 0, 0, 400, 600, 556, love.graphics.newImage("assets/images/greenery/trees/tree1.png"), 0, 0, 400, 600, "static", 1, 0)
tree.physics.hitbox.x = 60
tree.physics.hitbox.y = 0
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- TREE ANIMATIONS --

tree.animations.idle = tree.createAnimation(1, 1, 1, 1)
tree.currentAnimation = tree.animations.idle

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- TREE FUNCTIONALITY --

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