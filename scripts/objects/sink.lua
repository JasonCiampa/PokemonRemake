-- SINK SETUP --

local sink = objectHandler.create("sink", 588, 456, 120, 144, 12, 72, love.graphics.newImage("assets/images/indoor_decor/sink/sink.png"), 588, 456, 120, 1, "static", 1, 0)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- SINK ANIMATIONS --
sink.animations.idle = sink.createAnimation(1, 1, 1, 1)
sink.currentAnimation = sink.animations.idle

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- SINK FUNCTIONALITY --

function sink.drawTop(object)                    -- This overrides the default function so that it is empty, because this is a blueprint and shouldn't be drawn.

end

function sink.drawBottom(object)                 -- This overrides the default function so that it is empty, because this is a blueprint and shouldn't be drawn.

end

function sink.draw(object)                       -- This overrides the default function so that it is empty, because this is a blueprint and shouldn't be drawn.

end

function sink.setDrawPosition(object)
    table.insert(activeScene.bottomHalfUnderPlayerTorso, object)
    table.insert(activeScene.topHalfAbovePlayer, object)
end 