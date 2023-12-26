local utils = require("utils")

local actions = {}

actions.list = {}

function actions.build()
    actions.list = {}

    local airStorm = {
        description = "Ataca um tornado em direcao ao jogador!",
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
                print(string.format("%s atacou %s com um tornardo.", creatureData.name, playerData.name))
                print(string.format("%s : %s", playerData.name, utils.getProgressBar(healthRate)))
            end

        end
    }

    local airArrow = {
        description = "Asto ataca 3 flechas de vento ao jogador",
        requeriment = nil,

        execute = function(playerData, creatureData)
            for i = 1,3,1 do
                -- 1 Calcula chance de sucesso
                local sucessChance = playerData.speed == 0 or 1 and (creatureData.speed / playerData.speed)
                local sucess = math.random() <= sucessChance

                -- 2 Calcula o dano
                local rawDamage = creatureData.attack - (math.random() * playerData.defense)

                -- 3 Dano final
                local damage = math.max(1, (math.ceil(rawDamage) * 0.3))

                -- 4 Aplica o dano em caso de sucesso
                if sucess then
                    playerData.health = playerData.health - damage
                end

                -- 5 Imprime o dano no console
                local healthRate = math.floor((playerData.health / playerData.MAXHEALTH) * 10)
                print(string.format("%s atacou %s uma flecha de vento.", creatureData.name, playerData.name))
                print(string.format("%s : %s", playerData.name, utils.getProgressBar(healthRate)))
            end
        end
    }

    local airInsult = {
        description = "Oslo provoca seu inimigo com insultos.",
        requeriment = nil,

        execute = function (playerData, creatureData)
            -- 1 Lista de insultos
            local insultos = {"Um assopro e voce deixa de viver!", "Se considera um mestre no que faz? Pobre garoto", "Meus tornardos farao de voce picadinho!"}
            -- 2 Escolhe um insulto
            local insultIndex = math.random(#insultos)

            -- 3 Imrpime o insulto 
            print(insultos[insultIndex])
        end
    }
    -- Adiciona na lista de acoes
    actions.list[#actions.list + 1] = airStorm
    actions.list[#actions.list + 1] = airArrow
    actions.list[#actions.list + 1] = airInsult

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