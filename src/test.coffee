fs = require 'fs'
src = fs.readFileSync '../main.new.js', 'utf-8'
patch = require './patch.js'

srcMod = patch src

fs.writeFileSync '../main.new.patch.js', srcMod, 'utf-8'

