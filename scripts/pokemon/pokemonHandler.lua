-- To parse out move data from HTML of pokemondb.net, look for a table with a class called "vitals-table"
-- Inside of that table is a tbody, and inside of the tbody is the data in the following order:
-- Type, Category, Power, Accuracy, PP

-- A types table to hold all 17 pokemon types

local pokemonHandler = {}

pokemonHandler.spritesheet = love.graphics.newImage("assets/images/pokemon/pokemon_spritesheet.png")     --https://www.spriters-resource.com/ds_dsi/pokemonheartgoldsoulsilver/sheet/132566/

pokemonHandler.types = {}

-- Creates a pokemon type with tables indicating what other types it is super effective towards, not very effective towards, or has no effect towards.
function pokemonHandler.makePokemonType(name, superEffectiveTowards, notVeryEffectiveTowards, noEffectTowards, color)
    local typeTable = {}
    
    typeTable.name = name
    typeTable.superEffectiveTowards = superEffectiveTowards
    typeTable.notVeryEffectiveTowards = notVeryEffectiveTowards
    typeTable.noEffectTowards = noEffectTowards
    typeTable.color = color

    return typeTable
end

-- Creates all 17 pokemon types
-- SWITCH THIS TO BE TYPE NAMES RATHER THAN POKEMONHANDLER.TYPES.TYPE
pokemonHandler.types.Bug = pokemonHandler.makePokemonType("Bug", {"Dark", "Grass", "Psychic"}, {"Fighting", "Fire", "Flying", "Ghost", "Poison", "Steel"}, {}, {0, 0.42, 0})
pokemonHandler.types.Dark = pokemonHandler.makePokemonType("Dark", {"Ghost", "Psychic"}, {"Dark", "Fighting", "Steel"}, {}, {0.1, 0.1, 0.1})
pokemonHandler.types.Dragon = pokemonHandler.makePokemonType("Dragon", {"Dragon"}, {"Steel"}, {}, {0.24, 0.33, 1})
pokemonHandler.types.Electric = pokemonHandler.makePokemonType("Electric", {"Flying", "Water"}, {"Dragon", "Electric", "Grass"}, {"Ground"}, {0.89, 0.74, 0})
pokemonHandler.types.Fighting = pokemonHandler.makePokemonType("Fighting", {"Dark", "Ice", "Normal", "Rock", "Steel"}, {"Bug", "Flying", "Poison", "Psychic"}, {"Ghost"}, {0.5, 0, 0})
pokemonHandler.types.Fire = pokemonHandler.makePokemonType("Fire", {"Bug", "Grass", "Ice", "Steel"}, {"Dragon", "Fire", "Rock", "Water"}, {}, {1, 0.3, 0})
pokemonHandler.types.Flying = pokemonHandler.makePokemonType("Flying", {"Bug", "Fighting", "Grass"}, {"Electric", "Rock", "Steel"}, {}, {0.68, 1, 1})
pokemonHandler.types.Ghost = pokemonHandler.makePokemonType("Ghost", {"Ghost", "Psychic"}, {"Dark", "Steel"}, {"Normal"}, {0.33, 0.23, 0.68})
pokemonHandler.types.Grass = pokemonHandler.makePokemonType("Grass", {"Ground", "Rock", "Water"}, {"Bug", "Dragon", "Fire", "Flying", "Grass", "Poison", "Steel"}, {}, {0.25, 0.83, 0})
pokemonHandler.types.Ground = pokemonHandler.makePokemonType("Ground", {"Electric", "Fire", "Poison", "Rock", "Steel"}, {"Bug", "Grass"}, {"Flying"}, {0.7, 0.38, 0})
pokemonHandler.types.Ice = pokemonHandler.makePokemonType("Ice", {"Dragon", "Flying", "Grass", "Ground"}, {"Fire", "Ice", "Steel", "Water"}, {}, {0, 1, 1})
pokemonHandler.types.Normal = pokemonHandler.makePokemonType("Normal", {}, {"Rock", "Steel"}, {"Ghost"}, {0.5, 0.5, 0.5})
pokemonHandler.types.Poison = pokemonHandler.makePokemonType("Poison", {"Grass"}, {"Ghost", "Ground", "Poison", "Rock"}, {"Steel"}, {0.37, 0.14, 1})
pokemonHandler.types.Psychic = pokemonHandler.makePokemonType("Psychic", {"Fighting", "Poison"}, {"Psychic", "Steel"}, {"Dark"}, {0.81, 0, 1})
pokemonHandler.types.Rock = pokemonHandler.makePokemonType("Rock", {"Bug", "Fire", "Flying", "Ice"}, {"Fighting", "Ground", "Steel"}, {}, {0.33, 0.17, 0})
pokemonHandler.types.Steel = pokemonHandler.makePokemonType("Steel", {"Ice", "Rock"}, {"Electric", "Fire", "Steel", "Water"}, {}, {0.75, 0.75, 0.75})
pokemonHandler.types.Water = pokemonHandler.makePokemonType("Water", {"Fire", "Ice", "Rock"}, {"Dragon", "Grass", "Water"}, {}, {0, 0.32, 0.75})

