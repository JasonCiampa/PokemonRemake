-- A types table to hold all 17 pokemon types
local types = {}

-- Creates a pokemon type with tables indicating what other types it is super effective towards, not very effective towards, or has no effect towards.
local function makePokemonType(superEffectiveTowardsTable, notVeryEffectiveTowardsTable, noEffectTowards)
    local typeTable = {}
    typeTable.superEffectiveTowards = superEffectiveTowardsTable
    typeTable.notVeryEffectiveTowards = notVeryEffectiveTowardsTable
    typeTable.noEffectTowards = noEffectTowardsTable
    return typeTable
end

-- Creates all 17 pokemon types
types.bug = makePokemonType({types.dark, types.grass, types.psychic}, {types.fighting, types.fire, types.flying, types.ghost, types.poison, types.steel}, {})
types.dark = makePokemonType({types.ghost, types.psychic}, {types.dark, types.fighting, types.steel}, {})
types.dragon = makePokemonType({types.dragon}, {types.steel}, {})
types.electric = makePokemonType({types.flying, types.water}, {types.dragon, types.electric, types.grass}, {types.ground})
types.fighting = makePokemonType({types.dark, types.ice, types.normal, types.rock, types.steel}, {types.bug, types.flying, types.poison, types.psychic}, {types.ghost})
types.fire = makePokemonType({types.bug, types.grass, types.ice, types.steel}, {types.dragon, types.fire, types.rock, types.water}, {})
types.flying = makePokemonType({types.bug, types.fighting, types.grass}, {types.electric, types.rock, types.steel}, {})
types.ghost = makePokemonType({types.ghost, types.psychic}, {types.dark, types.steel}, {types.normal})
types.grass = makePokemonType({types.ground, types.rock, types.water}, {types.bug, types.dragon, types.fire, types.flying, types.grass, types.poison, types.steel}, {})
types.ground = makePokemonType({types.electric, types.fire, types.poison, types.rock, types.steel}, {types.bug, types.grass}, {types.flying})
types.ice = makePokemonType({types.dragon, types.flying, types.grass, types.ground}, {types.fire, types.ice, types.steel, types.water}, {})
types.normal = makePokemonType({}, {types.rock, types.steel}, {types.ghost})
types.poison = makePokemonType({types.grass}, {types.ghost, types.ground, types.poison, types.rock}, {types.steel})
types.psychic = makePokemonType({types.fighting, types.poison}, {types.psychic, types.steel}, {types.dark})
types.rock = makePokemonType({types.bug, types.fire, types.flying, types.ice}, {types.fighting, types.ground, types.steel}, {})
types.steel = makePokemonType({types.ice, types.rock}, {types.electric, types.fire, types.steel, types.water}, {})
types.water = makePokemonType({types.fire, types.ice, types.rock}, {types.dragon, types.grass, types.water}, {})

--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--

-- A moves table to hold all of the existing moves in the game
local moves = {}

local function makePokemonMove(moveType, category, power, accuracy, powerPoints, effectDescription)
    move = {}

    move.type = moveType                        -- Any type (grass, fire, water, etc.)
    move.category = category                    -- Category of move (status (0), physical(1), special(2))
    move.power = power                          -- Amount of damage dealt by move (number)
    move.accuracy = accuracy                    -- Accuracy of move (number between 0 and 100)
    move.powerPoints = powerPoints              -- Power Points (PP) of a move (number of times a move can be used without recharge) (5 min, 30 max)
    move.effectDescription = effectDescription  -- Description of the move's effect (string of text)

    return move
end

-- Normal Type Moves
moves.growl = makePokemonMove(types.normal, 0, 0, 100, 40, "The user growls in an endearing way, making the foe less wary. The target's Attack stat is lowered.") -- https://pokemondb.net/move/growl
moves.tackle = makePokemonMove(types.normal, 1, 40, 100, 35, "A physical attack in which the user charges and slams into the foe with its whole body.") -- https://pokemondb.net/move/tackle
moves.leer = makePokemonMove(types.normal, 0, 0, 100, 30, "The foe is given an intimidating leer with sharp eyes. The target's Defense stat is reduced.") -- https://pokemondb.net/move/leer
moves.smokescreen = makePokemonMove(types.normal, 0, 0, 100, 20, "The user releases an obscuring cloud of smoke or ink. It reduces the foe's accuracy.") -- https://pokemondb.net/move/smokescreen

-- Grass Type Moves
moves.razorLeaf = makePokemonMove(types.grass, 1, 55, 95, 25, "Sharp-edged leaves are launched to slash at the foe. It has a high critical-hit ratio.") -- https://pokemondb.net/move/razor-leaf
moves.synthesis = makePokemonMove(types.grass, 0, 0, 100, 5, "The user restores its own HP.") -- https://pokemondb.net/move/synthesis

