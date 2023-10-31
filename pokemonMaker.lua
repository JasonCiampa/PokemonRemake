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

moves.growl = makePokemonMove(types.normal, 0, 0, 100, 40, "The user growls in an endearing way, making the foe less wary. The target's Attack stat is lowered.") -- https://pokemondb.net/move/growl
moves.tackle = makePokemonMove(types.normal, 1, 40, 100, 35, "A physical attack in which the user charges and slams into the foe with its whole body.") -- https://pokemondb.net/move/tackle
moves.razorLeaf = makePokemonMove(types.grass, 1, 55, 95, 25, "Sharp-edged leaves are launched to slash at the foe. It has a high critical-hit ratio.")
moves.synthesis = makePokemonMove(types.grass, 0, 0, 100, 5, "The user restores its own HP.")
moves.magicalLeaf = makePokemonMove(types.grass, 2, 60, 100, 20, "The user scatters curious leaves that chase the foe. This attack will not miss.")

--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--

local pokemonHandler = {}

-- Makes a new Pokemon for the game
function pokemonHandler.makePokemon(pokeType, pokeType2, level, move1, move2, move3, move4, healthStat, attackStat, defenseStat, specialAttackStat, specialDefenseStat)
    pokemon = {}

    pokemon.isWild = true

    pokemon.type1 = pokeType    -- Any type (grass, fire, water, etc.)
    pokemon.type2 = pokeType2   -- Any second type (leave nil if pokemon only has one type)

    pokemon.level = level       -- Experience level (btwn 1 and 100)

    -- Pokemon Moves
    pokemon.moves = {}              -- Table to store up to four pokemon moves
    pokemon.moves.move1 = move1     -- A move table containing all of the move's information
    pokemon.moves.move2 = move2     -- A move table containing all of the move's information (or nil if pokemon shouldn't have 2nd move)
    pokemon.moves.move3 = move3     -- A move table containing all of the move's information (or nil if pokemon shouldn't have 3rd move)
    pokemon.moves.move4 = move4     -- A move table containing all of the move's information (or nil if pokemon shouldn't have 4th move)

    -- Multiply given health by randomized IV value
    pokemon.healthStat = healthStat + pokemon.healthIV
    pokemon.attackStat = attackStat + pokemon.attackIV
    pokemon.defenseStat = defenseStat + pokemon.defenseIV
    pokemon.specialAttackStat = specialAttackStat + pokemon.specialAttackIV
    pokemon.specialDefenseStat = specialDefenseStat + pokemon.specialDefenseIV

    -- Pokemon uses a selected move against an opposing pokemon
    function pokemon.useMove(pokemon, move, opposingPokemon)
        
    end

    -- If pokemon is caught, add it to player's inventory
    function pokemon.isCaught(pokemon, playerInventory)
        pokemon.isWild = false
    end


    return pokemon
end

function pokemonHandler.generateNewPokemon(pokemon)
    -- Initialized only when the pokemon is created
    function pokemon.initializeStats(pokemon)
        pokemon.healthIV = math.random(0, 31)
        pokemon.attackIV = math.random(0, 31)
        pokemon.defenseIV = math.random(0, 31)
        pokemon.specialAttackIV = math.random(0, 31)
        pokemon.specialDefenseIV = math.random(0, 31)

        -- Multiply given health by randomized IV value
        pokemon.healthStat = healthStat + pokemon.healthIV
        pokemon.attackStat = attackStat + pokemon.attackIV
        pokemon.defenseStat = defenseStat + pokemon.defenseIV
        pokemon.specialAttackStat = specialAttackStat + pokemon.specialAttackIV
        pokemon.specialDefenseStat = specialDefenseStat + pokemon.specialDefenseIV
    end


end

return pokemonHandler
