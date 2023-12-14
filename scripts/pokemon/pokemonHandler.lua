-- To parse out move data from HTML of pokemondb.net, look for a table with a class called "vitals-table"
-- Inside of that table is a tbody, and inside of the tbody is the data in the following order:
-- Type, Category, Power, Accuracy, PP

-- To parse out pokemon data from HTML of pokemondb.net, look for a div tag with a class called "infocard-list infocard-list-pkm-lg"
-- Inside of that div tag is another div tag with a class called "infocard"
-- Inside of that second div tag is a span tag with a class called "infocard-lg-img"
-- Inside of that span tag is an a tag with an href that contains a link to the pokemon

-- For Cameron - pokemon immunities

-- A types table to hold all 17 pokemon types

local pokemonHandler = {}

pokemonHandler.spritesheet = love.graphics.newImage("assets/images/pokemon/pokemon_spritesheet.png")     --https://www.spriters-resource.com/ds_dsi/pokemonheartgoldsoulsilver/sheet/132566/

pokemonHandler.types = {}

-- Creates a pokemon type with tables indicating what other types it is super effective towards, not very effective towards, or has no effect towards.
function pokemonHandler.makePokemonType(superEffectiveTowardsTable, notVeryEffectiveTowardsTable, noEffectTowards)
    local typeTable = {}
    typeTable.superEffectiveTowards = superEffectiveTowardsTable
    typeTable.notVeryEffectiveTowards = notVeryEffectiveTowardsTable
    typeTable.noEffectTowards = noEffectTowardsTable
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

