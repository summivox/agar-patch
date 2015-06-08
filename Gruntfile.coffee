module.exports = (grunt) ->
  'use strict'

  ############
  # plugins

  grunt.loadNpmTasks x for x in [
    'grunt-browserify'
    'grunt-contrib-clean'
    'grunt-contrib-copy'
    'grunt-iced-coffee'
  ]

  ############
  # config

  config = ->
    @pkg = grunt.file.readJSON('package.json')

    # default
    @clean =
      build: ['build/*']
      dist: ['dist/*']
    @copy = {}
    @coffee =
      options:
        bare: true
    @browserify = {}

    #
    @coffee.main =
      options:
        join: true
        sourceMap: true
        runtime: 'window'
      files: [
        {
          expand: true
          cwd: 'src/'
          src: '*.{iced,coffee}'
          dest: 'src/'
          ext: '.js'
        }
      ]
    @browserify.main =
      options:
        browserifyOptions:
          transform: [
            'brfs'
          ]
      files: [
        'build/background.js': 'src/background.js'
        'build/injected.js': 'src/injected.js'
      ]
    @copy.main =
      files: [
        {
          expand: true
          flatten: true
          cwd: 'build/'
          src: '*.js'
          dest: 'dist/js/'
        }
        {
          expand: true
          flatten: true
          cwd: 'img/'
          src: '*'
          dest: 'dist/img/'
        }
        {
          src: 'manifest.json'
          dest: 'dist/'
        }
      ]
    grunt.registerTask 'main', [
      'coffee:main'
      'browserify:main'
      'copy:main'
    ]

    grunt.registerTask 'default', ['main']

    @

  grunt.initConfig new config
