local utils = require("utils")

local actions = {}

actions.list = {}

function actions.build()
    actions.list = {}

    local waterPulse = {
        description = "Ataca um jato de agua no jogador",
        requeriment = nil,

        execute = function(playerData, creatureData)
            -- 1 Chance de sucesso
            local sucessChance = playerData.speed == 0 or 1 and (creatureData.speed / playerData.speed)
            local sucess = math.random() <= sucessChance

            -- 2 Calcula o dano
            local rawDamage = creatureData.attack - (math.random() * playerData.defense)

            -- 3 Dano Final
            local damage = math.max(1, math.ceil(rawDamage))

            if sucess then
                -- 4 Aplica o dano
                playerData.health = playerData.health - damage
                
                -- 5 Imprime a menssagem no console
                local healthRate = math.floor((playerData.health / playerData.MAXHEALTH) * 10)
                print(string.format("%s atacou %s com uma jato de agua.", creatureData.name, playerData.name))
                print(string.format("%s : %s", playerData.name, utils.getProgressBar(healthRate)))
            end

        end
    }

    local waterRegen = {
        description = "Oslo Regenera pontos de vida!",
        requeriment = function(playerData, creatureData)
            return creatureData.health < creatureData.MAXHEALTH
        end,

        execute = function(playerData, creatureData)
            -- 1 Regenera vida da criatura
            local regen = 2
            creatureData.health = math.min(creatureData.MAXHEALTH, (creatureData.health + regen))

            -- 2 Imprime a menssagem no console
            print(string.format("%s Regenerou 1 ponto de vida!", creatureData.name))
        end
    }

    local waterInsult = {
        description = "Oslo provoca seu inimigo com insultos.",
        requeriment = nil,

        execute = function (playerData, creatureData)
            -- 1 Lista de insultos
            local insultos = {"Meus peixes te comerao vivo!", "Vou dar seus ossos para os tubaroes!", "Esta com medo de se afogar? HAHAHA!"}
            -- 2 Escolhe um insulto
            local insultIndex = math.random(#insultos)

            -- 3 Imrpime o insulto 
            print(insultos[insultIndex])
        end
    }
    -- Adiciona na lista de acoes
    actions.list[#actions.list + 1] = waterPulse
    actions.list[#actions.list + 1] = waterRegen
    actions.list[#actions.list + 1] = waterInsult

end

function actions.getValidActions(playerData, creatureData)
    local validActions = {}

    for _,  action in pairs(actions.list) do
        local requeriment = action.requeriment
        local isValidaction = action.requeriment == nil or requeriment(playerData,creatureData)

        if isValidaction then
            validActions[#validActions + 1] = action
        end
    end

    return validActions

end

return actions