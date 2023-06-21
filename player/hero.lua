local hero = {}

hero.name = "Heroi"

hero.maxHealth = 10
hero.health = 10
hero.attack = 5
hero.defense = 2
hero.speed = 4

hero.potions = 3


function hero.makingHero()
    print("Para começarmos nossa jornada insira seu nome:")
    io.write("> ")
    hero.name = io.read("*l")
    return hero.name
end

return hero