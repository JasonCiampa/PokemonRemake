local battle =  scene.create("assets/images/battle_screen/battle_screen.jpg", 0, 0, "assets/audio/music/King Kaliente - Super Mario Galaxy.mp3")                                                                                                        -- Create the battle Scene

-- IMAGES --
battle.pokeInfoCards = love.graphics.newImage("assets/images/battle_screen/pokemon_info_cards.png")                                                                                             -- Store the image of the information cards for each Pokemon (name, level, health, experience, etc.)
battle.font = love.graphics.newFont("assets/fonts/showcard_gothic.ttf", 50)                                                                                                                     -- Store the font for the Battle Scene

-- ACTION TYPES --
battle.actions = {}                                                                                                                                                                             -- A list to store all of the possible actions a Player can select during battle
battle.actions.fight = 1                                                                                                                                                                        -- Represents the "Fight" action (using a Pokemon's move)
battle.actions.item = 2                                                                                                                                                                         -- Represents the "Item" action (using an item in the Player's inventory)
battle.actions.pokemon = 3                                                                                                                                                                      -- Represents the "Pokemon" action (switch out the current Pokemon and put a new one into battle)
battle.actions.run = 4                                                                                                                                                                          -- Represents the "Run" action (run away from the battle)

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- FUNCTIONS --

-- Handles a mouse-click in the Battle Scene
function battle.mousepressed(mouseX, mouseY)
    if (battle.allowButtonPresses) then                                                                                                                                                         -- If the Battle Scene is allowing Buttons to pressed...
        for i = 1, #battle.buttons do                                                                                                                                                               -- For every Button in the battle...
            if (battle.buttons[i].active) then                                                                                                                                                          -- If the Button is currently active...
                if (mouseInObject(battle.buttons[i], mouseX, mouseY)) then                                                                                                                                  -- If the mouse is currently inside of the Button...
                    battle.buttons[i]:isPressed(mouseX, mouseY)                                                                                                                                             -- Check if the Button was pressed
                end
            end
        end
    end
end

-- Returns the currently active Pokemon (whichever Pokemon's turn it is currently) and the currently inactive Pokemon respectively
function battle.getPokemonActiveStatuses()
    if (battle.currentTurn == 1) then                                                                                                                                                           -- If it is the first turn in the current round of the battle...
        return battle.turnOrder[1], battle.turnOrder[2]                                                                                                                                            -- Return the first pokemon in the battle.turnOrder list as the active Pokemon and the second as the inactive Pokemon
    elseif (battle.currentTurn == 2) then                                                                                                                                                       -- Otherwise, if it is the second turn in the current round of the battle...
        return battle.turnOrder[2], battle.turnOrder[1]                                                                                                                                            -- Return the second pokemon in the battle.turnOrder list as the active Pokemon and the first as the inactive Pokemon
    end
end

-- Sets the color for the given Pokemon's healthbar to be drawn in based on the amount of health it currently has
function battle.setHealthColor(pokemon)
    if (pokemon.currentHealth > pokemon.baseHealth * 0.5) then                                                                                                                                  -- If the Pokemon's health is greater than half of it's base health...
        love.graphics.setColor(0, 0.8, 0)                                                                                                                                                           -- Set the color to Green
    elseif (pokemon.currentHealth <= pokemon.baseHealth * 0.5 and pokemon.currentHealth > pokemon.baseHealth * 0.2) then                                                                        -- Otherwise, if the Pokemon's health is less than half but more than a fifth of it's base health...
        love.graphics.setColor(1, 0.8, 0)                                                                                                                                                           -- Set the color to Yellow
    elseif (pokemon.currentHealth <= pokemon.baseHealth * 0.2) then                                                                                                                             -- Otherwise, if the Pokemon's health is less than a fifth of it's base health...
        love.graphics.setColor(0.8, 0, 0)                                                                                                                                                           -- Set the color to Red
    end
end

-- Draws and updates the Pokemon Information Cards 
function battle.drawPokeInfoCards()
    love.graphics.draw(battle.pokeInfoCards)                                                                                                                                                    -- Draw the Pokemon Information Cards

    for i = 0, 1 do                                                                                                                                                                             -- For two iterations...
        local shiftX = i * 5                                                                                                                                                                        -- Set the shiftX value to be the iteration number * 5

        love.graphics.setColor(i, i, i)                                                                                                                                                         -- Set the drawing color based on the iteration number (black on first iteration, white on second)

        love.graphics.printf(battle.opposingPokemon.name, battle.font, 10 + shiftX, 195, 325, "left")                                                                                            -- Print the opposingPokemon's name onto the opposing info card
        love.graphics.printf("Lv. " .. tostring(battle.opposingPokemon.level), battle.font, 420 + shiftX, 195, 550, "left")                                                                     -- Print the opposingPokemon's level onto the opposing info card

        love.graphics.printf(battle.playerPokemon.name, battle.font, 1320 + shiftX, 575, 1500, "left")                                                                                          -- Print the playerPokemon's name onto the player info card
        love.graphics.printf("Lv. " .. tostring(battle.playerPokemon.level), battle.font, 1720 + shiftX, 575, 1800, "left")                                                                     -- Print the playerPokemon's level onto the player info card
        love.graphics.printf("HP: " .. tostring(math.floor(battle.playerPokemon.currentHealth)) .. " / " .. tostring(math.floor(battle.playerPokemon.baseHealth)), battle.font, 1481 + shiftX, 702, 1700, "left")       -- Print the playerPokemon's HP onto the player info card
    end

    battle.setHealthColor(battle.opposingPokemon)                                                                                                                                               -- Sets the drawing color based on the amount of health the opposingPokemon has
    love.graphics.rectangle("fill", 168, 264, (battle.opposingPokemon.currentHealth / battle.opposingPokemon.baseHealth) * 344, 32)                                                             -- Draws the opposingPokemon's healthbar (344 represents the healthbar width)

    battle.setHealthColor(battle.playerPokemon)                                                                                                                                                 -- Sets the drawing color based on the amount of health the playerPokemon has
    love.graphics.rectangle("fill", 1488, 640, (battle.playerPokemon.currentHealth / battle.playerPokemon.baseHealth) * 344, 32)                                                                -- Draws the playerPokemon's healthbar (344 represents the healthbar width)

    love.graphics.setColor(0, 0.78, 0.98)
    love.graphics.rectangle("fill", 1392, 760, (battle.playerPokemon.currentXP / battle.playerPokemon.goalXP) * 520, 16)
end

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- BUTTON FUNCTIONS --

-- Sets up the Player's Pokemon's move Buttons
function battle.setPokemonMoveButtons()
    for i = 1, 4 do                                                                                                                                                                             -- For each of the four moves that the playerPokemon has...
        local buttonX = 1150                                                                                                                                                                        -- Create a variable to store the x-coordinate of the Button
        local buttonY = 850                                                                                                                                                                         -- Create a variable to store the y-coordinate of the Button

        if (i % 2 == 0) then                                                                                                                                                                        -- If the move number is an even number...
            buttonX = 1530                                                                                                                                                                              -- Set the Button's x-coordinate to 1530
        end                                                                                                                                                                                            
        if (i > 2) then                                                                                                                                                                             -- If the move number is greater than 2...
            buttonY = 959                                                                                                                                                                               -- Set the Button's y-coordinate to 959
        end

        local move = battle.playerPokemon.moves["move" .. i]                                                                                                                                        -- Create a variable to temporarily store the move that this Button will represent                                                                                        
        local newMoveButton = battle.loadButton(button.create(360, 90, buttonX, buttonY, pokemonHandler.types[move.type].color, {1, 1, 1}, move.name, "center", 40))                                                      -- Create a variable to temporarily store the newMoveButton
        newMoveButton.active = false                                                                                                                                                                -- Disable the newMoveButton's active state

        function newMoveButton.performAction(button, mouseX, mouseY)                                                                                                                                -- Define the newMoveButton's action to perform when clicked on                                                                                                                          
            battle.setButtonStates(battle.pokemonMoveButtons, false)                                                                                                                                    -- Disable all of the pokemonMoveButtons

            if (move.category == "Status" and (move.type == "Grass" or move.type == "Steel")) then                                                                                                                                                         -- If the move is in the "Status" category...
                battle.playerPokemon.selectedAction = {battle.actions.fight, move, battle.playerPokemon}                                                                                                    -- Set the playerPokemon's action to be to fight using the move on itself
            else                                                                                                                                                                                        -- Otherwise...
                battle.playerPokemon.selectedAction = {battle.actions.fight, move, battle.opposingPokemon}                                                                                                  -- Set the playerPokemon's action to be to fight using the move on the opposingPokemon
            end

            battle.setTurnOrder()                                                                                                                                                                       -- Sets the turn order and begins the round of actions
        end

        table.insert(battle.pokemonMoveButtons, newMoveButton)                                                                                                                                  -- Insert the newMoveButton into the list of pokemonMoveButtons
    end
end

-- Sets up the Player's Pokemon Buttons for switching into battle
function battle.setPlayerPokemonButtons()
    for i = 1, #player.pokemon do                                                                                                                                                               -- For each of the Player's Pokemon...
        local buttonX = 1152                                                                                                                                                                        -- Set the Button's x-coordinate to 1152
        local buttonY = 790                                                                                                                                                                         -- Set the Button's y-coordinate to 790

        if (i % 2 == 0) then                                                                                                                                                                        -- If this iteration of the loop is an even number...
            buttonX = 1528                                                                                                                                                                              -- Set the Button's x-coordinate to 1528
        end 
        if (i > 2 and i < 5) then                                                                                                                                                                   -- If this iteration of the loop is the third or the fourth iteration...
            buttonY = 888                                                                                                                                                                               -- Set the Button's y-coordinate to 888
        elseif (i > 4) then                                                                                                                                                                         -- Otherwise, if this iteration of the loop is past the fourth iteration...
            buttonY = 986                                                                                                                                                                               -- Set the Button's y-coordinate to 986
        end

        local newPokemonButton = battle.loadButton(button.create(360, 88, buttonX, buttonY, {0, 0.24, 0}, {1, 1, 1}, player.pokemon[i].name, "center", 30))                                        -- Create a variable to temporarily store the newPokemonButton
        newPokemonButton.active = false                                                                                                                                                             -- Disable the newPokemonButton's active state
        newPokemonButton.pokeSprite = player.pokemon[i].animations.inventorySprite                                                                                                                     -- Create a table in the newPokemonButton that will store information for the little Pokemon sprite to be displayed
        newPokemonButton.pokeSprite.x = buttonX + 15                                                                                                                                                -- Set the pokeSprite's x-coordinate to be 15 more than the Button's x-coordinate
        newPokemonButton.pokeSprite.y = buttonY - 5                                                                                                                                                 -- Set the pokeSprite's y-coordinate to be 5 less than the Button's y-coordinate

        function newPokemonButton.performAction(button, mouseX, mouseY)                                                                                                                             -- Define the newPokemonButton's action to perform when clicked on...                                             
            if (battle.playerPokemon == player.pokemon[i] or player.pokemon[i].currentHealth <= 0) then                                                                                                 -- If the playerPokemon already in battle is the same as the Pokemon trying to be switched to OR the Pokemon that this Button is associated with is fainted...
                -- Play an error noise since you can't switch to the pokemon that is already out                                                                                                            -- Play an error sound since the Pokemon can't switch with itself
                return                                                                                                                                                                                      -- Return because there is no switch to be made
            end

            battle.setButtonStates(battle.playerPokemonButtons, false)                                                                                                                                -- Disable all of the playerPokemonButtons
            battle.playerPokemon.selectedAction = {battle.actions.pokemon, player.pokemon[i]}                                                                                                         -- Set the Pokemon's action to be to switch in the pokemon this Button is associated with
            battle.setTurnOrder()                                                                                                                                                                     -- Sets the turn order and begins the round of actions
        end

        function newPokemonButton.draw(button)                                                                                                                                                      -- Override the Button draw function
            if (button.active) then                                                                                                                                                                     -- If the Button is active...
                love.graphics.setColor(button.currentBackgroundColor)                                                                                                                                       -- Set the drawing color to the Button's background color
                love.graphics.rectangle("fill", button.x, button.y, button.width, button.height)                                                                                                            -- Draw the Button
    
                love.graphics.setColor(button.currentTextColor)                                                                                                                                             -- Set the drawing color to the Button's text color
                love.graphics.printf(button.text, button.font, button.x, (button.y + (button.height / 2)) - (button.fontSize * 0.4), button.width, button.textAlignment)                                    -- Print the Button's text onto the Button

                love.graphics.draw(pokemonHandler.spritesheet, button.pokeSprite.frames[button.pokeSprite.currentFrameNum], button.pokeSprite.x, button.pokeSprite.y, 0, 2.5, 2.5)                          -- Draw the mini Pokemon Sprite's current Animation
            end
        end

        function newPokemonButton.update(button, dt)                                                                                                                                                -- Override the Button update function
            if (button.active) then                                                                                                                                                                     -- If the Button is active...
                button:mouseHovering()                                                                                                                                                                      -- Check if the mouse is hovering over it
            end

            button.pokeSprite.updatable = true                                                                                                                                                          -- Allow the mini Pokemon Sprite to be updated
            button.pokeSprite.update(dt)                                                                                                                                                                -- Update the mini Pokemon Sprite
        end

        table.insert(battle.playerPokemonButtons, newPokemonButton)                                                                                                                             -- Insert the newPokemonButton into the list of playerPokemonButtons
    end
end

-- Sets up the Player's action Buttons
function battle.setPlayerActionButtons()
    battle.playerActionButtons.fightButton = battle.loadButton(button.create(360, 90, 1150, 850, {0.8, 0, 0}, {1, 1, 1}, "Fight"))                                                              -- Creates the "Fight" Button
    function battle.playerActionButtons.fightButton.performAction(button, mouseX, mouseY)                                                                                                       -- Defines the "Fight" Button's action to perform when clicked on
        battle.setButtonStates(battle.playerActionButtons, false)                                                                                                                                   -- Disable all of the playerActionButtons
        battle.setButtonStates(battle.pokemonMoveButtons, true)                                                                                                                                     -- Enable all of the pokemonMoveButtons
    end
    
    battle.playerActionButtons.bagButton = battle.loadButton(button.create(360, 90, 1530, 850, {0.8, 0.4, 0}, {1, 1, 1}, "Bag"))                                                                -- Creates the "Bag" Button
    function battle.playerActionButtons.bagButton.performAction(button, mouseX, mouseY)                                                                                                         -- Defines the "Bag" Button's action to perform when clicked on

    end
    
    battle.playerActionButtons.pokemonButton = battle.loadButton(button.create(360, 90, 1150, 959, {0, 0.4, 0}, {1, 1, 1}, "Pokemon"))                                                          -- Creates the "Pokemon" Button
    function battle.playerActionButtons.pokemonButton.performAction(button, mouseX, mouseY)                                                                                                     -- Defines the "Pokemon" Button's action to perform when clicked on
        battle.setButtonStates(battle.playerActionButtons, false)                                                                                                                                   -- Disable all of the playerActionButtons
        battle.setButtonStates(battle.playerPokemonButtons, true)                                                                                                                                   -- Enable all of the playerPokemonButtons   
    end
    
    battle.playerActionButtons.runButton = battle.loadButton(button.create(360, 90, 1530, 959, {0, 0, 0.8}, {1, 1, 1}, "Run"))                                                                  -- Creates the "Run" Button
    function battle.playerActionButtons.runButton.performAction(button, mouseX, mouseY)                                                                                                         -- Defines the "Pokemon" Button's action to perform when clicked on
        battle.setButtonStates(battle.playerActionButtons, false)                                                                                                                                   -- Disable all of the playerActionButtons
        battle.playerPokemon.selectedAction = {battle.actions.run}                                                                                                                                  -- Sets the playerPokemon's action to be to run
        battle.setTurnOrder()                                                                                                                                                                       -- Sets the turnOrder for the round and starts the round
    end
end

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- TURN HANDLING FUNCTIONS --

-- Sets the order for the Pokemon to carry out their actions
function battle.setTurnOrder()
    local move = battle.opposingPokemon.moves["move" .. tostring(love.math.random(1, 4))]                                                                                                      -- Randomly select one of the four possible opposingPokemon moves and store it in a variable
    if (move.category == "Status" and (move.type == "Grass" or move.type == "Steel")) then                                                                                                                                                        -- If the move is in the "Status" category...
        battle.opposingPokemon.selectedAction = {battle.actions.fight, move, battle.opposingPokemon}                                                                                                -- Set the Pokemon's selected action to be to fight using the move on itself
    else                                                                                                                                                                                       -- Otherwise...
        battle.opposingPokemon.selectedAction = {battle.actions.fight, move, battle.playerPokemon}                                                                                                 -- Set the Pokemon's selected action to be to fight using the move on the playerPokemon
    end

    if (battle.opposingPokemon.selectedAction[1] == battle.actions.run) then                                                                                                                    -- Otherwise, if the opposingPokemon's selected action is to run...
        battle.turnOrder = {battle.opposingPokemon, battle.playerPokemon}                                                                                                                           -- Set the first turn to belong to the opposingPokemon and the second turn to belong to the playerPokemon
    elseif (battle.playerPokemon.selectedAction[1] ~= battle.actions.fight) then                                                                                                                    -- If the player's selected move is to either use an item, run, or switch to a different pokemon...
        battle.turnOrder = {battle.playerPokemon, battle.opposingPokemon}                                                                                                                           -- Set the first turn to belong to the playerPokemon and the second turn to belong to the opposingPokemon
    else                                                                                                                                                                                        -- Otherwise, the playerPokemon must be fighting, so...
        if (battle.playerPokemon.currentSpeed > battle.opposingPokemon.currentSpeed) then                                                                                                           -- If the player pokemon is faster than the opposing pokemon...
            battle.turnOrder = {battle.playerPokemon, battle.opposingPokemon}                                                                                                                          -- Set the first turn to belong to the playerPokemon and the second turn to belong to the opposingPokemon
        else                                                                                                                                                                                        -- Otherwise...
            battle.turnOrder = {battle.opposingPokemon, battle.playerPokemon}                                                                                                                          -- Set the first turn to belong to the opposingPokemon and the second turn to belong to the playerPokemon
        end
    end

    battle.currentTurn = 1                                                                                                                                                                      -- Set the Battle's currentTurn value to 1 (the first turn)
    battle.roundInProgress = true                                                                                                                                                               -- Set the Battle's roundInProgress state to true so that the round begins
    battle.describeAction()
end


-- Sets the textbox to describe what the selected action is for the Pokemon whose turn it is currently
function battle.describeAction()
    local activePokemon, inactivePokemon = battle.getPokemonActiveStatuses()                                                                                                                    -- Determines which Pokemon's turn it currently is and which Pokemon's turn it currently isn't

    if (activePokemon.selectedAction[1] == battle.actions.fight) then                                                                                                                           -- If the activePokemon's selected action is to fight...
        gameText.setText(activePokemon.name .. " uses " .. activePokemon.selectedAction[2].name .. "!")                                                                                             -- Set the text of the gameText textbox to indicate that the activePokemon is using the move they selected
        -- Set a 2 second timer for animation
    elseif (activePokemon.selectedAction[1] == battle.actions.item) then                                                                                                                        -- Otherwise, if the activePokemon's selected action is to use an item...
        gameText.setText(activePokemon.name .. " uses a " .. activePokemon.selectedAction[2].name .. "!")                                                                                           -- Set the text of the gameText textbox to indicate that the activePokemon is using the item they selected
    elseif (activePokemon.selectedAction[1] == battle.actions.pokemon) then                                                                                                                     -- Otherwise, if the activePokemon's selected action is to switch out of the battle...
        gameText.setText(activePokemon.name .. " come back!")                 -- Set the text of the gameText textbox to indicate that the activePokemon is switching out of battle
    elseif (activePokemon.selectedAction[1] == battle.actions.run) then                                                                                                                         -- Otherwise, if the activePokemon's selected action is to run away from the battle...
        gameText.setText(activePokemon.name .. " is running away from the battle!")                                                                                                  -- Set the text of the gameText textbox to indicate that the activePokemon is running away from the battle
    end

    gameText.display()                                                                                                                                                                          -- Display the gameText textbox
    
end

-- Updates the animation for the selected action of the Pokemon whose turn it is currently
function battle.updateActionAnimation(dt)
    local activePokemon, inactivePokemon = battle.getPokemonActiveStatuses()                                                                                                                    -- Determines which Pokemon's turn it currently is and which Pokemon's turn it currently isn't
    
    if (activePokemon.selectedAction[1] == battle.actions.fight) then                                                                                                                           -- If the activePokemon's selected action is to fight...
        -- Check the timer that was set in the battle.describeAction area
        -- If the timer isn't at 0, update the animation
        activePokemon.selectedAction[2].currentAnimation.update(dt)                                                                                                                                 -- Update the animation for the move being used
    elseif (activePokemon.selectedAction[1] == battle.actions.item) then                                                                                                                        -- If the activePokemon's selected action is to use an item...                                                                                                    

    elseif (activePokemon.selectedAction[1] == battle.actions.pokemon) then                                                                                                                     -- If the activePokemon's selected action is to switch out of the battle...

    elseif (activePokemon.selectedAction[1] == battle.actions.run) then                                                                                                                         -- If the activePokemon's selected action is to run from the battle...

    end
end

-- Processes the logic for the selected action of the Pokemon whose turn it is currently
function battle.processAction()
    local activePokemon, inactivePokemon = battle.getPokemonActiveStatuses()                                                                                                                    -- Determines which Pokemon's turn it currently is and which Pokemon's turn it currently isn't

    if (activePokemon.selectedAction[1] == battle.actions.fight) then                                                                                                                           -- If the activePokemon's selected action is to fight...
        return activePokemon.useMove(activePokemon.selectedAction[2], activePokemon.selectedAction[3])                                                                                                     -- Use the activePokemon's selected move on the activePokemon's selected target
    elseif (activePokemon.selectedAction[1] == battle.actions.item) then                                                                                                                        -- If the activePokemon's selected action is to use an item.-- activePokemon.useItem(activePokemon.selectedAction[2], activePokemon.selectedAction[3])                                                                                                   
        -- activePokemon.useItem(activePokemon.selectedAction[2], activePokemon.selectedAction[3])                                                                                                  -- Use the activePokemon's selected item on the activePokemon's selected target
    elseif (activePokemon.selectedAction[1] == battle.actions.pokemon) then                                                                                                                     -- If the activePokemon's selected action is to switch out of the battle...
        battle.loadPlayerPokemon(activePokemon.selectedAction[2])
        return (battle.playerPokemon.name .. ", go get em champ!")
    elseif (activePokemon.selectedAction[1] == battle.actions.run) then                                                                                                                         -- If the activePokemon's selected action is to run...
        battle.finished = true
        return nil
    end
end

-- Checks the progress of the battle
function battle.checkProgress()
    if (battle.playerPokemon.currentHealth <= 0) then
        battle.roundInProgress = false
        gameText.setText(battle.playerPokemon.name .. " has fainted!")
        gameText.display()

        local otherPokemon = false
        for i = 1, #player.pokemon do
            if (player.pokemon[i].currentHealth > 0) then
                battle.setButtonStates(battle.playerPokemonButtons, true)
                otherPokemon = true
                break
            end
        end

        if (not otherPokemon) then
            battle.finished = true
        end


    elseif (battle.opposingPokemon.currentHealth <= 0) then
        battle.roundInProgress = false
        gameText.setText(battle.opposingPokemon.name .. " has fainted!")
        gameText.display()
        battle.finished = true
        battle.playerPokemon.currentXP = battle.playerPokemon.currentXP + 1000
        if (battle.playerPokemon.currentXP >= battle.playerPokemon.goalXP) then
            battle.playerPokemon:levelUp()
        end

        -- IMPLEMENT SOME WAY OF GIVING XP TO PLAYER POKEMON
    end
end

-- Ends the Battle by switching out of the Scene
function battle.finish()
    nextScene = previousScene
end

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Loads the given Pokemon as the Player's pokemon into the battle
function battle.loadPlayerPokemon(pokemon)
    battle.playerPokemon = pokemon                                                                                                                                                              -- Sets the given Pokemon to be in battle
    battle.playerPokemon.x = 0                                                                                                                                                                  -- Sets the Player Pokemon's x-coordinate
    battle.playerPokemon.y = 520                                                                                                                                                                -- Sets the playerPokemon's y-coordinate
    battle.playerPokemon.selectedAction = nil                                                                                                                                                   -- Sets the playerPokemon's selectedAction to be nil currently (this value will be a table containing the {actionType, pokemonMove, actionTarget})
    
    -- BUTTON SETUP --
    battle.playerActionButtons = {}                                                                                                                                                             -- This will store Buttons for the Player to choose their Pokemon's action for the turn (Fight, Bag, Pokemon, Run)
    battle.pokemonMoveButtons = {}                                                                                                                                                              -- This will store Buttons for each of the Player's Pokemon's four moves
    battle.playerPokemonButtons = {}                                                                                                                                                            -- This will store Buttons for each of the Player's Pokemon
    battle.allowButtonPresses = false                                                                                                                                                           -- This will store whether or not the Player is allowed to click on Buttons currently
    
    battle.setPokemonMoveButtons()                                                                                                                                                              -- Sets the move Buttons based on the playerPokemon's moves
    battle.setPlayerPokemonButtons()                                                                                                                                                            -- Sets the Player's Pokemon Buttons for switching into battle
    battle.setPlayerActionButtons()                                                                                                                                                             -- Sets the Player's action Buttons

    if (battle.opposingPokemon.selectedAction ~= nil and battle.opposingPokemon.selectedAction[2] ~= battle.opposingPokemon) then                                                               -- If the opposingPokemon has selected an action involving the playerPokemon...
        battle.opposingPokemon.selectedAction[3] = battle.playerPokemon                                                                                                                             -- Reset the action to make sure it has the latest loaded playerPokemon
    end
end

-- BATTLE LOAD --

function battle.load()
    battle.backgroundMusic:setVolume(0.15)                                           -- Sets the Scene's background music volume to 15%
    love.audio.play(battle.backgroundMusic)

    -- POKEMON SETUP --
    battle.opposingPokemon = pokemonHandler.loadPokemon(nil, love.math.random(1, 100), love.math.random(10, 75))                                                                                                     -- Loads in a random Pokemon at a level between 10 and 20 100
    battle.opposingPokemon.selectedAction = nil                                                                                                                                                 -- This will store the opposingPokemon's selected action for their turn (this value will be a table containing the {actionType, pokemonMove, actionTarget})

    for i = 1, #player.pokemon do
        if (player.pokemon[i].currentHealth > 0) then
            battle.loadPlayerPokemon(player.pokemon[i])
            break
        end
    end

    -- TURN / ROUND SYSTEM SETUP --
    battle.turnOrder = {}                                                                                                                                                                       -- This will store the two Pokemon in the order in which they'll play their turns
    battle.currentTurn = nil                                                                                                                                                                    -- This will store the index of the Pokemon whose turn it currently is (1 or 2)  
    battle.roundInProgress = false                                                                                                                                                              -- This will keep track of whether or not a round is in progress (used to start/end rounds)
    battle.finished = false                                                                                                                                                                    -- This will keep track of whether or not the battle should be ending

    -- TEXT SETUP --
    gameText.setText("A wild " .. battle.opposingPokemon.name .. " has appeared!")                                                                                                              -- Set the gameText textbox's text to indicate that a wild pokemon has been encountered
    gameText.display()                                                                                                                                                                          -- Display the gameText textbox
end

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- BATTLE UPDATE --

function battle.update(dt)
    if (gameText.active) then                                                                                                                                                                   -- If the gameText textbox is currently active...   
        battle.allowButtonPresses = false                                                                                                                                                           -- Disable allowButtonPresses so that the Player can't interact while the textbox is up
        return
    else                                                                                                                                                                                        -- Otherwise...
        battle.allowButtonPresses = true                                                                                                                                                            -- Enable allowButtonPresses so that the Player can interact again
    end

    if (battle.finished) then
        battle.finish()
        return
    end


    if (battle.roundInProgress) then                                                                                                                                                            -- If a round is in progress...
        if (battle.currentTurn == 1) then                                                                                                                                                           -- If the first Pokemon is up to play their turn...
            local text = battle.processAction()
            
            if (text ~= nil) then
                gameText.setText(text)                                                                                                                                                                      -- Process their action (action was already described in the setTurnOrder function)
                gameText.display()
            end
            battle.currentTurn = battle.currentTurn + 0.5                                                                                                                                                 -- Move onto the next Pokemon's turn
        elseif (battle.currentTurn == 1.5) then
            battle.checkProgress()
            if (battle.roundInProgress) then
                battle.currentTurn = battle.currentTurn + 0.5                                                                                                                                                 -- Move onto the next Pokemon's turn
                battle.describeAction()                                                                                                                                                                     -- Describe the action for the next Pokemon (the currentTurn was incremented in the process function)
            end
        elseif (battle.currentTurn == 2) then                                                                                                                                -- If the second Pokemon is up to play their turn...
            gameText.setText(battle.processAction())                                                                                                                                                                      -- Process their action
            gameText.display()
            battle.currentTurn = battle.currentTurn + 0.5                                                                                                                                                 -- Move onto the next Pokemon's turn
        elseif (battle.currentTurn == 2.5) then
            battle.checkProgress()
            if (battle.roundInProgress) then
                battle.currentTurn = battle.currentTurn + 0.5                                                                                                                                                 -- Move onto the next Pokemon's turn
            end
        else
            battle.turnOrder = {}                                                                                                                                                                   -- Otherwise, both Pokemon must have played their turns, so...
            battle.currentTurn = nil                                                                                                                                                                    -- Reset the currentTurn
            battle.roundInProgress = false                                                                                                                                                              -- End the round
            battle.setButtonStates(battle.playerActionButtons, true)                                                                                                                                    -- Enable the playerActionButtons
        end
    else                                                                                                                                                                                        -- Otherwise...
        battle.updateButtons(dt)                                                                                                                                                                    -- Update all of the Scene's active Buttons
    end
end

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- BATTLE DRAW --

function battle.draw()

    -- BACKGROUND -- 
    love.graphics.draw(battle.background, battle.x, battle.y)                                                                                                                                   -- Draw the Battle background
    
    -- POKEMON IN BATTLE --
    battle.playerPokemon:draw()                                                                                                                                                                 -- Draw the Player's Pokemon
    battle.opposingPokemon:draw()                                                                                                                                                               -- Draw the opposing Pokemon

    -- POKEMON INFO CARDS --
    battle.drawPokeInfoCards()                                                                                                                                                                  -- Draw the Pokemon Information Cards

    -- BUTTONS --
    battle.drawButtons()                                                                                                                                                                        -- Draw the active Buttons in the Battle Scene
end

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

return battle