local utils = require("utils")

local actions = {}

actions.list = {}

---Retorna todas as acoes que existem.
function actions.build()
    actions.list = {}

    local fireAttack = {
        description = "Humble lanca um bola de fogo em direcao ao inimigo",

        execute = function (playerData, creatureData)
            -- 1 Chances de Sucesso
            local sucessChance = playerData.speed == 0 and 1 or (creatureData.speed / playerData.speed)
            local sucess = math.random() <= sucessChance

            -- 2 Calcula o dano
            local rawDamage = creatureData.attack - (math.random() * playerData.defense)
            -- Dano final
            local damage = math.max(1, math.ceil(rawDamage))

            if sucess then
                -- 3 Aplica o dano ao jogador
                playerData.health = playerData.health - damage

                -- 4 Mostra o resultado como print
                local healthRate = math.floor((playerData.health / playerData.MAXHEALTH) * 10)
                print(string.format("%s atacou %s com uma bola de fogo.", creatureData.name, playerData.name))
                print(string.format( "%s : %s", playerData.name, utils.getProgressBar(healthRate)))
 
            else
                print(string.format("%s errou o ataque!", creatureData.name))
            end
        end
    }

    local fireRegen = {
        description = "Regenera a vida da criatura.",

        execute = function (playerData, creatureData)
            -- 1 Regenera a vida da criatura
            creatureData.health = creatureData.health + 1

            -- 2 Mostra o resultado como print
            print(string.format("%s regenerou 1 ponto de vida", creatureData.name))
        end
    }

    local provocation = {
        description = "Provoca o inimigo!",

        execute = function()
            -- 1 Mostra o resultado como print
            local insults = {
                "Vai chorar?",
                "Por que nao chama a mamae?",
                "Ja vi lesmas mais fortes que voce."
            }

            local insultIndex = math.random(#insults)
            print(insults[insultIndex])
        end
    }

    actions.list[#actions.list+1] = fireAttack
    actions.list[#actions.list+1] = fireRegen
    actions.list[#actions.list+1] = provocation

end



---Recebe o jogador e a criatura e retorna acoes validas.
---@param playerData table
---@param creatureData table
---@return table
function actions.getValidActions(playerData, creatureData)
    local validActions = {}

    for _, action in pairs(actions.list) do
        validActions[#validActions+1] = action
    end

    return validActions
end    

return actions