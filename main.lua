-- Dependencias
local utils = require("utils")
local player = require("player.player")
local humble = require("Humble.humble")
-- Actions
local playerActions = require("player.actions")
local humbleActions = require("Humble.actions")

-- Habilita UTF-8
utils.enableUTF8()

-- Header
utils.hadler()

-- Obter definicao do monstro
local boss = humble

-- Apresentar o monstro
utils.printMonster(boss)

-- Buildar acoes
playerActions.build()
humbleActions.build()

-- Comecar o loop de batalha
while true do
    -- Mostrar acoes para o jogador
    print("")
    print(string.format("Qual acao %s ira tomar?", player.name))
    local validPlayerActions = playerActions.getValidActions(player, boss)
    for i, action in pairs(validPlayerActions) do
        print(string.format("%d : %s", i, action.description))
    end

    local chosenIndex = utils.ask()
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
    local validBossAction = humbleActions.getValidActions(player, boss)
    local bossAction = validBossAction[math.random(#validBossAction)]

    bossAction.execute(player, boss)

    -- Turno da criatura
    -- TODO

    -- Saida o jogador ficou sem vida.
    if player.health <= 0 then
        print(string.format( "%s morreu!", player.name))
        break
    end

end

-- Fim