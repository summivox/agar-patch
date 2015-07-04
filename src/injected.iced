###
wheel = require './wheel.js'
#Kisume = require('./kisume.js').Kisume
patch = require './patch.js'

#kisume = new Kisume window, 'kisume_agar', {coffee: true}, ->
  #@run wheel, -> null

$ = require 'jquery'
script = $('script').filter(-> @innerHTML.length > 1000)[0]
src = script.innerHTML
srcMod = patch src
script.innerHTML = srcMod
###
