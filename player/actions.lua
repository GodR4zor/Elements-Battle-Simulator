local utils = require("utils")

local actions = {}

actions.list = {}

---Retorna todas as acoes que existem.
function actions.build()
    actions.list = {}

    local mageAttack = {
        description = "Ataca o inimigo com uma bola de fogo!",
        requeriment = nil,

        execute = function (playerData, creatureData)
            -- Chances de Sucesso
            local sucessChance = creatureData.speed == 0 and 1 or (playerData.speed / creatureData.speed)
            local sucess = math.random() <= sucessChance

            -- Calcula o dano
            local rawDamage = playerData.attack - (math.random() * creatureData.defense)
            -- Dano final
            local damage = math.max(1, math.ceil(rawDamage))

            if sucess then
                -- Aplica o dano a criatura
                creatureData.health = creatureData.health - damage

                -- Mostra o resultado como print
                local healthRate = math.floor((creatureData.health / creatureData.MAXHEALTH) * 10)
                print(string.format( "%s : %s", creatureData.name, utils.getProgressBar(healthRate)))
 
            else
                print(string.format("%s errou o ataque!", playerData.name))
            end
        end
    }

    local regenLife = {
        description = "Regenera sua vida.",
        requeriment = function (playerData, creatureData)
            return playerData.potions >= 1 
        end,

        execute = function (playerData, creatureData)
            -- Remove pocao
            playerData.potions = playerData.potions - 1
            

            -- Recupera vida
            local regen = 5
            playerData.health = math.min(playerData.MAXHEALTH, (playerData.health + regen))
            print(string.format("%s usou uma pocao e recuperou alguns pontos de vida!", playerData.name))
        end
    }

    actions.list[#actions.list+1] = mageAttack
    actions.list[#actions.list+1] = regenLife

end



---Recebe o jogador e a criatura e retorna acoes validas.
---@param playerData table
---@param creatureData table
---@return table
function actions.getValidActions(playerData, creatureData)
    local validActions = {}

    for _, action in pairs(actions.list) do
        local requeriment = action.requeriment
        local isValidAction = requeriment == nil or requeriment(playerData, creatureData)

        if isValidAction then
            validActions[#validActions + 1] = action
        end
    end

    return validActions
end    

return actions