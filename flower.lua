local physics = require("physics")
local animator = require("animator")

local flowerHandler = {}

function flowerHandler.create(name, width, height, x, y, physicsType, density, restitution)
    return physics.addObject(name, width, height, x, y, physicsType, density, restitution)
end

function flowerHandler.draw


