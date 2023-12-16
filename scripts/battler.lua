local battler =  scene.create("assets/images/battle_screen/battle_screen.jpg", 0, 0, nil)  -- Creates the battle Scene            (in this scene's load function, it should call battler.start)   -- Implement fade to and from black for scene transition 

battler.pokeInfoCards = love.graphics.newImage("assets/images/battle_screen/pokemon_info_cards.png")

battler.font = love.graphics.newFont("assets/fonts/showcard_gothic.ttf", 50)  -- Battler text font is set


-- POKEMON IN BATTLE
battler.playerPokemon = {}
battler.playerPokemon.selectedMove = {}

battler.opposingPokemon = {}
battler.opposingPokemon.selectedMove = {}

-- BATTLE MOVE TYPES
battler.moveTypes = {}
battler.moveTypes.performMove = 1
battler.moveTypes.itemUse = 2
battler.moveTypes.run = 3
battler.moveTypes.switchPokemon = 4

-- BATTLE TURN SYSTEM
battler.movesFirst = nil
battler.movesSecond = nil
battler.bothMovesStarted = false

-- BATTLE TIMERS
battler.timer = nil
battler.gameTextLifeSpan = 5 --seconds

-- BATTLE ACTION BUTTONS
battler.actionButtons = {}

function battler.actionButtonPressed()
    for buttons, button in pairs(battler.actionButtons) do
        button.active = false
    end
end

battler.actionButtons.fightButton = battler.loadButton(button.create(360, 90, 1150, 850, {0.8, 0, 0}, {1, 1, 1}, "Fight"))
function battler.actionButtons.fightButton.performAction(button, mouseX, mouseY)
    battler.actionButtonPressed()
    for buttons, button in pairs(battler.moveButtons) do
        button.active = true
    end
end

battler.actionButtons.bagButton = battler.loadButton(button.create(360, 90, 1530, 850, {0.8, 0.4, 0}, {1, 1, 1}, "Bag"))
function battler.actionButtons.bagButton.performAction(button, mouseX, mouseY)
    battler.actionButtonPressed()
end

battler.actionButtons.pokemonButton = battler.loadButton(button.create(360, 90, 1150, 959, {0, 0.4, 0}, {1, 1, 1}, "Pokemon"))
function battler.actionButtons.pokemonButton.performAction(button, mouseX, mouseY)
    battler.actionButtonPressed()
end

battler.actionButtons.runButton = battler.loadButton(button.create(360, 90, 1530, 959, {0, 0, 0.8}, {1, 1, 1}, "Run"))
function battler.actionButtons.runButton.performAction(button, mouseX, mouseY)
    battler.actionButtonPressed()
end

-- PLAYER POKEMON'S MOVE BUTTONS
battler.moveButtons = {}



-- local itemUseButton = battler.loadButton(button.create(200, 100, (battler.width / 2) - WIDTH / 4, (battler.height / 2) - 50, {0, 0, 1}, {1, 1, 1}, "Play"))     -- Adds a play Button to the titleScreen Button list

-- -- Sets itemUseButton's action to be set the player's selected move type
-- function itemUseButton.performAction(button, mouseX, mouseY) 
--     battler.playerPokemon.selectedMove = battler.moveTypes.itemUse
-- end


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- BATTLER FUNCTIONS --

function battler.drawPokeInfoCards()
    love.graphics.setColor(0, 0, 0)
    love.graphics.printf(battler.opposingPokemon.name, battler.font, 5, 195, 325, "left")
    love.graphics.printf("Lv. " .. tostring(battler.opposingPokemon.level), battler.font, 420, 195, 550, "left")
    love.graphics.printf(battler.playerPokemon.name, battler.font, 1350, 595, 1500, "left")
    love.graphics.printf("Lv. " .. tostring(battler.playerPokemon.level), battler.font, 1750, 595, 1800, "left")

    love.graphics.setColor(1, 1, 1)
    love.graphics.printf(battler.opposingPokemon.name, battler.font, 10, 195, 325, "left")
    love.graphics.printf("Lv. " .. tostring(battler.opposingPokemon.level), battler.font, 425, 195, 550, "left")
    love.graphics.printf(battler.playerPokemon.name, battler.font, 1355, 595, 1500, "left")
    love.graphics.printf("Lv. " .. tostring(battler.playerPokemon.level), battler.font, 1755, 595, 1800, "left")

    -- Max Health: 250 health, 344 px
    love.graphics.setColor(0, 0.8, 0)
    love.graphics.rectangle("fill", 168, 264, (battler.opposingPokemon.currentHealth / battler.opposingPokemon.baseHealth) * 344, 32)
    love.graphics.rectangle("fill", 1488, 672, (battler.playerPokemon.currentHealth / battler.playerPokemon.baseHealth) * 344, 32)
end


function battler.load()
    -- The tall grass should have code that will set the playerPokemon and opposingPokemon

    battler.playerPokemon.isBattling = true                                                                                                                                 -- Set the playerPokemon's battling status to true
    battler.playerPokemon.x = 0                                                                                                                                             -- Set the x-coordinate for the playerPokemon to be drawn at         
    battler.playerPokemon.y = 520                                                                                                                                           -- Set the y-coordinate for the playerPokemon to be drawn at
    
    if (battler.playerPokemon.isShiny) then                                                                                                                                 -- If the playerPokemon is shiny...
        battler.playerPokemon.currentAnimation = battler.playerPokemon.animations.shinyBackFacing                                                                               -- Set the current animation for the playerPokemon to be shinyBackFacing
    else                                                                                                                                                                    -- Otherwise...
        battler.playerPokemon.currentAnimation = battler.playerPokemon.animations.backFacing                                                                                    -- Set the current animation for the playerPokemon to be backFacing
    end

    battler.opposingPokemon.isBattling = true                                                                                                                               -- Set the opposingPokemon's battling status to true
    battler.opposingPokemon.x = 1250                                                                                                                                        -- Sets the x-coordinate for the opposingPokemon to be drawn at         
       
    if (battler.opposingPokemon.types["type1"] == pokemonHandler.types.Flying or battler.opposingPokemon.types["type2"] == pokemonHandler.types.Flying) then                -- If the opposingPokemon is a flying type pokemon...
        battler.opposingPokemon.y = 50                                                                                                                                          -- Set the y-coordinate for the opposingPokemon to be higher up
    else                                                                                                                                                                    -- Otherwise...
        battler.opposingPokemon.y = 120                                                                                                                                         -- Set the y-coordinate of the opposingPokemon to be at a normal level
    end

    if (battler.opposingPokemon.isShiny) then                                                                                                                               -- If the opposingPokemon is shiny...
        battler.opposingPokemon.currentAnimation = battler.opposingPokemon.animations.shinyFrontFacing                                                                          -- Set the current animation for the opposingPokemon to be shinyFrontFacing
    else                                                                                                                                                                    -- Otherwise...
        battler.opposingPokemon.currentAnimation = battler.opposingPokemon.animations.frontFacing                                                                               -- Set the current animation for the opposingPokemon to be frontFacing
    end

    battler.timer = 45                                                                                                                                                      -- Set the battler.timer equal to 45 seconds

    gameText.setText("A wild " .. battler.opposingPokemon.name .. " has appeared!")                                                                                         -- Set the textbox's text to indicate that a wild pokemon has been encountered
    gameText.display()                                                                                                                                                      -- Display the textbox onto the screen
end

function battler.finish()
    -- display a textbox saying how the battle ended (pokemon ran out of health, run away, etc.)
    gameText.setText("HOWEVER THE BATTLE ENDED")
    gameText.display()

    battler.playerPokemon = nil
    battler.opposingPokemon = nil

    battler.bothMovesStarted = false
end

-- Determines which Pokemon gets to move first in a round
function battler.determineFirstMove()
    if ( (battler.playerPokemon.selectedMove == battler.moveTypes.itemUse) or (battler.playerPokemon.selectedMove == battler.moveTypes.run) or (battler.playerPokemon.selectedMove == battler.moveTypes.switchPokemon) ) then   -- If the player's selected move is to either use an item, run, or switch to a different pokemon...
        battler.movesFirst = battler.playerPokemon                                                                                                                                                                                  -- Set the first move to belong to the player's pokemon
        battler.movesSecond = battler.opposingPokemon                                                                                                                                                                               -- Set the second move to belong to the opposing pokemon
    elseif (battler.playerPokemon.selectedMove ~= nil) then                                                                                                                                                                     -- Otherwise, if the player pokemon selected a move to perform...
        if (battler.playerPokemon.currentSpeed > battler.opposingPokemon.currentSpeed) then                                                                                                                                         -- If the player pokemon is faster than the opposing pokemon...
            battler.movesFirst = battler.playerPokemon                                                                                                                                                                                  -- Set the first move to belong to the player's pokemon
            battler.movesSecond = battler.opposingPokemon                                                                                                                                                                               -- Set the second move to belong to the opposing pokemon        
        end                                                                                                                                                                                                                       
    else                                                                                                                                                                                                                        -- Otherwise...
        battler.movesFirst = battler.opposingPokemon                                                                                                                                                                                -- Set the first move to belong to the opposing pokemon
        battler.movesSecond = battler.playerPokemon                                                                                                                                                                                 -- Set the second move to belong to the player's pokemon
    end
end

function battler.startMove(pokemon, move)
    -- call the function for the move selected by battler.movesFirst
        -- this should mark the pokemon.performingAction as true

    -- display a textbox saying what the pokemon's move is
        -- (playerPokemon used attack! or playerPokemon used a potion!)  (to trigger text use the textBox file functions (create(), setText(), display(this should trigger the fade in animation), getLifeSpan(), hide())
        
        
        gameText.setText(pokemon.name .. " used " .. move.name)

        -- Figure out how to display the "its super effective" texts 
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- BATTLER STATE HANDLING FUNCTIONS

function battler.update(dt)
    if (gameText.active) then                                                                           -- If the textbox is active...
        if (gameText.getLifeSpan() > battler.gameTextLifeSpan) then                                           -- If the textbox has been alive for longer than the battler's set textbox lifespan...
            gameText.hide()                                                                                       -- Hide the textbox
        end

        return
    end

    battler.updateButtons(dt)


    if( (battler.playerPokemon.currentHealth > 0 and battler.opposingPokemon.currentHealth > 0) and (battler.playerPokemon.isBattling and battler.opposingPokemon.isBattling)) then           -- If both pokemon still have health and haven't fled the battle...
--         if (battler.playerPokemon.action == nil and battler.timer > 0) then                                                                                                     -- If the playerPokemon hasn't selected a move and the timer hasn't run out...
--             battler.timer = battler.timer - dt                                                                                                                                      -- Adjust the battle timer

--             -- Have the battler.scene display its 4 buttons (Attack, Bag, Pokemon, Run) (each button will lead to another sub-button, like how the Attack button will lead to 4 sub-buttons for each of the moves) (right-clicking should get info for a move)
--             -- When a "final decision" button is pressed, have the button's actionPerformed do all of the following:
--                 -- set the battler.playerPokemon.action to be a function belonging to the pokemon depending on what button was pressed (attack(), useItem(), run(), throwPokeball(), etc.)
--                 -- set the battler.opposingPokemon.action to be a random move or to run away
--                 -- call battler.determineFirstMove
--                 -- call battler.startMove(battler.movesFirst)
--             -- return
--         else
--             if (battler.movesFirst.performingAction) then               -- If the first move is in progress...
--                 return                                                      -- return until it finishes
--             else
--                 if(battler.movesSecond.performingAction) then           -- If the second move is in progress...
--                     return
--                 else
--                     if (not battler.bothMovesperformed) then              -- If both moves haven't been performed yet...
--                         battler.startMove(battler.movesSecond)                -- Start the second move
--                         battler.bothMovesperformed = true                     -- Set bothMovesperformed to true now that both moves have performed (or at least started performing)
--                         return
--                     end
--                 end
--             end
--         end
    else
        battler.finish()
    end
            

--     -- else
--         -- update all battle components (health bars, pokemon present/or run away)
                
--         -- update the health
end

function battler.draw()
    love.graphics.draw(battler.background, battler.x, battler.y)
    battler.drawButtons()
    love.graphics.setColor(1, 1, 1)
    battler.playerPokemon:draw()
    battler.opposingPokemon:draw()
    love.graphics.draw(battler.pokeInfoCards)

    battler.drawPokeInfoCards()
    

end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

return battler