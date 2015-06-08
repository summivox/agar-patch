wheel = require './wheel.js'
Kisume = require('./kisume.js').Kisume

kisume = new Kisume window, 'kisume_agar', {coffee: true}, ->
  @run wheel, -> null