function pokemonHandler.makePokemonMove(moveType, category, statsAffected, statsImpact, accuracy, powerPoints, effectDescription, animations)
    local move = {}

    move.type = moveType                        -- Any type (Grass, Fire, Water, etc.)
    move.category = category                    -- Status, Physical, or Special
    move.statsAffected = statsAffected          -- Table of Pokemon stats that are affected by the move (health, attack, defense, sp attack, sp defense, speed, accuracy) (pokemon[stat] would get the Pokemon's stat)
    move.statsImpact = statsImpact              -- Table of values that represent how much each stat in statsAffected should be incremented/decremented by
    move.accuracy = accuracy
    move.powerPoints = powerPoints              -- Power Points (PP) of a move (number of times a move can be used without recharge) (5 min, 30 max)
    move.effectDescription = effectDescription  -- Description of the move's effect (string of text)
    move.animations = animations                -- Animations for the move
    -- move.target = target                        -- Pokemon to perform the move on

    -- MAKE POKEMON MOVE ANIMATIONS BE BASED ON COORDINATES (HAVE THE POKEMON MOVE TO A CERTAIN X AND Y AT CERTAIN KEYFRAMES ???)

    return move
end


-- Normal Type Moves
pokemonHandler.types.Normal.moves.growl = pokemonHandler.makePokemonMove(pokemonHandler.types.Normal, "Status", {"Attack"}, {-0.2}, 100, 40, "The user growls in an endearing way, making the foe less wary. The target's Attack stat is lowered.")                 -- https://pokemondb.net/move/growl
pokemonHandler.types.Normal.moves.tackle = pokemonHandler.makePokemonMove(pokemonHandler.types.Normal, "Physical", {"Health"}, {-40}, 100, 35, "A physical attack in which the user charges and slams into the foe with its whole body.")                           -- https://pokemondb.net/move/tackle
pokemonHandler.types.Normal.moves.leer = pokemonHandler.makePokemonMove(pokemonHandler.types.Normal, "Status", {"Defense"}, {-0.2}, 100, 30, "The foe is given an intimidating leer with sharp eyes. The target's Defense stat is reduced.")                  -- https://pokemondb.net/move/leer
pokemonHandler.types.Normal.moves.smokescreen = pokemonHandler.makePokemonMove(pokemonHandler.types.Normal, "Status", {"Accuracy"}, {-0.2}, 100, 20, "The user releases an obscuring cloud of smoke or ink. It reduces the foe's accuracy.")                          -- https://pokemondb.net/move/smokescreen

-- Grass Type Moves
pokemonHandler.types.Grass.moves.razorLeaf = pokemonHandler.makePokemonMove(pokemonHandler.types.Grass, "Physical", {"Health"}, {-55}, 1, 55, 95, 25, "Sharp-edged leaves are launched to slash at the foe. It has a high critical-hit ratio.")                           -- https://pokemondb.net/move/razor-leaf
pokemonHandler.types.Grass.moves.synthesis = pokemonHandler.makePokemonMove(pokemonHandler.types.Grass, 0, 0, 100, 5, "The user restores its own HP.")                                                                                     -- https://pokemondb.net/move/synthesis

-- Fire Type Moves
pokemonHandler.types.Fire.moves.flameWheel = pokemonHandler.makePokemonMove(pokemonHandler.types.Fire, 1, 60, 100, 25, "The user cloaks itself in Fire and charges at the foe. It may also leave the target with a burn.")                -- https://pokemondb.net/move/flame-wheel
pokemonHandler.types.Fire.moves.flamethrower = pokemonHandler.makePokemonMove(pokemonHandler.types.Fire, 2, 90, 100, 15, "The foe is scorched with an intense blast of Fire. The target may also be left with a burn.")                   -- https://pokemondb.net/move/flamethrower

-- Water Type Moves
pokemonHandler.types.Water.moves.waterGun = pokemonHandler.makePokemonMove(pokemonHandler.types.Water, 1, 40, 100, 25, "The foe is blasted with a forceful shot of Water.")                                                                -- https://pokemondb.net/move/mud-slap
pokemonHandler.types.Water.moves.hydroPump = pokemonHandler.makePokemonMove(pokemonHandler.types.Water, 1, 110, 80, 5, "The foe is blasted by a huge volume of Water launched under great pressure.")                                      -- https://pokemondb.net/move/hydro-pump

-- Dark Type Moves
pokemonHandler.types.Dark.moves.bite = pokemonHandler.makePokemonMove(pokemonHandler.types.Dark, 1, 60, 100, 25, "The foe is bitten with viciously sharp fangs. It may make the target flinch.")                                          -- https://pokemondb.net/move/bite
pokemonHandler.types.Dark.moves.assurance = pokemonHandler.makePokemonMove(pokemonHandler.types.Dark, 1, 60, 100, 10, "If the foe has already taken some damage in the same turn, this attack's power is doubled.")                       -- https://pokemondb.net/move/assurance

-- Psychic Type Moves
pokemonHandler.types.Psychic.moves.confusion = pokemonHandler.makePokemonMove(pokemonHandler.types.Psychic, 1, 50, 100, 25, "The foe is hit by a weak telekinetic force. It may also leave the foe confused.")                               -- https://bulbapedia.bulbagarden.net/wiki/Confusion_(move) 
pokemonHandler.types.Psychic.moves.psychic = pokemonHandler.makePokemonMove(pokemonHandler.types.Psychic, 2, 90, 100, 10, "The foe is hit by a strong telekinetic force. It may also reduce the foe's Sp. Def stat.")                        -- https://pokemondb.net/move/Psychic

-- Flying Type Moves
pokemonHandler.types.Flying.moves.peck = pokemonHandler.makePokemonMove(pokemonHandler.types.Flying, 1, 35, 100, 35, "The foe is jabbed with a sharply pointed beak or horn.")                                                              -- https://pokemondb.net/move/peck
pokemonHandler.types.Flying.moves.wingAttack = pokemonHandler.makePokemonMove(pokemonHandler.types.Flying, 1, 60, 100, 35, "The foe is struck with large, imposing wings spread wide to inflict damage.")                                   -- https://pokemondb.net/move/wing-attack

-- Poison Type Moves
pokemonHandler.types.Poison.moves.PoisonSting = pokemonHandler.makePokemonMove(pokemonHandler.types.Poison, 1, 15, 100, 35, "The foe is stabbed with a Poisonous barb of some sort. It may also Poison the target.")                        -- https://pokemondb.net/move/Poison-sting
pokemonHandler.types.Poison.moves.PoisonJab = pokemonHandler.makePokemonMove(pokemonHandler.types.Poison, 2, 70, 100, 20, "The foe is stabbed with a tentacle or arm steeped in Poison. It may also Poison the foe.")                       -- https://pokemondb.net/move/Poison-jab

-- Ghost Type Moves
pokemonHandler.types.Ghost.moves.nightShade = pokemonHandler.makePokemonMove(pokemonHandler.types.Ghost, 2, 0, 100, 15, "The user makes the foe see a mirage. It inflicts damage matching the user's level.")                              -- https://bulbapedia.bulbagarden.net/wiki/Night_Shade_(move)
pokemonHandler.types.Ghost.moves.shadowBall = pokemonHandler.makePokemonMove(pokemonHandler.types.Ghost, 2, 80, 100, 15, "The user hurls a shadowy blob at the foe. It may also lower the foe's Sp. Def stat.")                            -- https://pokemondb.net/move/shadow-ball

-- Electric Type Moves
pokemonHandler.types.Electric.moves.thunderWave = pokemonHandler.makePokemonMove(pokemonHandler.types.Electric, 0, 0, 90, 20, "A weak Electric charge is launched at the foe. It causes paralysis if it hits.")                               -- https://pokemondb.net/move/thunder-wave
pokemonHandler.types.Electric.moves.thunderBolt = pokemonHandler.makePokemonMove(pokemonHandler.types.Electric, 2, 90, 100, 15, "A strong Electric blast is loosed at the foe. It may also leave the foe paralyzed.")                         -- https://pokemondb.net/move/thunderbolt

-- Rock Type Moves
pokemonHandler.types.Rock.moves.RockSlide = pokemonHandler.makePokemonMove(pokemonHandler.types.Rock, 1, 75, 90, 10, "Large boulders are hurled at the foe to inflict damage. It may also make the target flinch.")                       -- https://pokemondb.net/move/Rock-slide
pokemonHandler.types.Rock.moves.RockThrow = pokemonHandler.makePokemonMove(pokemonHandler.types.Rock, 1, 50, 90, 15, "The user picks up and throws a small Rock at the foe to attack.")                                                   -- https://pokemondb.net/move/Rock-throw

-- Ground Type Moves
pokemonHandler.types.Ground.moves.bulldoze = pokemonHandler.makePokemonMove(pokemonHandler.types.Ground, 1, 60, 100, 20, "The user stomps down on the Ground and attacks everything in the area. Hit Pokémon's Speed stat is reduced.")     -- https://pokemondb.net/move/bulldoze
pokemonHandler.types.Ground.moves.sandAttack = pokemonHandler.makePokemonMove(pokemonHandler.types.Ground, 0, 0, 100, 15, "Sand is hurled in the foe's face, reducing its accuracy.")                                                       -- https://pokemondb.net/move/sand-attack

-- Bug Type Moves
pokemonHandler.types.Bug.moves.BugBite = pokemonHandler.makePokemonMove(pokemonHandler.types.Bug, 1, 60, 100, 20, "The user bites the foe.")                                                                                             -- https://pokemondb.net/move/Bug-bite
pokemonHandler.types.Bug.moves.furyCutter = pokemonHandler.makePokemonMove(pokemonHandler.types.Bug, 2, 40, 95, 20, "The foe is slashed with scythes or claws. Its power increases if it hits in succession.")                           -- https://pokemondb.net/move/fury-cutter

-- Ice Type Moves
pokemonHandler.types.Ice.moves.icyWind = pokemonHandler.makePokemonMove(pokemonHandler.types.Ice, 1, 55, 95, 15, "The user attacks with a gust of chilled air.")                                                                         -- https://pokemondb.net/move/icy-wind
pokemonHandler.types.Ice.moves.avalanche = pokemonHandler.makePokemonMove(pokemonHandler.types.Ice, 1, 60, 100, 10, "The user forcefully throws a huge mound of thick snow at the foe, dealing significant damage.")                     -- https://pokemondb.net/move/avalanche

-- Steel Type Moves
pokemonHandler.types.Steel.moves.ironDefense = pokemonHandler.makePokemonMove(pokemonHandler.types.Steel, 0, 0, 100, 15, "The user hardens its body's surface like iron, sharply raising its Defense stat.")                               -- https://pokemondb.net/move/iron-defense
pokemonHandler.types.Steel.moves.SteelTail = pokemonHandler.makePokemonMove(pokemonHandler.types.Steel, 1, 100, 75, 15, "The foe is slammed with a Steel-hard tail.")                                                                      -- https://pokemondb.net/move/iron-tail

-- Dragon Type Moves
pokemonHandler.types.Dragon.moves.DragonBreath = pokemonHandler.makePokemonMove(pokemonHandler.types.Dragon, 2, 60, 100, 20, "The user exhales a mighty gust that inflicts damage. It may also paralyze the target.")                       --https://pokemondb.net/move/Dragon-breath
pokemonHandler.types.Dragon.moves.DragonClaw = pokemonHandler.makePokemonMove(pokemonHandler.types.Dragon, 1, 80, 100, 15, "Sharp, huge claws hook and slash the foe quickly and with great power.")                                        --https://pokemondb.net/move/Dragon-claw

-- Fighting Type Moves
pokemonHandler.types.Fighting.moves.armThrust = pokemonHandler.makePokemonMove(pokemonHandler.types.Fighting, 2, 15, 100, 20, "The user looses a flurry of open-palmed arm thrusts that hit two to five times in a row.")                     -- https://pokemondb.net/move/arm-thrust
pokemonHandler.types.Fighting.moves.brickBreak = pokemonHandler.makePokemonMove(pokemonHandler.types.Fighting, 1, 75, 100, 15, "The user attacks with fists strong enough to break bricks.")                                                  -- https://pokemondb.net/move/brick-break

--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--

-- Creates a new Pokemon
function pokemonHandler.makeNewPokemon(name, number, animations, pokeType, pokeType2, level, move1, move2, move3, move4, health, attack, defense, specialAttack, specialDefense, speed)
    local pokemon = {}

    -- Pokemon Name
    pokemon.name = name
    pokemon.number = number

    -- Pokemon Statuses
    pokemon.isWild = true

    -- Pokemon Animations
    pokemon.animations = animations
    pokemon.currentAnimation = pokemon.animations.frontFacing

    -- Pokemon Size and Position
    pokemon.width = 80   -- width of pokemon image
    pokemon.height = 80 -- height of pokemon image
    pokemon.x = 0       -- x-position of pokemon image (initialized at top-left corner)
    pokemon.y = 0       -- y-position of pokemon image (initialized at top-left corner)

    -- Pokemon Type
    pokemon.type1 = pokeType    -- Any type (Grass, Fire, Water, etc.)
    pokemon.type2 = pokeType2   -- Any second type (leave nil if pokemon only has one type)

    -- Pokemon Experience
    pokemon.level = level       -- Experience level (btwn 1 and 100)
    pokemon.currentXP = 0   -- Current number of experience points
    pokemon.goalXP = level * 25 -- Target number of experience points needed until next level up

    -- Pokemon Moves
    pokemon.moves = {}              -- Table to store up to four pokemon moves
    pokemon.moves.move1 = move1     -- A move table containing all of the move's information
    pokemon.moves.move2 = move2     -- A move table containing all of the move's information (or nil if pokemon shouldn't have 2nd move)
    pokemon.moves.move3 = move3     -- A move table containing all of the move's information (or nil if pokemon shouldn't have 3rd move)
    pokemon.moves.move4 = move4     -- A move table containing all of the move's information (or nil if pokemon shouldn't have 4th move)

    -- Pokemon Stats
    pokemon.baseHealth = health
    pokemon.baseAttack = attack
    pokemon.baseDefense = defense
    pokemon.baseSpecialAttack = specialAttack
    pokemon.baseSpecialDefense = specialDefense
    pokemon.baseSpeed = speed
    pokemon.baseAccuracy = 100

    pokemon.currentHealth = pokemon.baseHealth
    pokemon.currentAttack = pokemon.baseAttack
    pokemon.currentDefense = pokemon.baseDefense
    pokemon.currentSpecialAttack = pokemon.baseSpecialAttack
    pokemon.currentSpecialDefense = pokemon.baseSpecialDefense
    pokemon.currentSpeed = pokemon.baseSpeed
    pokemon.currentAccuracy = pokemon.baseAccuracy

    function pokemon.draw(pokemon) 
        love.graphics.draw(pokemonHandler.spritesheet, pokemon.animations.frontFacing[1], pokemon.x, pokemon.y, 0, 4, 4)                                 -- Draw the Animation
    end

    -- Pokemon uses a selected move against an opposing pokemon
    function pokemon.useMove(targetPokemon, move)
        
        
        for i = 1, #move.statsAffected do
            local stat = targetPokemon["current" + move.statsAffected[i]]

            if (move.category == "Status") then                                                                                                         -- If the move is in the Status category...
                stat = stat + (stat * moves.statsImpact[i])                                                                                                 -- Increase/decrease the current stat by the percentage value in statsImpact
            
            elseif (move.category == "Physical") then                                                                                                   -- Otherwise, if the move is in the Physical category...
                stat = stat + (move.statsImpact[i] * (stat / 0.5))                                                                                                          -- Increase/decrease the current stat by the
            
            elseif (move.category == "Special") then

            end

        end


        -- MAKE SURE THE MOVE ANIMATION IS PLAYED AT SOME POINT (move.playAnimation ???)
            -- Maybe Idea for this pokemon.useMove function:
            -- Have this function trigger a timer for the move (2-3 seconds?)
            -- Store the move into a currentMove variable or something like that
            -- Reset the currentMove animation to the first frame
            -- Somewhere in the battler.lua file, if (currentMove ~= nil) then move.updateAnimation??

    end

    function pokemonHandler.makePokemonMove(moveType, statsAffected, statsImpact, powerPoints, effectDescription, animations)
        local move = {}
    
        move.type = moveType                        -- Any type (Grass, Fire, Water, etc.)
        move.statsAffected = statsAffected          -- Table of Pokemon stats (as strings, like "health", or "attack", etc.) that are affected by the move (health, attack, defense, sp attack, sp defense, speed, accuracy) (pokemon[stat] would get the Pokemon's stat)
        move.statsImpact = statsImpact              -- Table of values that represent how much each stat in statsAffected should be incremented/decremented by
        move.powerPoints = powerPoints              -- Power Points (PP) of a move (number of times a move can be used without recharge) (5 min, 30 max)
        move.effectDescription = effectDescription  -- Description of the move's effect (string of text)
        move.animations = animations                -- Animations for the move
    
        -- MAKE POKEMON MOVE ANIMATIONS BE BASED ON COORDINATES (HAVE THE POKEMON MOVE TO A CERTAIN X AND Y AT CERTAIN KEYFRAMES ???)
    
        return move
    end

    -- -- If pokemon is caught, add it to player's inventory
    -- function pokemon.isCaught(pokemon, playersPokemon)
    --     pokemon.isWild = false
    --     playersPokemon.(pokemon.name) = pokemon
    -- end

    -- -- Initialized only when the pokemon is created
    -- function pokemon.initializeStats(pokemon)
    --     pokemon.healthIV = math.random(0, 31)
    --     pokemon.attackIV = math.random(0, 31)
    --     pokemon.defenseIV = math.random(0, 31)
    --     pokemon.specialAttackIV = math.random(0, 31)
    --     pokemon.specialDefenseIV = math.random(0, 31)

    --     -- Multiply given health by randomized IV value
    --     pokemon.health = pokemon.health + pokemon.healthIV
    --     pokemon.attack = pokemon.attack + pokemon.attackIV
    --     pokemon.defense = pokemon.defense + pokemon.defenseIV
    --     pokemon.specialAttack = pokemon.specialAttack + pokemon.specialAttackIV
    --     pokemon.specialDefense = pokemon.specialDefense + pokemon.specialDefenseIV
    -- end

    return pokemon
end
--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--

-- -- Generates an existing Pokemon for the game
-- function pokemonHandler.generatePokemon(pokemon)


-- end

--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--

function pokemonHandler.loadAllPokemon()
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
    
    for i = 1, #pokemonData do
        local pokemon = pokemonData[i]
    
        -- NAME
        local pokeName = pokemonData[i][1]
    
        -- NUMBER
        local pokeNumber = pokemonData[i][2]
    
        -- TYPE(S)
        local pokeType1 = pokemonHandler.types[pokemonData[i][3]]
        local pokeType2
    
        if (pokemonData[i][4] ~= "") then
            pokeType2 = pokemonHandler.types[pokemonData[i][4]]
        else
            pokeType2 = nil
        end
    
        -- LEVEL
        local pokeLevel = 5
    
        -- MOVES
        local pokeMove1 = pokemonHandler.types.Normal.moves.tackle
        local pokeMove2 = pokemonHandler.types.Normal.moves.leer
        local pokeMove3 = pokemonHandler.types.Normal.moves.growl
        local pokeMove4 = pokemonHandler.types.Normal.moves.smokescreen
    
        -- STATS
        local pokehealth = pokemonData[i][5]
        local pokeattack = pokemonData[i][6]
        local pokedefense = pokemonData[i][7]
        local pokespecialAttack = pokemonData[i][8]
        local pokespecialDefense = pokemonData[i][9]
        local pokespeed = pokemonData[i][10]
    
    
        -- ANIMATIONS 
        while (currentSpritesheetIndex == skipIndexes[1]) do
            if (currentSpritesheetIndex % 10 == 0) then
                rowCounter = rowCounter + 1
            end

            currentSpritesheetIndex = currentSpritesheetIndex + 1

            table.remove(skipIndexes, 1)
        end
    
        local x = (((currentSpritesheetIndex - 1) % 10) * shiftX) + startX
        local y = startY + (shiftY * (rowCounter - 1))
    
        local pokeAnimations = {}
        pokeAnimations.frontFacing = {}
        pokeAnimations.backFacing = {}
        pokeAnimations.shinyFrontFacing = {}
        pokeAnimations.shinyBackFacing = {}
    
        table.insert(pokeAnimations.frontFacing, love.graphics.newQuad(x, y, 80, 80, pokemonHandler.spritesheet:getDimensions()))                              -- First front pose
        table.insert(pokeAnimations.frontFacing, love.graphics.newQuad(x + width, y, 80, 80, pokemonHandler.spritesheet:getDimensions()))                      -- Second front pose
        table.insert(pokeAnimations.backFacing, love.graphics.newQuad(x + width * 2, y, 80, 80, pokemonHandler.spritesheet:getDimensions()))                   -- First back pose
        table.insert(pokeAnimations.backFacing, love.graphics.newQuad(x + width * 3, y, 80, 80, pokemonHandler.spritesheet:getDimensions()))                   -- Second back pose
    
        table.insert(pokeAnimations.shinyFrontFacing, love.graphics.newQuad(x, y + height, 80, 80, pokemonHandler.spritesheet:getDimensions()))                -- First shiny front pose
        table.insert(pokeAnimations.shinyFrontFacing, love.graphics.newQuad(x + width, y + height, 80, 80, pokemonHandler.spritesheet:getDimensions()))        -- Second shiny front pose
        table.insert(pokeAnimations.shinyBackFacing, love.graphics.newQuad(x + width * 2, y + height, 80, 80, pokemonHandler.spritesheet:getDimensions()))     -- First shiny back pose
        table.insert(pokeAnimations.shinyBackFacing, love.graphics.newQuad(x + width * 3, y + height, 80, 80, pokemonHandler.spritesheet:getDimensions()))     -- Second shiny back pose

        if (currentSpritesheetIndex % 10 == 0) then
            rowCounter = rowCounter + 1
        end
    
        table.insert(allPokemon, pokemonHandler.makeNewPokemon(pokeName, pokeNumber, pokeAnimations, pokeType, pokeType2, pokeLevel, pokeMove1, pokeMove2, pokeMove3, pokeMove4, pokehealth, pokeattack, pokedefense, pokespecialAttack, pokespecialDefense, pokespeed))

        currentSpritesheetIndex = currentSpritesheetIndex + 1
    end
    
    return allPokemon
end

return pokemonHandler
