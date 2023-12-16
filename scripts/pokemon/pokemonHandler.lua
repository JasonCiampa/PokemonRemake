-- To parse out move data from HTML of pokemondb.net, look for a table with a class called "vitals-table"
-- Inside of that table is a tbody, and inside of the tbody is the data in the following order:
-- Type, Category, Power, Accuracy, PP

-- A types table to hold all 17 pokemon types

local pokemonHandler = {}

pokemonHandler.spritesheet = love.graphics.newImage("assets/images/pokemon/pokemon_spritesheet.png")     --https://www.spriters-resource.com/ds_dsi/pokemonheartgoldsoulsilver/sheet/132566/

pokemonHandler.types = {}

-- Creates a pokemon type with tables indicating what other types it is super effective towards, not very effective towards, or has no effect towards.
function pokemonHandler.makePokemonType(superEffectiveTowards, notVeryEffectiveTowards, noEffect)
    local typeTable = {}
    
    typeTable.superEffectiveTowards = superEffectiveTowards
    typeTable.notVeryEffectiveTowards = notVeryEffectiveTowards
    typeTable.noEffectTowards = noEffectTowards

    return typeTable
end

-- Creates all 17 pokemon types
pokemonHandler.types.Bug = pokemonHandler.makePokemonType({pokemonHandler.types.Dark, pokemonHandler.types.Grass, pokemonHandler.types.Psychic}, {pokemonHandler.types.Fighting, pokemonHandler.types.Fire, pokemonHandler.types.Flying, pokemonHandler.types.Ghost, pokemonHandler.types.Poison, pokemonHandler.types.Steel}, {})
pokemonHandler.types.Dark = pokemonHandler.makePokemonType({pokemonHandler.types.Ghost, pokemonHandler.types.Psychic}, {pokemonHandler.types.Dark, pokemonHandler.types.Fighting, pokemonHandler.types.Steel}, {})
pokemonHandler.types.Dragon = pokemonHandler.makePokemonType({pokemonHandler.types.Dragon}, {pokemonHandler.types.Steel}, {})
pokemonHandler.types.Electric = pokemonHandler.makePokemonType({pokemonHandler.types.Flying, pokemonHandler.types.Water}, {pokemonHandler.types.Dragon, pokemonHandler.types.Electric, pokemonHandler.types.Grass}, {pokemonHandler.types.Ground})
pokemonHandler.types.Fighting = pokemonHandler.makePokemonType({pokemonHandler.types.Dark, pokemonHandler.types.Ice, pokemonHandler.types.Normal, pokemonHandler.types.Rock, pokemonHandler.types.Steel}, {pokemonHandler.types.Bug, pokemonHandler.types.Flying, pokemonHandler.types.Poison, pokemonHandler.types.Psychic}, {pokemonHandler.types.Ghost})
pokemonHandler.types.Fire = pokemonHandler.makePokemonType({pokemonHandler.types.Bug, pokemonHandler.types.Grass, pokemonHandler.types.Ice, pokemonHandler.types.Steel}, {pokemonHandler.types.Dragon, pokemonHandler.types.Fire, pokemonHandler.types.Rock, pokemonHandler.types.Water}, {})
pokemonHandler.types.Flying = pokemonHandler.makePokemonType({pokemonHandler.types.Bug, pokemonHandler.types.Fighting, pokemonHandler.types.Grass}, {pokemonHandler.types.Electric, pokemonHandler.types.Rock, pokemonHandler.types.Steel}, {})
pokemonHandler.types.Ghost = pokemonHandler.makePokemonType({pokemonHandler.types.Ghost, pokemonHandler.types.Psychic}, {pokemonHandler.types.Dark, pokemonHandler.types.Steel}, {pokemonHandler.types.Normal})
pokemonHandler.types.Grass = pokemonHandler.makePokemonType({pokemonHandler.types.Ground, pokemonHandler.types.Rock, pokemonHandler.types.Water}, {pokemonHandler.types.Bug, pokemonHandler.types.Dragon, pokemonHandler.types.Fire, pokemonHandler.types.Flying, pokemonHandler.types.Grass, pokemonHandler.types.Poison, pokemonHandler.types.Steel}, {})
pokemonHandler.types.Ground = pokemonHandler.makePokemonType({pokemonHandler.types.Electric, pokemonHandler.types.Fire, pokemonHandler.types.Poison, pokemonHandler.types.Rock, pokemonHandler.types.Steel}, {pokemonHandler.types.Bug, pokemonHandler.types.Grass}, {pokemonHandler.types.Flying})
pokemonHandler.types.Ice = pokemonHandler.makePokemonType({pokemonHandler.types.Dragon, pokemonHandler.types.Flying, pokemonHandler.types.Grass, pokemonHandler.types.Ground}, {pokemonHandler.types.Fire, pokemonHandler.types.Ice, pokemonHandler.types.Steel, pokemonHandler.types.Water}, {})
pokemonHandler.types.Normal = pokemonHandler.makePokemonType({}, {pokemonHandler.types.Rock, pokemonHandler.types.Steel}, {pokemonHandler.types.Ghost})
pokemonHandler.types.Poison = pokemonHandler.makePokemonType({pokemonHandler.types.Grass}, {pokemonHandler.types.Ghost, pokemonHandler.types.Ground, pokemonHandler.types.Poison, pokemonHandler.types.Rock}, {pokemonHandler.types.Steel})
pokemonHandler.types.Psychic = pokemonHandler.makePokemonType({pokemonHandler.types.Fighting, pokemonHandler.types.Poison}, {pokemonHandler.types.Psychic, pokemonHandler.types.Steel}, {pokemonHandler.types.Dark})
pokemonHandler.types.Rock = pokemonHandler.makePokemonType({pokemonHandler.types.Bug, pokemonHandler.types.Fire, pokemonHandler.types.Flying, pokemonHandler.types.Ice}, {pokemonHandler.types.Fighting, pokemonHandler.types.Ground, pokemonHandler.types.Steel}, {})
pokemonHandler.types.Steel = pokemonHandler.makePokemonType({pokemonHandler.types.Ice, pokemonHandler.types.Rock}, {pokemonHandler.types.Electric, pokemonHandler.types.Fire, pokemonHandler.types.Steel, pokemonHandler.types.Water}, {})
pokemonHandler.types.Water = pokemonHandler.makePokemonType({pokemonHandler.types.Fire, pokemonHandler.types.Ice, pokemonHandler.types.Rock}, {pokemonHandler.types.Dragon, pokemonHandler.types.Grass, pokemonHandler.types.Water}, {})

