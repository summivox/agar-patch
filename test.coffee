fs = require 'fs'
patch = require './src/patch.js'

src = fs.readFileSync 'main_out.502.js', encoding: 'utf8'
srcMod = patch src
fs.writeFileSync 'main_out.502.mod.js', srcMod, encoding: 'utf8'
