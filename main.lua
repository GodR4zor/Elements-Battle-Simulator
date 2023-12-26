-- Dependencias
local utils = require("utils")
local player = require("player.player")
local humble = require("Creatures.Humble.humble")
local oslo = require("Creatures.Oslo.oslo")
local asto = require("Creatures.Asto.asto")
-- Actions
local playerActions = require("player.actions")
local humbleActions = require("Creatures.Humble.actions")
local osloActions = require("Creatures.Oslo.actions")
local astoActions = require("Creatures.Asto.actions")

-- Creatures
local creatures = {oslo, humble, asto}
local creaturesActions = {osloActions, humbleActions, astoActions}

-- Habilita UTF-8
utils.enableUTF8()

-- Header
utils.hadler()

-- Obter definicao do monstro
local bossNumber = math.random(#creatures)
local boss = creatures[bossNumber]
local getBossAction = creaturesActions[bossNumber]


-- Apresentar o monstro
utils.printMonster(boss)

-- Buildar acoes
playerActions.build()
humbleActions.build()
osloActions.build()
astoActions.build()

-- Comecar o loop de batalha
while true do
    local chosenIndex = nil
    -- Mostrar acoes para o jogador
    print("")
    print(string.format("Qual acao %s ira tomar?", player.name))
    local validPlayerActions = playerActions.getValidActions(player, boss)
    for i, action in pairs(validPlayerActions) do
        print(string.format("%d : %s", i, action.description))
    end

    -- Jogador escolhe a acao
    chosenIndex = utils.ask()
    local chosenAction = validPlayerActions[chosenIndex]
    local isValidAction = chosenAction ~= nil



    -- Turno do jogador
    if isValidAction then
        chosenAction.execute(player, boss)
    else
        print(string.format("%s errou a acao, perdeu sua vez!", player.name))
    end

    -- Saida a criatura ficou sem vida.
    if boss.health <= 0 then
        print(" ")
        print(string.format( "%s matou o boss!", player.name))
        break
    end

    -- Turno da criatura
    print(" ")
    local validBossAction = getBossAction.getValidActions(player, boss)
    local bossAction = validBossAction[math.random(#validBossAction)]

    bossAction.execute(player, boss)
    -- TODO

    -- Saida o jogador ficou sem vida.
    if player.health <= 0 then
        print(string.format( "%s morreu!", player.name))
        break
    end

end

-- Fim