local utils = {}

-- Habilite o UTF8
function utils.enableUTF8()
    os.execute("chcp 65001")
end

-- Imprime o Hadler
function utils.hadler()
    print([[
=================================================================
                            ELEMENTS
=================================================================


]])

end


function utils.getProgressBar(status)
    local fullBar = "⬜"
    local emptyBar = "⬛"
    local bar = ""

    for i = 1, 10, 1 do
        bar = bar.. (i <= status and fullBar or emptyBar)
    end

    return bar
end



---Faz o print das informacoes de uma criatura.
---@param creature table
function utils.printMonster(creature)

    -- Health Calculate
    local healthRate = math.floor((creature.health / creature.MAXHEALTH) * 10)


    print("| "..creature.name)
    print("|")
    print("| "..creature.description)
    print("|")
    print("| Atributos")
    print("|        Vida          "..utils.getProgressBar(healthRate))
    print("|        Attack        "..utils.getProgressBar(creature.attack))
    print("|        Defense       "..utils.getProgressBar(creature.defense))
    print("|        Speed         "..utils.getProgressBar(creature.speed))


end

function utils.ask()
    io.write("> ")
    -- Pede um numero, caso nao seja um numero, recebe o valor como string
    local anwser = io.read("*n") or io.read()


    return anwser
end    

return utils