-- Fire Type Moves
moves.flameWheel = makePokemonMove(types.fire, 1, 60, 100, 25, "The user cloaks itself in fire and charges at the foe. It may also leave the target with a burn.") -- https://pokemondb.net/move/flame-wheel
moves.flamethrower = makePokemonMove(types.fire, 2, 90, 100, 15, "The foe is scorched with an intense blast of fire. The target may also be left with a burn.") -- https://pokemondb.net/move/flamethrower

-- Water Type Moves
moves.waterGun = makePokemonMove(types.water, 1, 40, 100, 25, "The foe is blasted with a forceful shot of water.") -- https://pokemondb.net/move/mud-slap
moves.hydroPump = makePokemonMove(types.water, 1, 110, 80, 5, "The foe is blasted by a huge volume of water launched under great pressure.") -- https://pokemondb.net/move/hydro-pump

-- Dark Type Moves
moves.bite = makePokemonMove(types.dark, 1, 60, 100, 25, "The foe is bitten with viciously sharp fangs. It may make the target flinch.") -- https://pokemondb.net/move/bite
moves.assurance = makePokemonMove(types.dark, 1, 60, 100, 10, "If the foe has already taken some damage in the same turn, this attack's power is doubled.") -- https://pokemondb.net/move/assurance

-- Psychic Type Moves
moves.confusion = makePokemonMove(types.psychic, 1, 50, 100, 25, "The foe is hit by a weak telekinetic force. It may also leave the foe confused.") --https://bulbapedia.bulbagarden.net/wiki/Confusion_(move) 
moves.psychic = makePokemonMove(types.psychic, 2, 90, 100, 10, "The foe is hit by a strong telekinetic force. It may also reduce the foe's Sp. Def stat.") -- https://pokemondb.net/move/psychic

-- Flying Type Moves
moves.peck = makePokemonMove(types.flying, 1, 35, 100, 35, "The foe is jabbed with a sharply pointed beak or horn.") -- https://pokemondb.net/move/peck
moves.wingAttack = makePokemonMove(types.flying, 1, 60, 100, 35, "The foe is struck with large, imposing wings spread wide to inflict damage.")  -- https://pokemondb.net/move/wing-attack

-- Poison Type Moves
moves.poisonSting = makePokemonMove(types.poison, 1, 15, 100, 35, "The foe is stabbed with a poisonous barb of some sort. It may also poison the target.") -- https://pokemondb.net/move/poison-sting
moves.poisonJab = makePokemonMove(types.poison, 2, 70, 100, 20, "The foe is stabbed with a tentacle or arm steeped in poison. It may also poison the foe.") --https://pokemondb.net/move/poison-jab

-- Ghost Type Moves
moves.nightShade = makePokemonMove(types.ghost, 2, 0, 100, 15, "The user makes the foe see a mirage. It inflicts damage matching the user's level.") -- https://bulbapedia.bulbagarden.net/wiki/Night_Shade_(move)
moves.shadowBall = makePokemonMove(types.ghost, 2, 80, 100, 15, "The user hurls a shadowy blob at the foe. It may also lower the foe's Sp. Def stat.") -- https://pokemondb.net/move/shadow-ball

-- Electric Type Moves
moves.thunderWave = makePokemonMove(types.electric, 0, 0, 90, 20, "A weak electric charge is launched at the foe. It causes paralysis if it hits.") -- https://pokemondb.net/move/thunder-wave
moves.thunderBolt = makePokemonMove(types.electric, 2, 90, 100, 15, "A strong electric blast is loosed at the foe. It may also leave the foe paralyzed.")  -- https://pokemondb.net/move/thunderbolt

-- Rock Type Moves
moves.rockSlide = makePokemonMove(types.rock, 1, 75, 90, 10, "Large boulders are hurled at the foe to inflict damage. It may also make the target flinch.")  -- https://pokemondb.net/move/rock-slide
moves.rockThrow = makePokemonMove(types.rock, 1, 50, 90, 15, "The user picks up and throws a small rock at the foe to attack.") -- https://pokemondb.net/move/rock-throw

-- Ground Type Moves
moves.bulldoze = makePokemonMove(types.ground, 1, 60, 100, 20, "The user stomps down on the ground and attacks everything in the area. Hit Pokémon's Speed stat is reduced.")  -- https://pokemondb.net/move/bulldoze
moves.sandAttack = makePokemonMove(types.ground, 0, 0, 100, 15, "Sand is hurled in the foe's face, reducing its accuracy.")  -- https://pokemondb.net/move/sand-attack

