local battler =  scene.create("assets/images/battle_screen/battle_screen.jpg", 0, 0, nil)  -- Creates the battle Scene            (in this scene's load function, it should call battler.start)   -- Implement fade to and from black for scene transition 

battler.playerPokemon = {}
battler.playerPokemon.selectedMove = {}

battler.opposingPokemon = {}
battler.opposingPokemon.selectedMove = {}


battler.moveTypes = {}
battler.moveTypes.itemUse = 1
battler.moveTypes.run = 2
battler.moveTypes.switchPokemon = 3
battler.moveTypes.performMove = 4

battler.movesFirst = {}
battler.movesSecond = {}

battler.movesFirst = nil
battler.movesSecond = nil
battler.bothMovesStarted = false

battler.timer = nil
battler.textbox = textbox.create("Battler Textbox") -- create a textbox
-- calling battler.textBox.display() should play the fade in animation, then keep the text in the idle animation until battler.textBox.hide() is called
-- calling battler.textBox.hide() should play the fade out animation, then prevent the textBox from being drawn

battler.textBoxLifeSpan = 5 --seconds

local itemUseButton = battler.loadButton(button.create(WIDTH / 2, 100, (titleScreen.width / 2) - WIDTH / 4, (titleScreen.height / 2) - 50, {0, 0, 1}, {1, 1, 1}, "Play"))     -- Adds a play Button to the titleScreen Button list

-- Sets itemUseButton's action to be set the player's selected move type
function itemUseButton.performAction(button, mouseX, mouseY) 
    battler.playerPokemon.selectedMove = battler.moveTypes.itemUse
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- BATTLER FUNCTIONS --

function battler.start(playerPokemon, opposingPokemon)
    battler.playerPokemon = playerPokemon                                                                           -- Stores a reference to the playerPokemon
    battler.opposingPokemon = opposingPokemon                                                                       -- Stores a reference to the opposingPokemon

    battler.playerPokemon.x = 0                                                                                     -- Sets the x-coordinate for the playerPokemon to be drawn at         
    battler.playerPokemon.y = 520                                                                                   -- Sets the y-coordinate for the playerPokemon to be drawn at
    battler.playerPokemon.currentAnimation = battler.playerPokemon.animations.backFacing                            -- Sets the current animation for the opposingPokemon to be backFacing

    battler.opposingPokemon.x = 1250                                                                                -- Sets the x-coordinate for the opposingPokemon to be drawn at         
    battler.opposingPokemon.y = 10                                                                                  -- Sets the y-coordinate for the opposingPokemon to be drawn at
    battler.opposingPokemon.currentAnimation = battler.opposingPokemon.animations.frontFacing                       -- Sets the current animation for the opposingPokemon to be frontFacing

    battler.timer = 45                                                                                              -- Sets the battler.timer equal to 45 seconds

    -- display a textbox saying that a pokemon has appeared (textBox.setText(),  then textBox.display())
    battler.textbox.setText("A wild " .. tostring(battler.opposingPokemon.name) .. " has appeared!")                -- Sets the textbox's text to indicate that a wild pokemon has been encountered
    battler.textbox.display()                                                                                       -- Displays the textbox onto the screen
end

function battler.finish()
    -- display a textbox saying how the battle ended (pokemon ran out of health, run away, etc.)
    battler.textbox.setText("HOWEVER THE BATTLE ENDED")
    battler.textbox.display()

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

function battler.startMove(pokemon)
    -- call the function for the move selected by battler.movesFirst
        -- this should mark the pokemon.performingAction as true

    -- display a textbox saying what the pokemon's move is
        -- (playerPokemon used attack! or playerPokemon used a potion!)  (to trigger text use the textBox file functions (create(), setText(), display(this should trigger the fade in animation), getLifeSpan(), hide())
end


function battler.checkText()
    -- if (textBox.active AND "skip text" button hasn't been pressed AND textBox.getLifeSpan() < textBoxLifeSpan)
            -- return true because textBox is still alive
    -- else
        -- return false because textBox is dead
end

function battler.update(dt)
    if(battler.checkText()) then            -- if the text is active...
        return
    end

    if( (battler.playerPokemon.health > 0 and battler.opposingPokemon.health > 0) and (battler.playerPokemon.inBattle and battler.opposingPokemon.inBattle)) then           -- If both pokemon still have health and haven't fled the battle...
        if (battler.playerPokemon.action == nil and battler.timer > 0) then                                                                                                     -- If the playerPokemon hasn't selected a move and the timer hasn't run out...
            battler.timer = battler.timer - dt                                                                                                                                      -- Adjust the battle timer

            -- Have the battler.scene display its 4 buttons (Attack, Bag, Pokemon, Run) (each button will lead to another sub-button, like how the Attack button will lead to 4 sub-buttons for each of the moves) (right-clicking should get info for a move)
            -- When a "final decision" button is pressed, have the button's actionPerformed do all of the following:
                -- set the battler.playerPokemon.action to be a function belonging to the pokemon depending on what button was pressed (attack(), useItem(), run(), throwPokeball(), etc.)
                -- set the battler.opposingPokemon.action to be a random move or to run away
                -- call battler.determineFirstMove
                -- call battler.startMove(battler.movesFirst)
            -- return
        else
            if (battler.movesFirst.performingAction) then               -- If the first move is in progress...
                return                                                      -- return until it finishes
            else
                if(battler.movesSecond.performingAction) then           -- If the second move is in progress...
                    return
                else
                    if (not battler.bothMovesperformed) then              -- If both moves haven't been performed yet...
                        battler.startMove(battler.movesSecond)                -- Start the second move
                        battler.bothMovesperformed = true                     -- Set bothMovesperformed to true now that both moves have performed (or at least started performing)
                        return
                    end
                end
            end
        end
    else
        battler.finish()
    end
            

    -- else
        -- update all battle components (health bars, pokemon present/or run away)
                
        -- update the health
end

-- function battler.draw()

-- end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

return battler