--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--

-- Creates a moves table for each Pokemon type that will hold all moves belonging to that type
for pokeTypes, pokeType in pairs(pokemonHandler.types) do
    pokeType.moves = {}
end

function pokemonHandler.makePokemonMove(name, moveType, category, statsAffected, power, accuracy, powerPoints, effectDescription, animations)
    local move = {}

    move.name = name
    move.type = moveType                        -- Any type (Grass, Fire, Water, etc.)
    move.category = category                    -- Status, Physical, or Special
    move.statsAffected = statsAffected          -- Table of Pokemon stats that are affected by the move (health, attack, defense, sp attack, sp defense, speed, accuracy) (pokemon[stat] would get the Pokemon's stat)
    move.power = power                          -- Number to represent how much power a move has
    move.accuracy = accuracy                    -- The likelihood that a move will successfully land (%)
    move.basePP = powerPoints                   -- The number of times the move can be used before fully exhausted
    move.currentPP = move.basePP                -- The amount of PP the move currently has remaining
    move.effectDescription = effectDescription  -- Description of the move's effect (string of text)
    move.animations = animations                -- Animations for the move
    -- move.currentAnimation = move.animations[1]

    -- MAKE POKEMON MOVE ANIMATIONS BE BASED ON COORDINATES (HAVE THE POKEMON MOVE TO A CERTAIN X AND Y AT CERTAIN KEYFRAMES ???)

    table.insert(pokemonHandler.types[moveType].moves, move)

    -- Resets the move's current PP so that it has the base PP
    function resetPP()
        move.currentPP = move.basePP
    end

    return move
end


-- Normal Type Moves
pokemonHandler.makePokemonMove("Tackle", "Normal", "Physical", {}, 40, 100, 35, "The Pokemon charges and slams into the target with their whole body.")                              
pokemonHandler.makePokemonMove("Growl", "Normal", "Status", {"Attack"}, 0, 100, 40, "The Pokemon growls at their target very menacingly. (Decreases Attack Power)")                  
pokemonHandler.makePokemonMove("Leer", "Normal", "Status", {"Defense"}, 0, 100, 30, "The Pokemon terrifyingly stares at their target. (Decreases Defense)")                          
pokemonHandler.makePokemonMove("Smokescreen", "Normal", "Status", {"Accuracy"}, 0, 100, 20, "The Pokemon releases an obscuring cloud of smoke. (Decreases Accuracy)")                

-- Grass Type Moves
pokemonHandler.makePokemonMove("Razor Leaf", "Grass", "Physical", {}, 55, 95, 25, "The Pokemon launches sharp-edged leaves at their target.")                                        
pokemonHandler.makePokemonMove("Synthesis", "Grass", "Status", {"Health"}, 0, 0, 100, 5, "The Pokemon restores their own HP. (Increases Health)")                                    

-- Fire Type Moves
pokemonHandler.makePokemonMove("Flame Wheel", "Fire", "Physical", {}, 60, 100, 25, "The Pokemon produces a flame around themself and rolls towards their target with force.")        
pokemonHandler.makePokemonMove("Flamethrower", "Fire", "Special", {}, 90, 100, 15, "The Pokemon unleashes an intense blast of fire at their target.")                                

-- Water Type Moves
pokemonHandler.makePokemonMove("Water Gun", "Water", "Special", {}, 40, 100, 25, "The Pokemon shoots out a forceful shot of Water at their target.")                                 
pokemonHandler.makePokemonMove("Hydro Pump", "Water", "Special", {}, 110, 80, 5, "The Pokemon releases a huge volume of water with immense pressure at their target.")               

-- Dark Type Moves
pokemonHandler.makePokemonMove("Bite", "Dark", "Physical", {}, 60, 100, 25, "The Pokemon forcefully buries their teeth into their target.")                                          
pokemonHandler.makePokemonMove("Night Slash", "Dark", "Physical", {}, 70, 100, 15, "The Pokemon slashes their target with a dark aura.")                                             

-- Psychic Type Moves
pokemonHandler.makePokemonMove("Confusion", "Psychic", "Special", {"Accuracy"}, 50, 100, 25, "The Pokemon projects a weak telekinetic force onto their target. (Decreases Accuracy)")                               
pokemonHandler.makePokemonMove("Psychic", "Psychic", "Special", {"SpecialDefense"}, 90, 100, 10, "The Pokemon projects a strong telekinetic force onto their target. (Decrease Special Defense)")                        

-- Flying Type Moves
pokemonHandler.makePokemonMove("Air Cutter", "Flying", "Special", {}, 60, 95, 25, "The Pokemon launches a blast of piercing air towards their target.")                                                              
pokemonHandler.makePokemonMove("Gust", "Flying", "Special", {}, 40, 100, 35, "The Pokemon directs a strong gust of wind towards their target.")                                   

-- Poison Type Moves
pokemonHandler.makePokemonMove("Poison Fang", "Poison", "Special", {"SpecialDefense"}, 50, 100, 15, "The Pokemon injects their target with poison by viciously biting them. (Decreases Special Defense)")                        
pokemonHandler.makePokemonMove("Poison Jab", "Poison", "Physical", {"SpecialAttack"}, 80, 100, 20, "The Pokemon lands a poisonous jab on their target. (Decreases Special Attack)")                       

-- Ghost Type Moves
pokemonHandler.makePokemonMove("Astonish", "Ghost", "Special", {"Accuracy"}, 30, 100, 15, "The Pokemon astonishes the target. (Decreases Accuracy)")                              
pokemonHandler.makePokemonMove("Shadow Ball", "Ghost", "Special", {"SpecialDefense"}, 80, 100, 15, "The Pokemon shoots a ball with a dark aura at their target. (Decreases Special Defense)")                            

-- Electric Type Moves
pokemonHandler.makePokemonMove("Shock Wave", "Electric", "Physical", {}, 60, 100, 20, "The Pokemon unleashes a wave of electricity at their target.")                               
pokemonHandler.makePokemonMove("Thunder Bolt", "Electric", "Physical", {}, 90, 100, 15, "The Pokemon launches a piercing bolt of lightning at their target.")                         

-- Rock Type Moves
pokemonHandler.makePokemonMove("Rock Slide", "Rock", "Physical", {}, 75, 90, 10, "The Pokemon hurls an avalanche of rocks towards their target.")                       
pokemonHandler.makePokemonMove("Rock Throw", "Rock", "Physical", {}, 50, 90, 15, "The Pokemon pelts their target with sharp rocks.")                                                   

-- Ground Type Moves
pokemonHandler.makePokemonMove("Bulldoze", "Ground", "Physical", {}, 60, 100, 20, "The Pokemon launches themself at their target and digs into them.")     
pokemonHandler.makePokemonMove("Sand Attack", "Ground", "Status", {"Accuracy"}, 0, 100, 15, "The Pokemon tosses sand into their target's eyes. (Decreases Accuracy)")                                                       

-- Bug Type Moves
pokemonHandler.makePokemonMove("Bug Bite", "Bug", "Physical", {}, 60, 100, 20, "The Pokemon bites their target, leaving them with an irritating itch!")                                                                                             
pokemonHandler.makePokemonMove("Fury Cutter", "Bug", "Physical", {}, 40, 95, 20, "The Pokemon furiously cuts into their target.")                           

-- Ice Type Moves
pokemonHandler.makePokemonMove("Icy Wind", "Ice", "Special", {"Speed"}, 55, 95, 15, "The Pokemon sends a freezing breeze of air towards their target. (Decreases Speed)")                                                                         
pokemonHandler.makePokemonMove("Avalanche", "Ice", "Physical", {}, 60, 100, 10, "The Pokemon triggers an avalanche of icy rocks and snow towards their target.")                     

-- Steel Type Moves
pokemonHandler.makePokemonMove("Iron Defense", "Steel", "Status", {"Defense", "Defense"}, 0, 100, 15, "The Pokemon greatly hardens their skin. (Increases Defense x2)")                               
pokemonHandler.makePokemonMove("Iron Tail", "Steel", "Special", {},  100, 75, 15, "The Pokemon hardens their tail and slams it down onto their target.")                                                                      

-- Dragon Type Moves
pokemonHandler.makePokemonMove("Dragon Breath", "Dragon", "Special", {"Attack"}, 60, 100, 20, "The Pokemon breathes their dragony breath at their target. (Decreases Attack)")                       
pokemonHandler.makePokemonMove("Dragon Claw", "Dragon", "Physical", {}, 80, 100, 15, "The Pokemon slashes their target with their sharp claws.")                                        

-- Fighting Type Moves
pokemonHandler.makePokemonMove("Fighting Fist", "Fighting", "Physical", {}, 30, 100, 20, "The Pokemon forcefully thrusts their fist into their target.")                     
pokemonHandler.makePokemonMove("Brick Break", "Fighting", "Physical", {}, 75, 100, 15, "The Pokemon thinks of their hatred for bricks to fueil their power and then attacks their target.")                                                  

--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--

-- Creates a new Pokemon
function pokemonHandler.makeNewPokemon(name, number, animations, pokeType1, pokeType2, level, move1, move2, move3, move4, health, attack, defense, specialAttack, specialDefense, speed)
    local pokemon = {}

    -- NAME --
    pokemon.name = name                                                                                                                                     -- Pokemon's name
    pokemon.number = number                                                                                                                                 -- Pokemon's number

    -- ANIMATIONS --
    pokemon.animations = animations                                                                                                                         -- Pokemon Animations
    pokemon.currentAnimation = pokemon.animations.shinyBackFacing                                                                                           -- Pokemon's Currently Active Animation

    -- SIZE AND POSITION --
    pokemon.width = 80                                                                                                                                      -- Width of pokemon image
    pokemon.height = 80                                                                                                                                     -- Height of pokemon image
    pokemon.x = 0                                                                                                                                           -- x-position of pokemon image (initialized at top-left corner)
    pokemon.y = 0                                                                                                                                           -- y-position of pokemon image (initialized at top-left corner)

    -- TYPE(S) --
    pokemon.types = {}
    pokemon.types.type1 = pokeType1                                                                                                                         -- The first type of the Pokemon
    pokemon.types.type2 = pokeType2                                                                                                                         -- The second type of the Pokemon

    -- EXPERIENCE --
    pokemon.level = level                                                                                                                                   -- Experience level (btwn 1 and 100)
    pokemon.currentXP = 200                                                                                                                                   -- Current number of experience points
    pokemon.goalXP = pokemon.level * 25                                                                                                                     -- Target number of experience points needed until next level up
 
    -- MOVES AND ACTION --
    pokemon.moves = {}                                                                                                                                      -- Table to store up to four pokemon moves
    pokemon.moves.move1 = move1                                                                                                                             -- A move table containing all of the move's information
    pokemon.moves.move2 = move2                                                                                                                             -- A move table containing all of the move's information (or nil if pokemon shouldn't have 2nd move)
    pokemon.moves.move3 = move3                                                                                                                             -- A move table containing all of the move's information (or nil if pokemon shouldn't have 3rd move)
    pokemon.moves.move4 = move4                                                                                                                             -- A move table containing all of the move's information (or nil if pokemon shouldn't have 4th move)

    -- BASE STATS --
    pokemon.baseHealth = health                                                                                                                             -- Default health stat
    pokemon.baseAttack = attack                                                                                                                             -- Default attack stat
    pokemon.baseDefense = defense                                                                                                                           -- Default defense stat
    pokemon.baseSpecialAttack = specialAttack                                                                                                               -- Default special attack stat
    pokemon.baseSpecialDefense = specialDefense                                                                                                             -- Default special defense stat
    pokemon.baseSpeed = speed                                                                                                                               -- Default speed stat
    pokemon.baseAccuracy = 100                                                                                                                              -- Default accuracy stat (always 100)

    -- CURRENT STATS --
    pokemon.currentHealth = pokemon.baseHealth                                                                                                              -- Current Health amount 
    pokemon.currentAttack = pokemon.baseAttack                                                                                                              -- Current Attack power
    pokemon.currentDefense = pokemon.baseDefense                                                                                                            -- Current Defense power
    pokemon.currentSpecialAttack = pokemon.baseSpecialAttack                                                                                                -- Current Special attack power
    pokemon.currentSpecialDefense = pokemon.baseSpecialDefense                                                                                              -- Current Special defense power
    pokemon.currentSpeed = pokemon.baseSpeed                                                                                                                -- Current Speed amount
    pokemon.currentAccuracy = pokemon.baseAccuracy

    -- IVs (GENES) --
    pokemon.healthIV = nil                                                                                                                                  -- Health IV value
    pokemon.attackIV = nil                                                                                                                                  -- Attack IV value
    pokemon.defenseIV = nil                                                                                                                                 -- Defense IV value
    pokemon.specialAttackIV = nil                                                                                                                           -- Special attack IV value
    pokemon.specialDefenseIV = nil                                                                                                                          -- Special defense IV value
    pokemon.speedIV = nil                                                                                                                                   -- Speed IV value

    -- STATUS --
    pokemon.isWild = true                                                                                                                                   -- Wild status
    pokemon.isBattling = false                                                                                                                              -- Battling Status
    pokemon.isShiny = false                                                                                                                                 -- Shiny Status
    pokemon.performingAction = false                                                                                                                        -- Performing Action Status (whether or not the Pokemon is currently using a move)

    --=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--

    -- FUNCTIONS --

    -- Pokemon uses a selected move against an opposing pokemon
    function pokemon.useMove(move, targetPokemon)
        local accuracy = pokemon.currentAccuracy + move.accuracy                                                                                            -- Calculate the overall accuracy for the move to land (Pokemon's Current Accuracy Value + Move's Base Accuracy) (0 would be a guaranteed miss, 200 would be a guaranteed land)
        local moveNumber = love.math.random(0, 200)                                                                                                         -- Generate a random move number between 0 and 200 that will be used to determine whether the move lands or not
        local superEffective = false
        local notVeryEffective = false
        local noEffect = false
        
        if (moveNumber > accuracy) then                                                                                                                     -- If the moveNumber is greater than the accuracy value...
            return (pokemon.name .. "'s move missed! Pathetic!")                                                                                                                                       -- Return false because the move missed
        end
        
        if (move.category == "Status" or move.category == "Special") then                                                                                   -- If the move is in the Status or the Special category...
            for i = 1, #move.statsAffected do                                                                                                               -- For every stat that the move affects...
                local targetStat = targetPokemon["base" .. move.statsAffected[i]]                                                                             -- Store the target pokemon's current stat value to modify
                local statModifier                                                                                                                              -- Declare a variable that will store the percentage modifier value fo rthe targetStat

                if (targetPokemon == pokemon) then                                                                                                              -- If the Pokemon is using this move on itself...
                    statModifier = 0.2                                                                                                                              -- Make the stat modifier to positive 20 percent so that the Pokemon performing the move will increase their own target stat
                else                                                                                                                                            -- Otherwise..
                    statModifier = -0.2                                                                                                                             -- Set the stat modifier to negative 20 percent so that the Pokemon performing the move will decrease the target Pokemon's target stat
                end

                targetPokemon["current" .. move.statsAffected[i]] = targetPokemon["current" .. move.statsAffected[i]] + (targetStat * statModifier)             -- Adjust the target pokemon's target stat by the stat modifier

                if (targetPokemon.currentHealth > targetPokemon.baseHealth) then
                    targetPokemon.currentHealth = targetPokemon.baseHealth
                end
            end
        end
        
        if (move.category == "Physical" or move.category == "Special") then                                                                             -- Otherwise, if the move is in the Physical or the Special category...
            local damageAmount
            
            if (move.category == "Special") then                                                                                                            -- If the attack is a Special Attack,
                damageAmount = move.power
            else                                                                                                                                            -- Otherwise...
                damageAmount = move.power
            end

            if (damageAmount <= 0) then
                damageAmount = 1
            end

            for targetTypes, targetType in pairs(targetPokemon.types) do                                                                                      -- For each of the target Pokemon's types...                
                for i = 1, #pokemonHandler.types[move.type].superEffectiveTowards do                                                                                                  -- For every type that the move is super effective against...
                    if (pokemonHandler.types[targetType] == pokemonHandler.types[pokemonHandler.types[move.type].superEffectiveTowards[i]]) then                                                                                      -- If the target Pokemon's type is one that the move is super effective against...
                        damageAmount = damageAmount + (damageAmount * 0.5)                                                                                              -- Increase the damageAmount by half of the current damageAmount (deal 50% more damage)
                        superEffective = true
                    end                                                                                                                                                  -- 1x Super Effective = 1.5x Damage Dealt
                end                                                                                                                                                      -- 2x Super Effective = 2.25x Damage Dealt

                for i = 1, #pokemonHandler.types[move.type].notVeryEffectiveTowards do                                                                                                -- For every type that the move is not very effective against...
                    if (pokemonHandler.types[targetType] == pokemonHandler.types[pokemonHandler.types[move.type].notVeryEffectiveTowards[i]]) then                                                                                    -- If the target Pokemon's type is one that the move is not very effective against...
                        damageAmount = damageAmount - (damageAmount * 0.5)                                                                                              -- Decrease the damageAmount by half of the current damageAmount (deal 50% less damage)
                        notVeryEffective = true
                    end                                                                                                                                                 -- 1x Not Very Effective = 0.5x Damage Dealt
                end                                                                                                                                                     -- 2x Not Very Effective = 0.25x Damage Dealt

                for i = 1, #pokemonHandler.types[move.type].noEffectTowards do                                                                                                        -- For every type that the move has no effect against...
                    if (pokemonHandler.types[targetType] == pokemonHandler.types[pokemonHandler.types[move.type].noEffectTowards[i]]) then                                                                                            -- If the target Pokemon's type is one that the move has no effect against...
                        damageAmount = 0                                                                                                                                -- Set the damageAmount to 0 (no damage dealt)
                        noEffect = true
                    end                                                                                                                                                 -- 1x or 2x No Effect Towards = 0 Damage Dealt
                end
            end

            targetPokemon.currentHealth = targetPokemon.currentHealth - damageAmount                                                                        -- Decrease the target pokemon's current health value by the amount of damage dealt

            if (targetPokemon.currentHealth < 0) then
                targetPokemon.currentHealth = 0
            end
        end

        if (move.category == "Status") then
            if (targetPokemon == pokemon) then
                return (targetPokemon.name .. " increased their " .. move.statsAffected[1] .. "!")
            else
                return (targetPokemon.name .. "'s " .. move.statsAffected[1] .. " was decreased!")
            end
        end

        if (noEffect) then
            return (pokemon.name .. "'s move had no effect on " .. targetPokemon.name .. "... awkward...")
        end

        if (notVeryEffective and superEffective) then
            return (pokemon.name .. "'s move landed!")
        end

        if (notVeryEffective) then
            return (pokemon.name .. "'s move was not very effective against " .. targetPokemon.name .. "...")
        end

        if (superEffective) then
            return (pokemon.name .. "'s move was super effective against " .. targetPokemon.name .. "!")
        end

        return (pokemon.name .. "'s move landed!")


        -- MAKE SURE THE MOVE ANIMATION IS PLAYED AT SOME POINT (move.playAnimation ???)
            -- Maybe Idea for this pokemon.useMove function:
            -- Have this function trigger a timer for the move (2-3 seconds?)
            -- Store the move into a currentMove variable or something like that
            -- Reset the currentMove animation to the first frame
            -- Somewhere in the battler.lua file, if (currentMove ~= nil) then move.updateAnimation??

    end


    -- If pokemon is caught, add it to player's inventory
    function pokemon.isCaught(pokemon, playersPokemon)
        pokemon.isWild = false
        table.insert(player.pokemon, pokemon)
    end

    function pokemon.levelUp(thisPokemon)
        thisPokemon.level = thisPokemon.level + 1
        thisPokemon.currentXP = thisPokemon.currentXP - thisPokemon.goalXP
        thisPokemon.goalXP = thisPokemon.level * 25

        pokemon.baseHealth = pokemon.baseHealth + 10
        pokemon.baseAttack = pokemon.baseAttack + 10
        pokemon.baseDefense = pokemon.baseDefense + 10
        pokemon.baseSpecialAttack = pokemon.baseSpecialAttack + 10
        pokemon.baseSpecialDefense = pokemon.baseSpecialDefense + 10
        pokemon.baseSpeed = pokemon.baseSpeed + 10

        pokemon.currentHealth = pokemon.baseHealth
        pokemon.currentAttack = pokemon.baseAttack
        pokemon.currentDefense = pokemon.baseDefense
        pokemon.currentSpecialAttack = pokemon.baseSpecialAttack
        pokemon.currentSpecialDefense = pokemon.baseSpecialDefense
        pokemon.currentSpeed = pokemon.baseSpeed
    end

    -- Initialized only when the pokemon is created
    function pokemon.initializeStats(pokemon)
        pokemon.healthIV = math.random(0, 31)
        pokemon.attackIV = math.random(0, 31)
        pokemon.defenseIV = math.random(0, 31)
        pokemon.specialAttackIV = math.random(0, 31)
        pokemon.specialDefenseIV = math.random(0, 31)
        pokemon.speedIV = math.random(0, 31)

        -- Multiply stats by randomized IV value
        pokemon.baseHealth = pokemon.baseHealth + pokemon.healthIV
        pokemon.baseAttack = pokemon.baseAttack + pokemon.attackIV
        pokemon.baseDefense = pokemon.baseDefense + pokemon.defenseIV
        pokemon.baseSpecialAttack = pokemon.baseSpecialAttack + pokemon.specialAttackIV
        pokemon.baseSpecialDefense = pokemon.baseSpecialDefense + pokemon.specialDefenseIV
        pokemon.baseSpeed = pokemon.baseSpeed + pokemon.speedIV

        -- Increase base stats based on level
        pokemon.baseHealth = pokemon.baseHealth + (pokemon.baseHealth * (pokemon.level / 50))
        pokemon.baseAttack = pokemon.baseAttack + (pokemon.baseAttack * (pokemon.level / 50))
        pokemon.baseDefense = pokemon.baseDefense + (pokemon.baseDefense * (pokemon.level / 50))
        pokemon.baseSpecialAttack = pokemon.baseSpecialAttack + (pokemon.baseSpecialAttack * (pokemon.level / 50))
        pokemon.baseSpecialDefense = pokemon.baseSpecialDefense + (pokemon.baseSpecialDefense * (pokemon.level / 50))
        pokemon.baseSpeed = pokemon.baseSpeed + (pokemon.baseSpeed * (pokemon.level / 50))

        pokemon.currentHealth = pokemon.baseHealth
        pokemon.currentAttack = pokemon.baseAttack
        pokemon.currentDefense = pokemon.baseDefense
        pokemon.currentSpecialAttack = pokemon.baseSpecialAttack
        pokemon.currentSpecialDefense = pokemon.baseSpecialDefense
        pokemon.currentSpeed = pokemon.baseSpeed
    end

    function pokemon.update(thisPokemon, dt)
        for animations, animation in pairs(thisPokemon.animations) do
            animation.updatable = true                                          -- Sets each animation to be updatable
        end

        thisPokemon.currentAnimation.update(dt)
    end

    function pokemon.draw(thisPokemon) 
        love.graphics.draw(pokemonHandler.spritesheet, thisPokemon.currentAnimation.frames[thisPokemon.currentAnimation.currentFrameNum], thisPokemon.x, thisPokemon.y, 0, 7, 7)                        -- Draw the Pokemon's current Animation
    end

    return pokemon
