local interface = require("interface")
local hero = require("player.hero")
local skeleton = require("enemy.skeleton")
local boss = require("enemy.boss")

interface.enableUtf8()

interface.header()

hero.makingHero()

print(hero.name)