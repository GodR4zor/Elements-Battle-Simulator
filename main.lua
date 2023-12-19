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

-- Comecar o loop de batalha
while true do
    -- Mostrar acoes para o jogador
    -- TODO

    -- Turno do jogador
    -- TODO

    -- Saida a criatura ficou sem vida.
    if boss.health <= 0 then
        break
    end

    -- Turno da criatura
    -- TODO

    -- Saida o jogador ficou sem vida.
    if player.health <= 0 then
        break
    end

end

-- Fim