end

--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--

function pokemonHandler.generateAllPokemon()
    local allPokemon = {}
    
    local pokemonData = require("scripts/pokemon/pokemonData")
    
    -- Positioning information for the Pokemon spritesheet
    local startX = 1                                                                                                                                                                    -- Starting x-coordinate
    local startY = 34                                                                                                                                                                   -- Starting y-coordinate
    local shiftX = 324                                                                                                                                                                  -- How much to shift along the x-axis
    local shiftY = 195                                                                                                                                                                  -- How much to shift along the y-axis
    local width = 81                                                                                                                                                                    -- Width of each Pokemon sprite
    local height = 81                                                                                                                                                                   -- Height of each Pokemon sprite
    local cols = 10                                                                                                                                                                     -- Number of columns in Pokemon spritesheet
    local rows = 14                                                                                                                                                                     -- Number of rows in Pokemon spritesheet
    local currentSpritesheetIndex = 1                                                                                                                                                   -- Current index in the Spritesheet
    local skipIndexes = {4, 16, 18, 25, 32, 40, 42, 47, 52, 54, 58, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 76, 78, 83, 85, 90, 93, 95, 98, 103, 107, 113, 117, 137}        -- Indexes in the Spritesheet to skip (extra and unnecessary sprites)
    local rowCounter = 1                                                                                                                                                                -- Which row of Pokemon is currently being worked with
    
    for i = 1, #pokemonData do                                                                                                                                                          -- For every Pokemon in the pokemonData file...
        local pokemon = pokemonData[i]                                                                                                                                                      -- Store the Pokemon
        local pokeName = pokemonData[i][1]                                                                                                                                                  -- Store the Pokemon's name
        local pokeNumber = pokemonData[i][2]                                                                                                                                                -- Store the Pokemon's number
        local pokeType1 = pokemonData[i][3]                                                                                                                           -- Store the Pokemon's first type
        local pokeType2 = pokemonData[i][4]                                                                                                                           -- Store the Pokemon's second type
    
        if (pokeType2 == "") then                                                                                                                                                           -- If the Pokemon's second type is empty...
            pokeType2 = nil                                                                                                                                                                     -- Set the second type to nil
        end
    
        local pokeLevel = 1                                                                                                                                                             -- Store the Pokemon's level
    
        -- MOVES
        local pokeMove1 = pokemonHandler.types[pokeType1].moves[1]                                                                                                                                            -- Store the Pokemon's first move (a move that is the same type as the Pokemon's first type)
        local pokeMove2 = pokemonHandler.types[pokeType1].moves[2]                                                                                                                                            -- Store the Pokemon's second move (a move that is the same type as the Pokemon's first type)
        local pokeMove3                                                                                                                                                                 -- Declare a pokeMove3 variable
        local pokeMove4                                                                                                                                                                 -- Declare a pokeMove4 variable

        if (pokeType2 ~= nil) then                                                                                                                                                      -- If the Pokemon has a second type...
            pokeMove3 = pokemonHandler.types[pokeType2].moves[1]                                                                                                                                                  -- Set the Pokemon's third move (a move that is the same type as the Pokemon's second type)
            pokeMove4 = pokemonHandler.types[pokeType2].moves[2]                                                                                                                                                  -- Set the Pokemon's fourth move (a move that is the same type as the Pokemon's second type)
        else                                                                                                                                                                            -- Otherwise...
            pokeMove3 = pokemonHandler.types["Normal"].moves[3]                                                                                                                                -- Set the Pokemon's third move (a Normal type move)
            pokeMove4 = pokemonHandler.types["Normal"].moves[4]                                                                                                                                -- Set the Pokemon's fourth move (a Normal type move)
        end

        -- STATS
        local pokehealth = pokemonData[i][5]                                                                                                                                            -- Set the Pokemon's base health
        local pokeattack = pokemonData[i][6]                                                                                                                                            -- Set the Pokemon's base attack    
        local pokedefense = pokemonData[i][7]                                                                                                                                           -- Set the Pokemon's base defense
        local pokespecialAttack = pokemonData[i][8]                                                                                                                                     -- Set the Pokemon's base special attack
        local pokespecialDefense = pokemonData[i][9]                                                                                                                                    -- Set the Pokemon's base special defense
        local pokespeed = pokemonData[i][10]                                                                                                                                            -- Set the Pokemon's base speed
    
        -- ANIMATIONS 
        while (currentSpritesheetIndex == skipIndexes[1]) do                                                                                                                            -- While the current sprite is one that should be skipped...                                                                            
            if (currentSpritesheetIndex % 10 == 0) then                                                                                                                                     -- If the current sprite is the last one in the row of sprites...
                rowCounter = rowCounter + 1                                                                                                                                                     -- Move onto the next row of sprites
            end

            currentSpritesheetIndex = currentSpritesheetIndex + 1                                                                                                                           -- Move onto the next sprite

            table.remove(skipIndexes, 1)                                                                                                                                                    -- Remove the index to skip now that it has been skipped
        end
    
        local x = (((currentSpritesheetIndex - 1) % 10) * shiftX) + startX                                                                                                              -- Set the x-coordinate for the Pokemon Sprite                                                                                    
        local y = startY + (shiftY * (rowCounter - 1))                                                                                                                                  -- Set the y-coordinate for the Pokemon Sprite
    
        local pokeAnimations = {}                                                                                                                                                       -- Create a table to store all of the Pokemon's animation
        pokeAnimations.opponentSide1 = animator.create(nil, 1, 560, 560, 7, nil, nil, nil, 1, true, false)                                                                                -- Set up the frontFacing animation
        pokeAnimations.opponentSide2 = animator.create(nil, 1, 560, 560, 7, nil, nil, nil, 1, true, false)                                                                                -- Set up the frontFacing animation

        pokeAnimations.playerSide1 = animator.create(nil, 1, 560, 560, 7, nil, nil, nil, 1, true, false)                                                                                 -- Set up the backFacing animation
        pokeAnimations.playerSide2 = animator.create(nil, 1, 560, 560, 7, nil, nil, nil, 1, true, false)                                                                                 -- Set up the backFacing animation

        pokeAnimations.shinyOpponentSide1 = animator.create(nil, 1, 560, 560, 7, nil, nil, nil, 1, true, false)                                                                           -- Set up the shinyFrontFacing animation
        pokeAnimations.shinyOpponentSide2 = animator.create(nil, 1, 560, 560, 7, nil, nil, nil, 1, true, false)                                                                           -- Set up the shinyFrontFacing animation

        pokeAnimations.shinyPlayerSide1 = animator.create(nil, 1, 560, 560, 7, nil, nil, nil, 1, true, false)                                                                            -- Set up the shinyBackFacing animation
        pokeAnimations.shinyPlayerSide2 = animator.create(nil, 1, 560, 560, 7, nil, nil, nil, 1, true, false)                                                                            -- Set up the shinyBackFacing animation

        pokeAnimations.inventorySprite = animator.create(nil, 2, 32, 32, 7, nil, nil, nil, 1.5, true, false)                                                                            -- Set up the shinyBackFacing animation

        table.insert(pokeAnimations.opponentSide1.frames, love.graphics.newQuad(x, y, 80, 80, pokemonHandler.spritesheet:getDimensions()))                                                -- First front pose
        table.insert(pokeAnimations.opponentSide2.frames, love.graphics.newQuad(x + width, y, 80, 80, pokemonHandler.spritesheet:getDimensions()))                                        -- Second front pose

        table.insert(pokeAnimations.playerSide1.frames, love.graphics.newQuad(x + width * 2, y, 80, 80, pokemonHandler.spritesheet:getDimensions()))                                     -- First back pose
        table.insert(pokeAnimations.playerSide2.frames, love.graphics.newQuad(x + width * 3, y, 80, 80, pokemonHandler.spritesheet:getDimensions()))                                     -- Second back pose
    
        table.insert(pokeAnimations.shinyOpponentSide1.frames, love.graphics.newQuad(x, y + height, 80, 80, pokemonHandler.spritesheet:getDimensions()))                                  -- First shiny front pose
        table.insert(pokeAnimations.shinyOpponentSide2.frames, love.graphics.newQuad(x + width, y + height, 80, 80, pokemonHandler.spritesheet:getDimensions()))                          -- Second shiny front pose

        table.insert(pokeAnimations.shinyPlayerSide1.frames, love.graphics.newQuad(x + width * 2, y + height, 80, 80, pokemonHandler.spritesheet:getDimensions()))                       -- First shiny back pose
        table.insert(pokeAnimations.shinyPlayerSide2.frames, love.graphics.newQuad(x + width * 3, y + height, 80, 80, pokemonHandler.spritesheet:getDimensions()))                       -- Second shiny back pose

        table.insert(pokeAnimations.inventorySprite.frames, love.graphics.newQuad(x + 258, y - 33, 33, 33, pokemonHandler.spritesheet:getDimensions()))
        table.insert(pokeAnimations.inventorySprite.frames, love.graphics.newQuad(x + 291, y - 33, 33, 33, pokemonHandler.spritesheet:getDimensions()))


        if (currentSpritesheetIndex % 10 == 0) then                                                                                                                                     -- If the current sprite is the last one in the row of sprites...
            rowCounter = rowCounter + 1                                                                                                                                                     -- Move onto the next row of sprites
        end
    
        table.insert(allPokemon, pokemonHandler.makeNewPokemon(                                                                                                                         -- Create the new Pokemon
            pokeName, pokeNumber, pokeAnimations, pokeType1, pokeType2, pokeLevel,
            pokeMove1, pokeMove2, pokeMove3, pokeMove4, 
            pokehealth, pokeattack, pokedefense, pokespecialAttack, pokespecialDefense, pokespeed))

        currentSpritesheetIndex = currentSpritesheetIndex + 1                                                                                                                           -- Move onto the next sprite
    end
    
    return allPokemon                                                                                                                                                                   -- Return the list holding every Pokemon