--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--

-- Creates a moves table for each Pokemon type that will hold all moves belonging to that type
for pokeTypes, pokeType in pairs(pokemonHandler.types) do
    pokeType.moves = {}
end

function pokemonHandler.makePokemonMove(moveType, category, statsAffected, power, accuracy, powerPoints, effectDescription, animations)
    local move = {}

    -- move.name = name
    move.type = moveType                        -- Any type (Grass, Fire, Water, etc.)
    move.category = category                    -- Status, Physical, or Special
    move.statsAffected = statsAffected          -- Table of Pokemon stats that are affected by the move (health, attack, defense, sp attack, sp defense, speed, accuracy) (pokemon[stat] would get the Pokemon's stat)
    move.power = power                          -- Number to represent how much power a move has
    move.accuracy = accuracy                    -- The likelihood that a move will successfully land (%)
    move.basePP = powerPoints                   -- The number of times the move can be used before fully exhausted
    move.currentPP = move.basePP                -- The amount of PP the move currently has remaining
    move.effectDescription = effectDescription  -- Description of the move's effect (string of text)
    move.animations = animations                -- Animations for the move
    -- MAKE POKEMON MOVE ANIMATIONS BE BASED ON COORDINATES (HAVE THE POKEMON MOVE TO A CERTAIN X AND Y AT CERTAIN KEYFRAMES ???)

    table.insert(moveType.moves, move)

    -- Resets the move's current PP so that it has the base PP
    function resetPP()
        move.currentPP = move.basePP
    end

    return move
end


-- Normal Type Moves
pokemonHandler.makePokemonMove(pokemonHandler.types.Normal, "Physical", nil, 40, 100, 35, "The Pokemon charges and slams into the target with its whole body.")                           -- https://pokemondb.net/move/tackle   --tackle
pokemonHandler.makePokemonMove(pokemonHandler.types.Normal, "Status", {"Attack"}, 0, 100, 40, "The Pokemon growls at its target very menacingly. (Lowers Attack Power)")                 -- https://pokemondb.net/move/growl   --growl
pokemonHandler.makePokemonMove(pokemonHandler.types.Normal, "Status", {"Defense"}, 0, 100, 30, "The foe is given an intimidating leer with sharp eyes. (Lowers Defense)")                  -- https://pokemondb.net/move/leer   --leer
pokemonHandler.makePokemonMove(pokemonHandler.types.Normal, "Status", {"Accuracy"}, 0, 100, 20, "The user releases an obscuring cloud of smoke. (Lowers Accuracy)")                          -- https://pokemondb.net/move/smokescreen   --smokescreen

-- Grass Type Moves
pokemonHandler.makePokemonMove(pokemonHandler.types.Grass, "Physical", nil, 55, 95, 25, "Sharp-edged leaves are launched to slash at the foe.")                           -- https://pokemondb.net/move/razor-leaf   --razorLeaf
pokemonHandler.makePokemonMove(pokemonHandler.types.Grass, "Status", {"Health"}, 0, 0, 100, 5, "The user restores its own HP.")                                                                                     -- https://pokemondb.net/move/synthesis   --synthesis

-- Fire Type Moves
pokemonHandler.makePokemonMove(pokemonHandler.types.Fire, 1, 60, 100, 25, "The user cloaks itself in Fire and charges at the foe. It may also leave the target with a burn.")                -- https://pokemondb.net/move/flame-wheel   --flameWheel
pokemonHandler.makePokemonMove(pokemonHandler.types.Fire, 2, 90, 100, 15, "The foe is scorched with an intense blast of Fire. The target may also be left with a burn.")                   -- https://pokemondb.net/move/flamethrower   --flamethrower

-- Water Type Moves
pokemonHandler.makePokemonMove(pokemonHandler.types.Water, 1, 40, 100, 25, "The foe is blasted with a forceful shot of Water.")                                                                -- https://pokemondb.net/move/mud-slap   --waterGun
pokemonHandler.makePokemonMove(pokemonHandler.types.Water, 1, 110, 80, 5, "The foe is blasted by a huge volume of Water launched under great pressure.")                                      -- https://pokemondb.net/move/hydro-pump   --hydroPump

-- Dark Type Moves
pokemonHandler.makePokemonMove(pokemonHandler.types.Dark, 1, 60, 100, 25, "The foe is bitten with sharp fangs.")                                          -- https://pokemondb.net/move/bite   --bite
pokemonHandler.makePokemonMove(pokemonHandler.types.Dark, 1, 60, 100, 10, "The foe is slashed by the user with a dark aura.")                       -- https://pokemondb.net/move/assurance   --nightSlash

-- Psychic Type Moves
pokemonHandler.makePokemonMove(pokemonHandler.types.Psychic, 1, 50, 100, 25, "The foe is hit by a weak telekinetic force. It may also leave the foe confused.")                               -- https://bulbapedia.bulbagarden.net/wiki/Confusion_(move)    --confusion
pokemonHandler.makePokemonMove(pokemonHandler.types.Psychic, 2, 90, 100, 10, "The foe is hit by a strong telekinetic force. It may also reduce the foe's Sp. Def stat.")                        -- https://pokemondb.net/move/Psychic   --psychic

-- Flying Type Moves
pokemonHandler.makePokemonMove(pokemonHandler.types.Flying, 1, 35, 100, 35, "The foe is jabbed with a sharply pointed beak or horn.")                                                              -- https://pokemondb.net/move/peck   --peck
pokemonHandler.makePokemonMove(pokemonHandler.types.Flying, 1, 60, 100, 35, "The foe is struck with large, imposing wings spread wide to inflict damage.")                                   -- https://pokemondb.net/move/wing-attack   --wingAttack

-- Poison Type Moves
pokemonHandler.makePokemonMove(pokemonHandler.types.Poison, 1, 15, 100, 35, "The foe is stabbed with a Poisonous barb of some sort. It may also Poison the target.")                        -- https://pokemondb.net/move/Poison-sting   --PoisonSting
pokemonHandler.makePokemonMove(pokemonHandler.types.Poison, 2, 70, 100, 20, "The foe is stabbed with a tentacle or arm steeped in Poison. It may also Poison the foe.")                       -- https://pokemondb.net/move/Poison-jab   --PoisonJab

-- Ghost Type Moves
pokemonHandler.makePokemonMove(pokemonHandler.types.Ghost, 2, 0, 100, 15, "The user makes the foe see a mirage. It inflicts damage matching the user's level.")                              -- https://bulbapedia.bulbagarden.net/wiki/Night_Shade_(move)   --nightShade
pokemonHandler.makePokemonMove(pokemonHandler.types.Ghost, 2, 80, 100, 15, "The user hurls a shadowy blob at the foe. It may also lower the foe's Sp. Def stat.")                            -- https://pokemondb.net/move/shadow-ball   --shadowBall

-- Electric Type Moves
pokemonHandler.makePokemonMove(pokemonHandler.types.Electric, 0, 0, 90, 20, "A weak Electric charge is launched at the foe. It causes paralysis if it hits.")                               -- https://pokemondb.net/move/thunder-wave   --thunderWave
pokemonHandler.makePokemonMove(pokemonHandler.types.Electric, 2, 90, 100, 15, "A strong Electric blast is loosed at the foe. It may also leave the foe paralyzed.")                         -- https://pokemondb.net/move/thunderbolt   --thunderBolt

-- Rock Type Moves
pokemonHandler.makePokemonMove(pokemonHandler.types.Rock, 1, 75, 90, 10, "Large boulders are hurled at the foe to inflict damage. It may also make the target flinch.")                       -- https://pokemondb.net/move/Rock-slide   --RockSlide
pokemonHandler.makePokemonMove(pokemonHandler.types.Rock, 1, 50, 90, 15, "The user picks up and throws a small Rock at the foe to attack.")                                                   -- https://pokemondb.net/move/Rock-throw   --RockThrow

-- Ground Type Moves
pokemonHandler.makePokemonMove(pokemonHandler.types.Ground, 1, 60, 100, 20, "The user stomps down on the Ground and attacks everything in the area. Hit Pokémon's Speed stat is reduced.")     -- https://pokemondb.net/move/bulldoze   --bulldoze
pokemonHandler.makePokemonMove(pokemonHandler.types.Ground, 0, 0, 100, 15, "Sand is hurled in the foe's face, reducing its accuracy.")                                                       -- https://pokemondb.net/move/sand-attack   --sandAttack

-- Bug Type Moves
pokemonHandler.makePokemonMove(pokemonHandler.types.Bug, 1, 60, 100, 20, "The user bites the foe.")                                                                                             -- https://pokemondb.net/move/Bug-bite   --BugBite
pokemonHandler.makePokemonMove(pokemonHandler.types.Bug, 2, 40, 95, 20, "The foe is slashed with scythes or claws. Its power increases if it hits in succession.")                           -- https://pokemondb.net/move/fury-cutter   --furyCutter

-- Ice Type Moves
pokemonHandler.makePokemonMove(pokemonHandler.types.Ice, 1, 55, 95, 15, "The user attacks with a gust of chilled air.")                                                                         -- https://pokemondb.net/move/icy-wind   --icyWind
pokemonHandler.makePokemonMove(pokemonHandler.types.Ice, 1, 60, 100, 10, "The user forcefully throws a huge mound of thick snow at the foe, dealing significant damage.")                     -- https://pokemondb.net/move/avalanche   --avalanche

-- Steel Type Moves
pokemonHandler.makePokemonMove(pokemonHandler.types.Steel, 0, 0, 100, 15, "The user hardens its body's surface like iron, sharply raising its Defense stat.")                               -- https://pokemondb.net/move/iron-defense   --ironDefense
pokemonHandler.makePokemonMove(pokemonHandler.types.Steel, 1, 100, 75, 15, "The foe is slammed with a Steel-hard tail.")                                                                      -- https://pokemondb.net/move/iron-tail   --SteelTail

-- Dragon Type Moves
pokemonHandler.makePokemonMove(pokemonHandler.types.Dragon, 2, 60, 100, 20, "The user exhales a mighty gust that inflicts damage. It may also paralyze the target.")                       --https://pokemondb.net/move/Dragon-breath   --dragonBreath
pokemonHandler.makePokemonMove(pokemonHandler.types.Dragon, 1, 80, 100, 15, "Sharp, huge claws hook and slash the foe quickly and with great power.")                                        --https://pokemondb.net/move/Dragon-claw   --DragonClaw

-- Fighting Type Moves
pokemonHandler.makePokemonMove(pokemonHandler.types.Fighting, 2, 15, 100, 20, "The user looses a flurry of open-palmed arm thrusts that hit two to five times in a row.")                     -- https://pokemondb.net/move/arm-thrust   --armThrust
pokemonHandler.makePokemonMove(pokemonHandler.types.Fighting, 1, 75, 100, 15, "The user attacks with fists strong enough to break bricks.")                                                  -- https://pokemondb.net/move/brick-break   --brickBreak

--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--

-- Creates a new Pokemon
function pokemonHandler.makeNewPokemon(name, number, animations, pokeType1, pokeType2, level, move1, move2, move3, move4, health, attack, defense, specialAttack, specialDefense, speed)
    local pokemon = {}

    -- NAME --
    pokemon.name = name                                                                                                                                     -- Pokemon's name
    pokemon.number = number                                                                                                                                 -- Pokemon's number

    -- ANIMATIONS --
    pokemon.animations = animations                                                                                                                         -- Pokemon Animations
    pokemon.currentAnimation = pokemon.animations.shinyBackFacing                                                                                               -- Pokemon's Currently Active Animation

    -- SIZE AND POSITION --
    pokemon.width = 80                                                                                                                                      -- Width of pokemon image
    pokemon.height = 80                                                                                                                                     -- Height of pokemon image
    pokemon.x = 0                                                                                                                                           -- x-position of pokemon image (initialized at top-left corner)
    pokemon.y = 0                                                                                                                                           -- y-position of pokemon image (initialized at top-left corner)

    -- TYPE(S) --
    pokemon.types = {}
    pokemon.types.type1 = pokeType1                                                                                                                               -- The first type of the Pokemon
    pokemon.types.type2 = pokeType2                                                                                                                               -- The second type of the Pokemon

    -- EXPERIENCE --
    pokemon.level = level                                                                                                                                   -- Experience level (btwn 1 and 100)
    pokemon.currentXP = 0                                                                                                                                   -- Current number of experience points
    pokemon.goalXP = pokemon.level * 25                                                                                                                             -- Target number of experience points needed until next level up
 
    -- MOVES --
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
    pokemon.isShiny = false

    --=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--

    -- FUNCTIONS --

    -- Pokemon uses a selected move against an opposing pokemon
    function pokemon.useMove(targetPokemon, move)
        local accuracy = pokemon.currentAccuracy + move.accuracy                                                                                            -- Calculate the overall accuracy for the move to land (Pokemon's Current Accuracy Value + Move's Base Accuracy) (0 would be a guaranteed miss, 200 would be a guaranteed land)
        local moveNumber = love.math.random(0, 200)                                                                                                         -- Generate a random move number between 0 and 200 that will be used to determine whether the move lands or not

        if (moveNumber > accuracy) then                                                                                                                     -- If the moveNumber is greater than the accuracy value...
            return false                                                                                                                                        -- Return false because the move missed
        end
        
        if (move.category == "Status" or move.category == "Special") then                                                                                   -- If the move is in the Status or the Special category...
            for i = 1, #move.statsAffected do                                                                                                               -- For every stat that the move affects...
                local targetStat = targetPokemon["current" + move.statsAffected[i]]                                                                             -- Store the target pokemon's current stat value to modify
                local statModifier                                                                                                                              -- Declare a variable that will store the percentage modifier value fo rthe targetStat

                if (targetPokemon == pokemon) then                                                                                                              -- If the Pokemon is using this move on itself...
                    statModifier = 0.2                                                                                                                              -- Make the stat modifier to positive 20 percent so that the Pokemon performing the move will increase their own target stat
                else                                                                                                                                            -- Otherwise..
                    statModifier = -0.2                                                                                                                             -- Set the stat modifier to negative 20 percent so that the Pokemon performing the move will decrease the target Pokemon's target stat
                end

                targetPokemon["current" + move.statsAffected[i]] = targetStat + statModifier                                                                    -- Adjust the target pokemon's target stat by the stat modifier
            end

        elseif (move.category == "Physical" or move.category == "Special") then                                                                             -- Otherwise, if the move is in the Physical or the Special category...
            local damageAmount = (move.power + pokemon.currentAttack) - targetPokemon.currentDefense                                                            -- Calculate the amount of damage dealt ((Move Power + This Pokemon's Current Attack Power) - (Target Pokemon's Current Defense Power))

            for targetTypes, targetType in pairs(targetPokemon.types) do                                                                                      -- For each of the target Pokemon's types...
                for i = 1, #move.type.superEffectiveTowards do                                                                                                  -- For every type that the move is super effective against...
                    if (targetType == move.type.superEffectiveTowards[i]) then                                                                                      -- If the target Pokemon's type is one that the move is super effective against...
                        damageAmount = damageAmount + (damageAmount * 0.5)                                                                                              -- Increase the damageAmount by half of the current damageAmount (deal 50% more damage)
                    end                                                                                                                                                  -- 1x Super Effective = 1.5x Damage Dealt
                end                                                                                                                                                      -- 2x Super Effective = 2.25x Damage Dealt

                for i = 1, #move.type.notVeryEffectiveTowards do                                                                                                -- For every type that the move is not very effective against...
                    if (targetType == move.type.notVeryEffectiveTowards[i]) then                                                                                    -- If the target Pokemon's type is one that the move is not very effective against...
                        damageAmount = damageAmount - (damageAmount * 0.5)                                                                                              -- Decrease the damageAmount by half of the current damageAmount (deal 50% less damage)
                    end                                                                                                                                                 -- 1x Not Very Effective = 0.5x Damage Dealt
                end                                                                                                                                                     -- 2x Not Very Effective = 0.25x Damage Dealt

                for i = 1, #move.type.noEffectTowards do                                                                                                        -- For every type that the move has no effect against...
                    if (targetType == move.type.noEffectTowards[i]) then                                                                                            -- If the target Pokemon's type is one that the move has no effect against...
                        damageAmount = 0                                                                                                                                -- Set the damageAmount to 0 (no damage dealt)
                    end                                                                                                                                                 -- 1x or 2x No Effect Towards = 0 Damage Dealt
                end
            end

            targetPokemon.currentHealth = targetPokemon.currentHealth - damageAmount                                                                        -- Decrease the target pokemon's current health value by the amount of damage dealt
        end

        return true                                                                                                                                         -- Return true because the move landed
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

    -- Initialized only when the pokemon is created
    function pokemon.initializeStats(pokemon)
        pokemon.healthIV = math.random(0, 31)
        pokemon.attackIV = math.random(0, 31)
        pokemon.defenseIV = math.random(0, 31)
        pokemon.specialAttackIV = math.random(0, 31)
        pokemon.specialDefenseIV = math.random(0, 31)

        -- Multiply given health by randomized IV value
        pokemon.baseHealth = pokemon.baseHealth + pokemon.healthIV
        pokemon.baseAttack = pokemon.baseAttack + pokemon.attackIV
        pokemon.baseDefense = pokemon.baseDefense + pokemon.defenseIV
        pokemon.baseSpecialAttack = pokemon.baseSpecialAttack + pokemon.specialAttackIV
        pokemon.baseSpecialDefense = pokemon.baseSpecialDefense + pokemon.specialDefenseIV
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
        local pokeType1 = pokemonHandler.types[pokemonData[i][3]]                                                                                                                           -- Store the Pokemon's first type
        local pokeType2 = pokemonHandler.types[pokemonData[i][4]]                                                                                                                           -- Store the Pokemon's second type
    
        if (pokeType2 == "") then                                                                                                                                                           -- If the Pokemon's second type is empty...
            pokeType2 = nil                                                                                                                                                                     -- Set the second type to nil
        end
    
        local pokeLevel = 5     -- Store the Pokemon's level
    
        -- MOVES
        local pokeMove1 = pokeType1.moves[1]                                                                                                                                            -- Store the Pokemon's first move (a move that is the same type as the Pokemon's first type)
        local pokeMove2 = pokeType1.moves[2]                                                                                                                                            -- Store the Pokemon's second move (a move that is the same type as the Pokemon's first type)
        local pokeMove3                                                                                                                                                                 -- Declare a pokeMove3 variable
        local pokeMove4                                                                                                                                                                 -- Declare a pokeMove4 variable

        if (pokeType2 ~= nil) then                                                                                                                                                      -- If the Pokemon has a second type...
            pokeMove3 = pokeType2.moves[1]                                                                                                                                                  -- Set the Pokemon's third move (a move that is the same type as the Pokemon's second type)
            pokeMove4 = pokeType2.moves[2]                                                                                                                                                  -- Set the Pokemon's fourth move (a move that is the same type as the Pokemon's second type)
        else                                                                                                                                                                            -- Otherwise...
            pokeMove3 = pokemonHandler.types.Normal.moves[3]                                                                                                                                -- Set the Pokemon's third move (a Normal type move)
            pokeMove4 = pokemonHandler.types.Normal.moves[4]                                                                                                                                -- Set the Pokemon's fourth move (a Normal type move)
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
        pokeAnimations.frontFacing = animator.create(nil, 2, 560, 560, 7, nil, nil, nil, 1, true, false)                                                                                -- Set up the frontFacing animation
        pokeAnimations.backFacing = animator.create(nil, 2, 560, 560, 7, nil, nil, nil, 1, true, false)                                                                                 -- Set up the backFacing animation
        pokeAnimations.shinyFrontFacing = animator.create(nil, 2, 560, 560, 7, nil, nil, nil, 1, true, false)                                                                           -- Set up the shinyFrontFacing animation
        pokeAnimations.shinyBackFacing = animator.create(nil, 2, 560, 560, 7, nil, nil, nil, 1, true, false)                                                                            -- Set up the shinyBackFacing animation

        table.insert(pokeAnimations.frontFacing.frames, love.graphics.newQuad(x, y, 80, 80, pokemonHandler.spritesheet:getDimensions()))                                                -- First front pose
        table.insert(pokeAnimations.frontFacing.frames, love.graphics.newQuad(x + width, y, 80, 80, pokemonHandler.spritesheet:getDimensions()))                                        -- Second front pose

        table.insert(pokeAnimations.backFacing.frames, love.graphics.newQuad(x + width * 2, y, 80, 80, pokemonHandler.spritesheet:getDimensions()))                                     -- First back pose
        table.insert(pokeAnimations.backFacing.frames, love.graphics.newQuad(x + width * 3, y, 80, 80, pokemonHandler.spritesheet:getDimensions()))                                     -- Second back pose
    
        table.insert(pokeAnimations.shinyFrontFacing.frames, love.graphics.newQuad(x, y + height, 80, 80, pokemonHandler.spritesheet:getDimensions()))                                  -- First shiny front pose
        table.insert(pokeAnimations.shinyFrontFacing.frames, love.graphics.newQuad(x + width, y + height, 80, 80, pokemonHandler.spritesheet:getDimensions()))                          -- Second shiny front pose

        table.insert(pokeAnimations.shinyBackFacing.frames, love.graphics.newQuad(x + width * 2, y + height, 80, 80, pokemonHandler.spritesheet:getDimensions()))                       -- First shiny back pose
        table.insert(pokeAnimations.shinyBackFacing.frames, love.graphics.newQuad(x + width * 3, y + height, 80, 80, pokemonHandler.spritesheet:getDimensions()))                       -- Second shiny back pose

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
function pokemonHandler.loadPokemon(pokemonName, pokemonLevel)
    for i = 1, #everyPokemon do
        local pokemon = everyPokemon[i]

        if (pokemonName == pokemon.name) then
            local newPokemon = pokemonHandler.makeNewPokemon(pokemon.name, pokemon.number, pokemon.animations, pokemon.types["type1"], pokemon.types["type2"], pokemonLevel, pokemon.moves.move1, pokemon.moves.move2, pokemon.moves.move3, pokemon.moves.move4, pokemon.baseHealth, pokemon.baseAttack, pokemon.baseDefense, pokemon.baseSpecialAttack, pokemon.baseSpecialDefense, pokemon.baseSpeed)
            
            if (love.math.random(0, 2) == 0) then
                newPokemon.isShiny = false
            else
                newPokemon.isShiny = true
            end

            return newPokemon
        end
    end
end

return pokemonHandler
