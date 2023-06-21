--[[
    | Prismarine Colossus
    | 
    | Enormes estátuas de prismarine que medem mais de 20 metros de altura. Sua aparência ameaçadora pode assustar até os mais bravos guerreiros.
    | Eles têm olhos turquesa brilhantes, mas um elogio não vai te ajudar muito durante uma batalha.
    | 
    | Atributos
    | Vida      ▰▰▰▰▰▰▰▰▰▰
    | Ataque    ▰▰▰▰▱▱▱▱▱▱
    | Defesa    ▰▰▰▰▰▰▰▰▰▰
    | Agilidade ▰▱▱▱▱▱▱▱▱▱

    O que você vai fazer?
    1. Atacar com a espada.
    2. Usar poção de regeneração.
    3. Atirar uma pedra.
    4. Se esconder.
    > 2

]]

--Dependencies
local interface = require("config.interface")
local hero = require("player.hero")
local skeleton = require("enemy.skeleton")
local boss = require("enemy.boss")
local utils = require("config.utils")
local playerActions = require("player.actions")
local enemyActions = require("enemy.actions")

interface.enableUtf8()

interface.header()

hero.makingHero()

interface.begin()

interface.skeletonApresentation()

utils.printCreature(skeleton)

-- Build actions
playerActions.build()
enemyActions.build()

-- Começar o loop de batalha
while true do

    -- Mostrar ações para o jogador
    print()
    print(string.format("Qual será a próxima ação de %s?", hero.name))
    local validPlayerActions = playerActions.getValidActions(hero, skeleton)
    for i, action in pairs(validPlayerActions) do
        print(string.format("%d. %s", i, action.description))
    end
    local chosenIndex = utils.ask()
    local chosenAction = validPlayerActions[chosenIndex]
    local isActionValid = chosenAction ~= nil

    -- Simular o turno do jogador
    if isActionValid then
        chosenAction.execute(hero, skeleton)
    else
        print(string.format("Sua escolha é inválida. %s perdeu a vez.", hero.name))
    end

    -- Ponto de saída: Criatura ficou sem vida
    if skeleton.health <= 0 then
        break
    end

    -- Simular turno da criatura
    print()
    local validBossActions = enemyActions.getValidActions(hero, skeleton)
    local bossAction = validBossActions[math.random(#validBossActions)]
    bossAction.execute(hero, skeleton)

    -- Ponto de saída: Jogador ficou sem vida
    if hero.health <= 0 then
        break
    end
end
    -- Processar condições de vitória e derrota
if hero.health <= 0 then

    interface.lostSkeletonBattle()

elseif skeleton.health <= 0 then

    interface.winSkeletonBattle()

    interface.bossApresentation()

    utils.printCreature(boss)

    
    playerActions.build()
    enemyActions.build()

    while true do

        print()
        print(string.format("Qual será a próxima ação de %s?", hero.name))
        local validPlayerActions = playerActions.getValidActions(hero, boss)
        for i, action in pairs(validPlayerActions) do
            print(string.format("%d. %s", i, action.description))
        end
        local chosenIndex = utils.ask()
        local chosenAction = validPlayerActions[chosenIndex]
        local isActionValid = chosenAction ~= nil

        
        if isActionValid then
            chosenAction.execute(hero, boss)
        else
            print(string.format("Sua escolha é inválida. %s perdeu a vez.", hero.name))
    end

    if boss.health <= 0 then
        break
    end

    print()
    local validBossActions = enemyActions.getValidActions(hero, boss)
    local bossAction = validBossActions[math.random(#validBossActions)]
    bossAction.execute(hero, boss)

    if hero.health <= 0 then
        break
    end
    end

    if hero.health <= 0 then
        interface.lostBossBattle()
    elseif boss.health <= 0 then
        interface.winBossBattle()
    end

end
