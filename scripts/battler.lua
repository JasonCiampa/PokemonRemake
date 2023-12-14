local battler = {}  
battler.scene =  -- scene.create("assets/images/battle/", 0, 0, nil)  -- Creates the battle Scene            (in this scene's load function, it should call battler.start)   -- Implement fade to and from black for scene transition


battler.playerPokemon = {}
battler.opposingPokemon = {}

battler.movesFirst = nil
battler.movesSecond = nil
battler.bothMovesStarted = false

battler.timer = nil
battler.textBox = nil -- create a textbox
-- calling battler.textBox.display() should play the fade in animation, then keep the text in the idle animation until battler.textBox.hide() is called
-- calling battler.textBox.hide() should play the fade out animation, then prevent the textBox from being drawn
battler.textBoxLifeSpan = 5 --seconds

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- BATTLER FUNCTIONS --

function battler.start(playerPokemon, opposingPokemon)
    battler.playerPokemon = playerPokemon
    battler.opposingPokemon = opposingPokemon

    battler.playerPokemon.x = 0                                                         -- Sets the x-coordinate for the playerPokemon to be drawn at         
    battler.playerPokemon.y = 1000                                                      -- Sets the y-coordinate for the playerPokemon to be drawn at

    battler.opposingPokemon.x = 1250                                                    -- Sets the x-coordinate for the opposingPokemon to be drawn at         
    battler.opposingPokemon.y = 10                                                      -- Sets the y-coordinate for the opposingPokemon to be drawn at

    battler.timer = 45                                                                  -- Sets the battler.timer equal to 45 seconds

    -- display a textbox saying that a pokemon has appeared (textBox.setText(),  then textBox.display())
end

function battler.finish()
    -- display a textbox saying how the battle ended (pokemon ran out of health, run away, etc.)

    battler.playerPokemon = nil
    battler.opposingPokemon = nil

    battler.bothMovesStarted = false
end

function battler.determineFirstMove()
    -- check what kind of move is being made by both pokemon (item use, run, switch pokemon, attack)
        -- item use, run, or switch pokemon would occur before an attack
        -- if both pokemon are attacking, whichever pokemon is faster will attack first

    -- set battler.movesFirst to the pokemon who moves first
    -- set battler.movesSecond to the pokemon who moves second
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

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

return battler