-- Bug Type Moves
moves.bugBite = makePokemonMove(types.bug, 1, 60, 100, 20, "The user bites the foe.") -- https://pokemondb.net/move/bug-bite
moves.furyCutter = makePokemonMove(types.bug, 2, 40, 95, 20, "The foe is slashed with scythes or claws. Its power increases if it hits in succession.") -- https://pokemondb.net/move/fury-cutter

-- Ice Type Moves
moves.icyWind = makePokemonMove(types.ice, 1, 55, 95, 15, "The user attacks with a gust of chilled air.") -- https://pokemondb.net/move/icy-wind
moves.avalanche = makePokemonMove(types.ice, 1, 60, 100, 10, "The user forcefully throws a huge mound of thick snow at the foe, dealing significant damage.") -- https://pokemondb.net/move/avalanche

-- Steel Type Moves
moves.ironDefense = makePokemonMove(types.steel, 0, 0, 100, 15, "The user hardens its body's surface like iron, sharply raising its Defense stat.")   -- https://pokemondb.net/move/iron-defense
moves.steelTail = makePokemonMove(types.steel, 1, 100, 75, 15, "The foe is slammed with a steel-hard tail.")  -- https://pokemondb.net/move/iron-tail

-- Dragon Type Moves
moves.dragonBreath = makePokemonMove(types.dragon, 2, 60, 100, 20, "The user exhales a mighty gust that inflicts damage. It may also paralyze the target.") --https://pokemondb.net/move/dragon-breath
moves.dragonClaw = makePokemonMove(types.dragon, 1, 80, 100, 15, "Sharp, huge claws hook and slash the foe quickly and with great power.") --https://pokemondb.net/move/dragon-claw

-- Fighting Type Moves
moves.armThrust = makePokemonMove(types.fighting, 2, 15, 100, 20, "The user looses a flurry of open-palmed arm thrusts that hit two to five times in a row.") -- https://pokemondb.net/move/arm-thrust
moves.brickBreak = makePokemonMove(types.fighting, 1, 75, 100, 15, "The user attacks with fists strong enough to break bricks.") -- https://pokemondb.net/move/brick-break

--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--

local pokemon = {}

local function makePokemon(name, image, pokeType, pokeType2, level, move1, move2, move3, move4, healthStat, attackStat, defenseStat, specialAttackStat, specialDefenseStat)
    pokemon = {}

    -- Pokemon Name
    pokemon.name = name

    -- Pokemon Statuses
    pokemon.isWild = true

    -- Pokemon Image, Size, and Position
    pokemon.image = love.graphics.newImage(image)   -- image variable should be a path to an image
    pokemon.width = image:getWidth()    -- width of pokemon image
    pokemon.height = image:getHeight() -- height of pokemon image
    pokemon.x = 0       -- x-position of pokemon image (initialized at top-left corner)
    pokemon.y = 0       -- y-position of pokemon image (initialized at top-left corner)

    -- Pokemon Type
    pokemon.type1 = pokeType    -- Any type (grass, fire, water, etc.)
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
    -- Multiply given health by randomized IV value
    pokemon.healthStat = healthStat
    pokemon.attackStat = attackStat
    pokemon.defenseStat = defenseStat
    pokemon.specialAttackStat = specialAttackStat
    pokemon.specialDefenseStat = specialDefenseStat

    -- Pokemon uses a selected move against an opposing pokemon
    function pokemon.useMove(pokemon, move, opposingPokemon)
        
    end

    -- If pokemon is caught, add it to player's inventory
    function pokemon.isCaught(pokemon, playersPokemon)
        pokemon.isWild = false
        playersPokemon.(pokemon.name) = pokemon
    end


    return pokemon
end
--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--

local pokemonHandler = {}

-- Generates an existing Pokemon for the game
function pokemonHandler.generateNewPokemon(pokemon)
    -- Initialized only when the pokemon is created
    function pokemon.initializeStats(pokemon)
        pokemon.healthIV = math.random(0, 31)
        pokemon.attackIV = math.random(0, 31)
        pokemon.defenseIV = math.random(0, 31)
        pokemon.specialAttackIV = math.random(0, 31)
        pokemon.specialDefenseIV = math.random(0, 31)

        -- Multiply given health by randomized IV value
        pokemon.healthStat = pokemon.healthStat + pokemon.healthIV
        pokemon.attackStat = pokemon.attackStat + pokemon.attackIV
        pokemon.defenseStat = pokemon.defenseStat + pokemon.defenseIV
        pokemon.specialAttackStat = pokemon.specialAttackStat + pokemon.specialAttackIV
        pokemon.specialDefenseStat = pokemon.specialDefenseStat + pokemon.specialDefenseIV
    end


end

return pokemonHandler
