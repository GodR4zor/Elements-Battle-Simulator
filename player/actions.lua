local actions = {}

actions.list = {}

function actions.build()
    actions.list = {}

    local mageAttack = {
        description = "",
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
                print(string.format("Voce causou %d de dano a criatura!", damage))

                -- Aplica o dano a criatura
                creatureData.health = creatureData.health - damage
            else
                print("Voce errou o ataque!")
            end
        end
    }

    local potions = {
        description = "",
        requeriment = function (playerData, creatureData)
            return playerData.potions >= 1 
        end,

        execute = function (playerData, creatureData)
            -- Remove pocao
            playerData.potions = playerData.potions - 1


            -- Recupera vida
            local regen = 5
            playerData.health = math.min(playerData.MAXHEALTH, (playerData.health + regen))
        end
    }
end

function actions.getValidActions()

end    

return actions