end

--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--

-- Generates an existing Pokemon for the game
function pokemonHandler.loadPokemon(pokemonName, pokemonNumber, pokemonLevel)
    for i = 1, #everyPokemon do
        local pokemon = everyPokemon[i]

        if (pokemonName == pokemon.name or pokemonNumber == pokemon.number) then
            local newPokemon = pokemonHandler.makeNewPokemon(pokemon.name, pokemon.number, pokemon.animations, pokemon.types["type1"], pokemon.types["type2"], pokemonLevel, pokemon.moves.move1, pokemon.moves.move2, pokemon.moves.move3, pokemon.moves.move4, pokemon.baseHealth, pokemon.baseAttack, pokemon.baseDefense, pokemon.baseSpecialAttack, pokemon.baseSpecialDefense, pokemon.baseSpeed)

            if (love.math.random(1, 4) == 1) then
                newPokemon.isShiny = true
                newPokemon.currentAnimation = newPokemon.animations.shinyOpponentSide1
            else
                newPokemon.isShiny = false
                newPokemon.currentAnimation = newPokemon.animations.opponentSide1
            end

            newPokemon.x = 1250                                                                                                                                             -- Set the newPokemon's x-coordinate to 1250

            if (newPokemon.types["type1"] == pokemonHandler.types.Flying or newPokemon.types["type2"] == pokemonHandler.types.Flying) then                                  -- If the newPokemon is a flying type pokemon...
                newPokemon.y = 15                                                                                                                                               -- Set the y-coordinate for the newPokemon to be higher up
            else                                                                                                                                                            -- Otherwise...
                newPokemon.y = 120                                                                                                                                              -- Set the y-coordinate of the newPokemon to be at a normal level
            end

            newPokemon:initializeStats()

            return newPokemon
        end
    end
end

return pokemonHandler
