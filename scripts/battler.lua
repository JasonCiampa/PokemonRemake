local battler =  scene.create("assets/images/battle_screen/battle_screen.jpg", 0, 0, nil)  -- Creates the battle Scene            (in this scene's load function, it should call battler.start)   -- Implement fade to and from black for scene transition 

battler.pokeInfoCards = love.graphics.newImage("assets/images/battle_screen/pokemon_info_cards.png")

battler.font = love.graphics.newFont("assets/fonts/showcard_gothic.ttf", 50)  -- Battler text font is set

-- POKEMON IN BATTLE
battler.playerPokemon = {}
battler.playerPokemon.selectedAction = nil
battler.playerPokemon.selectedMove = nil
battler.playerPokemon.target = nil

battler.opposingPokemon = {}
battler.opposingPokemon.selectedAction = nil
battler.opposingPokemon.selectedMove = nil
battler.opposingPokemon.target = nil

-- BATTLE MOVE TYPES
battler.moveTypes = {}
battler.moveTypes.performMove = 1
battler.moveTypes.run = 2
battler.moveTypes.useItem = 3
battler.moveTypes.switchPokemon = 4

-- BATTLE TURN SYSTEM
battler.movesFirst = nil
battler.movesSecond = nil
battler.bothMovesStarted = false

-- BATTLE TIMERS
battler.selectActionTimer = nil
battler.performMoveTimer = nil
battler.battleEndingTimer = nil
battler.gameTextLifeSpan = 5 --seconds
battler.battleEnding = false

-- BATTLE ACTION BUTTONS
battler.actionButtons = {}
battler.moveButtons = {}
battler.switchPokemonButtons = {}

battler.allowButtonPresses = false

testThing = ""


-- local useItemButton = battler.loadButton(button.create(200, 100, (battler.width / 2) - WIDTH / 4, (battler.height / 2) - 50, {0, 0, 1}, {1, 1, 1}, "Play"))     -- Adds a play Button to the titleScreen Button list

-- -- Sets useItemButton's action to be set the player's selected move type
-- function useItemButton.performAction(button, mouseX, mouseY) 
--     battler.playerPokemon.selectedAction = battler.moveTypes.useItem
-- end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- BATTLER FUNCTIONS --

function battler.mousepressed(mouseX, mouseY)
    if (battler.allowButtonPresses) then
        for i = 1, #battler.buttons do                                  -- For every Button in the battler...
            if (battler.buttons[i].active) then
                if (mouseInObject(battler.buttons[i], mouseX, mouseY)) then                 -- If the mouse is currently inside of the Button...
                    battler.buttons[i]:isPressed(mouseX, mouseY)                                -- Check if the Button was pressed
                end
            end
        end
    end
end

-- Starts the Pokemon's selected move
function battler.startAction(pokemon)
    -- call the function for the move selected by battler.movesFirst
        -- this should mark the pokemon.performingAction as true

    -- display a textbox saying what the pokemon's move is
        -- (playerPokemon used attack! or playerPokemon used a potion!)  (to trigger text use the textBox file functions (create(), setText(), display(this should trigger the fade in animation), getLifeSpan(), hide())
        
    pokemon.performingAction = true
    

    -- Figure out how to display the "its super effective" texts 
    if (pokemon.selectedAction == battler.moveTypes.performMove) then                                               -- If the Pokemon's selected action was to perform one of their moves...
        if (pokemon == battler.opposingPokemon) then
            gameText.setText("The wild " .. pokemon.name .. " used " .. pokemon.selectedMove.name .. "!")                                  -- Set the gameText to indicate what move the Pokemon is performing
        else
            gameText.setText(pokemon.name .. " used " .. pokemon.selectedMove.name .. "!")                                  -- Set the gameText to indicate what move the Pokemon is performing
        end

        battler.performMoveTimer = 2.5                                                                                    -- Set the performMoveTimer to 2 seconds
    elseif (pokemon.selectedAction == battler.moveTypes.useItem) then                                               -- Otherwise, if the Pokemon's selected action was to use an item...
        -- gameText.setText(pokemon.name .. " used " .. item.name .. "!")                                               -- Set the gameText to indicate what item the Pokemon is using
    elseif (pokemon.selectedAction == battler.moveTypes.run) then                                                   -- Otherwise, if the Pokemon's selected action was to run...
        gameText.setText("The wild " .. pokemon.name .. " fled the battle!")                                                           -- Set the gameText to indicate that the Pokemon has fled
    elseif (pokemon.selectedAction == battler.moveTypes.switchPokemon) then                                         -- Otherwise, if the Pokemon's selected action was to switch to a different Pokemon...
        gameText.setText(pokemon.name .. " switched out of the battle!")                                         -- Set the gameText to indicate that a new Pokemon has been switched into battle
    else                                                                                                            -- Otherwise...
        gameText.setText(pokemon.name .. " was busy dilly dallying and didn't select an action this turn!")                                                                                                                -- Move wasn't selected in time, so set the gameText to indicate that
    end

    gameText.display()
end

-- Updates the Pokemon as they perform their selected move
function battler.updateAction(performingPokemon, dt)
    if (performingPokemon.selectedAction == battler.moveTypes.performMove) then                                               -- If the performingPokemon's selected action was to perform one of their moves...
        if (battler.performMoveTimer > 0) then
            battler.performMoveTimer = battler.performMoveTimer - dt

            if (battler.performMoveTimer > 1) then
                performingPokemon:update(dt)
            else
                performingPokemon.target:update(dt)
            end
        else
            battler.performMoveTimer = 0
            performingPokemon.performingAction = false
            local moveResult = performingPokemon.useMove(performingPokemon.target, performingPokemon.selectedMove)
                
            if (moveResult == 0) then
                gameText.setText(performingPokemon.name .. "'s move had no effect on.")
            elseif (moveResult == 1) then
                gameText.setText(performingPokemon.name .. "'s move was not very effective.")
            elseif (moveResult == 2) then
                gameText.setText(performingPokemon.name .. "'s move was super effective!")
            elseif (moveResult == false) then
                gameText.setText(performingPokemon.name .. "'s move missed! How embarassing!")
            elseif (moveResult == true) then
                return
            end

            gameText.display()
        end
    
    -- elseif (pokemon.selectedAction == battler.moveTypes.useItem) then                                               -- Otherwise, if the Pokemon's selected action was to use an item...
    --     -- gameText.setText(pokemon.name .. " used " .. item.name .. "!")                                               -- Set the gameText to indicate what item the Pokemon is using
    elseif (performingPokemon.selectedAction == battler.moveTypes.run) then                                                   -- Otherwise, if the Pokemon's selected action was to run...
        performingPokemon.isBattling = false
    
    elseif (performingPokemon.selectedAction == battler.moveTypes.switchPokemon) then                                         -- Otherwise, if the Pokemon's selected action was to switch to a different Pokemon...
        battler.loadPlayerPokemon(battler.playerPokemon.selectedMove)
        battler.setButtonStates(battler.actionButtons, true)
        gameText.setText(battler.playerPokemon.name .. " switched into the battle!")
    end                                                                                                            -- Otherwise...
end


-- Changes the active state of every Button in a list of Buttons
function battler.setButtonStates(buttonList, activeState)
    for buttons, button in pairs(buttonList) do
        button.active = activeState
    end
end

-- Sets the Buttons for each of the Player Pokemon's moves
function battler.setPlayerPokemonMoves()
    for i = 1, 4 do                                                                                                                                                                                                             -- For each of the four moves that the playerPokemon has...
        local buttonX                                                                                                                                                                                                               -- Create a variable to store the x-coordinate of the Button
        local buttonY                                                                                                                                                                                                               -- Create a variable to store the y-coordinate of the Button

        if (i % 2 == 0) then                                                                                                                                                                                                        -- If the move number is an even number...
            buttonX = 1530                                                                                                                                                                                                              -- Set the Button's x-coordinate to 1530
        else                                                                                                                                                                                                                        -- Otherwise...
            buttonX = 1150                                                                                                                                                                                                              -- Set the Button's x-coordinate to 1150
        end                                                                                                             

        if (i > 2) then                                                                                                                                                                                                             -- If the move number is greater than 2...
            buttonY = 959                                                                                                                                                                                                               -- Set the Button's y-coordinate to 959
        else                                                                                                                                                                                                                        -- Otherwise...
            buttonY = 850                                                                                                                                                                                                               -- Set the Button's y-coordinate to 850
        end

        local newMoveButton = battler.loadButton(button.create(360, 90, buttonX, buttonY, battler.playerPokemon.moves["move" .. i].type.color, {1, 1, 1}, battler.playerPokemon.moves["move" .. i].name, "center", 40))                       -- Create a variable to temporarily store the newMoveButton
        newMoveButton.active = false                                                                                                                                                                                                -- Disable the newMoveButton's active state

        -- Action to perform when the move button is clicked on
        function newMoveButton.performAction(button, mouseX, mouseY)
            battler.setButtonStates(battler.moveButtons, false)

            battler.playerPokemon.selectedAction = battler.moveTypes.performMove
            battler.playerPokemon.selectedMove = battler.playerPokemon.moves["move" .. i]

            if (battler.playerPokemon.selectedMove.category == "Status") then
                battler.playerPokemon.target = battler.playerPokemon
            else
                battler.playerPokemon.target = battler.opposingPokemon
            end

            battler.determineFirstMove()
            battler.startAction(battler.movesFirst, battler.playerPokemon.selectedMove)
        end

        table.insert(battler.moveButtons, newMoveButton)
    end
end

-- Removes each of Buttons for the Player Pokemon's moves
function battler.clearPlayerPokemonMoves()
    for i = #battler.moveButtons, 0, -1 do
        table.remove(battler.moveButtons, i)
    end
end

function battler.setSwitchPokemonButtons()
    for i = 1, #player.pokemon do
        local buttonX
        local buttonY

        if (i % 2 == 0) then
            buttonX = 1528
        else
            buttonX = 1152
        end

        if (i < 3) then
            buttonY = 790
        elseif (i > 2 and i < 5) then
            buttonY = 888
        elseif (i > 4) then
            buttonY = 986
        end

        local newPokemonButton = battler.loadButton(button.create(360, 88, buttonX, buttonY, {0, 0.24, 0}, {1, 1, 1}, player.pokemon[i].name, "center", 30))                       -- Create a variable to temporarily store the newPokemonButton
        newPokemonButton.active = false 
        newPokemonButton.pokeSprite = {}
        newPokemonButton.pokeSprite.x = buttonX + 15
        newPokemonButton.pokeSprite.y = buttonY - 5

        function newPokemonButton.performAction(button, mouseX, mouseY)
            if (battler.playerPokemon == player.pokemon[i]) then
                -- Play an error noise since you can't switch to the pokemon that is already out
                return
            end

            battler.setButtonStates(battler.switchPokemonButtons, false)

            battler.playerPokemon.selectedMove = player.pokemon[i]
            battler.playerPokemon.selectedAction = battler.moveTypes.switchPokemon
            battler.movesFirst = battler.opposingPokemon
            battler.movesSecond = battler.playerPokemon
        end

        table.insert(battler.switchPokemonButtons, newPokemonButton)
    end
end

function battler.clearSwitchPokemonButtons()
    for i = #battler.switchPokemonButtons, 0, -1 do
        table.remove(battler.switchPokemonButtons, i)
    end
end

function battler.finish()
    if (battler.playerPokemon.currentHealth <= 0) then
        gameText.setText(battler.playerPokemon.name .. " has fainted!")        
        gameText.display()
    elseif (battler.opposingPokemon.currentHealth <= 0) then
        gameText.setText(battler.opposingPokemon.name .. " has fainted!")        
        gameText.display()
    end

    battler.clearPlayerPokemonMoves()
    battler.battleEnding = true

end

-- Determines which Pokemon gets to move first in a round
function battler.determineFirstMove()
    
    local moveDecider = love.math.random(1, 100)                                                                                                                                                                                 -- Roll to determine if the move will be to run or to perform a move
    if (moveDecider > 10) then                                                                                                                                                                                                   -- If the moveDecider value is greater than 10 (90% chance)
        battler.opposingPokemon.selectedAction = battler.moveTypes.performMove                                                                                                                                                         -- Set the Pokemon's selected move to be to perform a move
        battler.opposingPokemon.selectedMove = battler.opposingPokemon.moves["move" .. tostring(love.math.random(1, 4))]
        
        if (battler.opposingPokemon.selectedMove.category == "Status") then
            battler.opposingPokemon.target = battler.opposingPokemon
        else
            battler.opposingPokemon.target = battler.playerPokemon
        end
    else                                                                                                                                                                                                                         -- Otherwise...
        battler.opposingPokemon.selectedAction = battler.moveTypes.run                                                                                                                                                                 -- Set the Pokemon's selected move to be to run
    end

    if ( (battler.playerPokemon.selectedAction == battler.moveTypes.run) or (battler.playerPokemon.selectedAction == battler.moveTypes.useItem)  or (battler.playerPokemon.selectedAction == battler.moveTypes.switchPokemon) ) then   -- If the player's selected move is to either use an item, run, or switch to a different pokemon...
        battler.movesFirst = battler.playerPokemon                                                                                                                                                                                  -- Set the first move to belong to the player's pokemon
        battler.movesSecond = battler.opposingPokemon                                                                                                                                                                               -- Set the second move to belong to the opposing pokemon
    
    elseif(battler.opposingPokemon.selectedAction == battler.moveTypes.run) then                                                                                                                                                   -- If the opposingPokemon selected to run...                                                                                                                                                                    
        battler.movesFirst = battler.opposingPokemon                                                                                                                                                                                -- Set the first move to belong to the opposing pokemon
        battler.movesSecond = battler.playerPokemon                                                                                                                                                                                 -- Set the second move to belong to the playerPokemon
    
    elseif (battler.playerPokemon.selectedAction == battler.moveTypes.performMove) then                                                                                                                                            -- Otherwise, if the player pokemon selected a move to perform...
        if (battler.playerPokemon.currentSpeed > battler.opposingPokemon.currentSpeed) then                                                                                                                                         -- If the player pokemon is faster than the opposing pokemon...
            battler.movesFirst = battler.playerPokemon                                                                                                                                                                                  -- Set the first move to belong to the player's pokemon
            battler.movesSecond = battler.opposingPokemon                                                                                                                                                                               -- Set the second move to belong to the opposing pokemon        
        else                                                                                                                                                                                                                        -- Otherwise...
            battler.movesFirst = battler.opposingPokemon                                                                                                                                                                                -- Set the first move to belong to the opposing pokemon
            battler.movesSecond = battler.playerPokemon     
        end                                                                                                                                                                            -- Set the second move to belong to the player's pokemon
    else
        battler.movesFirst = battler.opposingPokemon                                                                                                                                                                                -- Set the first move to belong to the opposing pokemon
        battler.movesSecond = battler.playerPokemon  
    end
end

-- Draws the Pokemon Information Cards
function battler.drawPokeInfoCards()
    love.graphics.setColor(0, 0, 0)
    love.graphics.printf(battler.opposingPokemon.name, battler.font, 5, 195, 325, "left")
    love.graphics.printf("Lv. " .. tostring(battler.opposingPokemon.level), battler.font, 420, 195, 550, "left")
    love.graphics.printf(battler.playerPokemon.name, battler.font, 1320, 575, 1500, "left")
    love.graphics.printf("Lv. " .. tostring(battler.playerPokemon.level), battler.font, 1720, 575, 1800, "left")
    love.graphics.printf("HP: " .. tostring(battler.playerPokemon.currentHealth) .. " / " .. tostring(battler.playerPokemon.baseHealth), battler.font, 1481, 702, 1700, "left")

    love.graphics.setColor(1, 1, 1)
    love.graphics.printf(battler.opposingPokemon.name, battler.font, 10, 195, 325, "left")
    love.graphics.printf("Lv. " .. tostring(battler.opposingPokemon.level), battler.font, 425, 195, 550, "left")
    love.graphics.printf(battler.playerPokemon.name, battler.font, 1325, 575, 1500, "left")
    love.graphics.printf("Lv. " .. tostring(battler.playerPokemon.level), battler.font, 1725, 575, 1800, "left")
    love.graphics.printf("HP: " .. tostring(battler.playerPokemon.currentHealth) .. " / " .. tostring(battler.playerPokemon.baseHealth), battler.font, 1486, 702, 1700, "left")

    -- Max Health: 250 health, 344 px
    love.graphics.setColor(0, 0.8, 0)
    if (battler.opposingPokemon.currentHealth >= 0) then
        love.graphics.rectangle("fill", 168, 264, (battler.opposingPokemon.currentHealth / battler.opposingPokemon.baseHealth) * 344, 32)
    end

    if (battler.playerPokemon.currentHealth >= 0) then
        love.graphics.rectangle("fill", 1488, 642, (battler.playerPokemon.currentHealth / battler.playerPokemon.baseHealth) * 344, 32)
    end
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- BATTLER STATE HANDLING FUNCTIONS --

function battler.loadPlayerPokemon(newPlayerPokemon)
    if (newPlayerPokemon ~= nil) then
        battler.playerPokemon = newPlayerPokemon
    end
    
    battler.moveButtons = {}

    -- PLAYER POKEMON SETUP --
    battler.playerPokemon.selectedAction = nil
    battler.playerPokemon.selectedMove = nil
    battler.playerPokemon.target = nil
    battler.playerPokemon.isBattling = true                                                                                                                                 -- Set the playerPokemon's battling status to true
    battler.playerPokemon.x = 0                                                                                                                                             -- Set the x-coordinate for the playerPokemon to be drawn at         
    battler.playerPokemon.y = 520                                                                                                                                           -- Set the y-coordinate for the playerPokemon to be drawn at
    
    if (battler.playerPokemon.isShiny) then                                                                                                                                 -- If the playerPokemon is shiny...
        battler.playerPokemon.currentAnimation = battler.playerPokemon.animations.shinyPlayerSide1                                                                               -- Set the current animation for the playerPokemon to be shinyBackFacing
    else                                                                                                                                                                    -- Otherwise...
        battler.playerPokemon.currentAnimation = battler.playerPokemon.animations.playerSide1                                                                                    -- Set the current animation for the playerPokemon to be backFacing
    end

    battler.clearPlayerPokemonMoves()
    battler.setPlayerPokemonMoves()
    battler.clearSwitchPokemonButtons()
    battler.setSwitchPokemonButtons()

    -- PLAYER BUTTONS SETUP --
    battler.actionButtons.fightButton = battler.loadButton(button.create(360, 90, 1150, 850, {0.8, 0, 0}, {1, 1, 1}, "Fight"))
    function battler.actionButtons.fightButton.performAction(button, mouseX, mouseY)
        battler.setButtonStates(battler.actionButtons, false)
        battler.setButtonStates(battler.moveButtons, true)
    end

    battler.actionButtons.bagButton = battler.loadButton(button.create(360, 90, 1530, 850, {0.8, 0.4, 0}, {1, 1, 1}, "Bag"))
    function battler.actionButtons.bagButton.performAction(button, mouseX, mouseY)
        battler.setButtonStates(battler.actionButtons, false)
    end

    battler.actionButtons.pokemonButton = battler.loadButton(button.create(360, 90, 1150, 959, {0, 0.4, 0}, {1, 1, 1}, "Pokemon"))
    function battler.actionButtons.pokemonButton.performAction(button, mouseX, mouseY)
        battler.setButtonStates(battler.actionButtons, false)
        battler.setButtonStates(battler.switchPokemonButtons, true)
    end

    battler.actionButtons.runButton = battler.loadButton(button.create(360, 90, 1530, 959, {0, 0, 0.8}, {1, 1, 1}, "Run"))
    function battler.actionButtons.runButton.performAction(button, mouseX, mouseY)
        battler.setButtonStates(battler.actionButtons, false)
        gameText.setText(battler.playerPokemon.name .. " fled the battle!")                                                           -- Set the gameText to indicate that the Pokemon has fled
        gameText.display()
        battler.playerPokemon.isBattling = false
    end
end


function battler.load()
    -- The tall grass should have code that will set the playerPokemon and opposingPokemon

    -- BATTLE TURN SYSTEM
    battler.movesFirst = nil
    battler.movesSecond = nil
    battler.bothMovesStarted = false

    -- BATTLE TIMERS
    battler.selectActionTimer = nil
    battler.performMoveTimer = nil
    battler.battleEndingTimer = nil
    battler.battleEnding = false

    -- BATTLE ACTION BUTTONS
    battler.actionButtons = {}
    battler.loadPlayerPokemon()

    battler.setPlayerPokemonMoves()                                                                                                                                         -- Creates the Pokemon move buttons based on the Player Pokemon's moves
    battler.setSwitchPokemonButtons()
    --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    -- OPPOSING POKEMON SETUP --
    battler.opposingPokemon.selectedAction = nil
    battler.opposingPokemon.selectedMove = nil
    battler.opposingPokemon.target = nil
    battler.opposingPokemon.isBattling = true                                                                                                                               -- Set the opposingPokemon's battling status to true
    battler.opposingPokemon.x = 1250                                                                                                                                        -- Sets the x-coordinate for the opposingPokemon to be drawn at         
       
    if (battler.opposingPokemon.types["type1"] == pokemonHandler.types.Flying or battler.opposingPokemon.types["type2"] == pokemonHandler.types.Flying) then                -- If the opposingPokemon is a flying type pokemon...
        battler.opposingPokemon.y = 50                                                                                                                                          -- Set the y-coordinate for the opposingPokemon to be higher up
    else                                                                                                                                                                    -- Otherwise...
        battler.opposingPokemon.y = 120                                                                                                                                         -- Set the y-coordinate of the opposingPokemon to be at a normal level
    end

    if (battler.opposingPokemon.isShiny) then                                                                                                                               -- If the opposingPokemon is shiny...
        battler.opposingPokemon.currentAnimation = battler.opposingPokemon.animations.shinyOpponentSide1                                                                          -- Set the current animation for the opposingPokemon to be shinyFrontFacing
    else                                                                                                                                                                    -- Otherwise...
        battler.opposingPokemon.currentAnimation = battler.opposingPokemon.animations.opponentSide1                                                                               -- Set the current animation for the opposingPokemon to be frontFacing
    end

    --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    

    
    -- REMAINING SETUP --
    gameText.setText("A wild " .. battler.opposingPokemon.name .. " has appeared!")                                                                                         -- Set the textbox's text to indicate that a wild pokemon has been encountered
    gameText.display()                                                                                                                                                      -- Display the textbox onto the screen
end


function battler.update(dt)
    if (gameText.active or gameText.movingDown) then                                                       -- If the textbox is active or moving down...
        if (gameText.getLifeSpan() > battler.gameTextLifeSpan) then                                           -- If the textbox has been alive for longer than the battler's set textbox lifespan...
            gameText.hide()                                                                                       -- Hide the textbox
        end

        battler.allowButtonPresses = false
        return
    else
        battler.allowButtonPresses = true
    end
    
    battler.updateButtons(dt)


    if( (battler.playerPokemon.currentHealth > 0 and battler.opposingPokemon.currentHealth > 0) and (battler.playerPokemon.isBattling and battler.opposingPokemon.isBattling)) then             -- If both pokemon still have health and haven't fled the battle...
        if (battler.playerPokemon.selectedAction == nil) then                                                                                                                                       -- If the playerPokemon hasn't selected a move...
            return
            -- Have the battler.scene display its 4 buttons (Attack, Bag, Pokemon, Run) (each button will lead to another sub-button, like how the Attack button will lead to 4 sub-buttons for each of the moves) (right-clicking should get info for a move)
            -- When a "final decision" button is pressed, have the button's actionPerformed do all of the following:
                -- set the battler.playerPokemon.action to be a function belonging to the pokemon depending on what button was pressed (attack(), useItem(), run(), throwPokeball(), etc.)
                -- set the battler.opposingPokemon.action to be a random move or to run away
                -- call battler.determineFirstMove
                -- call battler.startAction(battler.movesFirst)
            -- return
        else

            if (battler.movesFirst.performingAction) then               -- If the first move is in progress...
                battler.updateAction(battler.movesFirst, dt)                -- Update the action
                return                                                      -- Return until it finishes
            else
                if(battler.movesSecond.performingAction) then           -- If the second move is in progress...
                    battler.updateAction(battler.movesSecond, dt)                -- Update the action
                    return
                else
                    if (not battler.bothMovesperformed) then              -- If both moves haven't been performed yet...
                        battler.startAction(battler.movesSecond)                -- Start the second move
                        battler.bothMovesperformed = true                     -- Set bothMovesperformed to true now that both moves have performed (or at least started performing)
                        return
                    else
                        battler.movesFirst = nil
                        battler.movesSecond = nil
                        battler.playerPokemon.selectedAction = nil
                        battler.opposingPokemon.selectedAction = nil
                        battler.bothMovesperformed = false                     -- Set bothMovesperformed to false now to start the next round
                        battler.setButtonStates(battler.actionButtons, true)
                    end
                end
            end
        end
    else
        if (not battler.battleEnding) then
            battler.finish()
            return
        end

        if (battler.battleEnding) then
            nextScene = previousScene
        end
    end
end

function battler.draw()
    love.graphics.draw(battler.background, battler.x, battler.y)                                                                                    -- Draw the Battle background

    battler.drawButtons()                                                                                                                           -- Draw all of the active Buttons in the Scene
    love.graphics.setColor(1, 1, 1)                                                                                                                 -- Set the drawing color to white

    for i = 1, #battler.switchPokemonButtons do
        if (battler.switchPokemonButtons[i].active) then
            love.graphics.draw(pokemonHandler.spritesheet, player.pokemon[i].animations.inventorySprite.frames[2], battler.switchPokemonButtons[i].pokeSprite.x, battler.switchPokemonButtons[i].pokeSprite.y, 0, 2.5, 2.5)                        -- Draw the Pokemon's current Animation
        end
    end
    
    battler.playerPokemon:draw()                                                                                                                    -- Draw the Player's Pokemon
    battler.opposingPokemon:draw()                                                                                                                  -- Draw the opposing Pokemon
    love.graphics.draw(battler.pokeInfoCards)                                                                                                       -- Draw the Pokemon Information Cards (healthbar, experience, etc.)

    battler.drawPokeInfoCards()

    love.graphics.print(battler.opposingPokemon.types.type1.name, 100, 100)

    love.graphics.print(testThing, 200, 100)
    love.graphics.print(tostring(battler.battleEnding), 300, 100)
    love.graphics.print(tostring(battler.opposingPokemon.isBattling), 400, 100)
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

return battler