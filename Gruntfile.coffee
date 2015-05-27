module.exports = (grunt) ->

  grunt.initConfig

    pkg: grunt.file.readJSON 'package.json'

    name: "simditor-markdown"

    coffee:
      src:
        options:
          bare: true
        files:
          'lib/<%= name %>.js': 'src/<%= name %>.coffee'
      spec:
        files:
          'spec/<%= name %>-spec.js': 'spec/<%= name %>-spec.coffee'

    sass:
      src:
        options:
          style: 'expanded'
          bundleExec: true
          sourcemap: 'none'
        files:
          'styles/<%= name %>.css': 'styles/<%= name %>.scss'

    umd:
      all:
        src: 'lib/<%= name %>.js'
        amdModuleId: '<%= name %>'
        objectToExport: 'SimditorMarkdown'
        globalAlias: 'SimditorMarkdown'
        deps:
          'default': ['$', 'Simditor', 'toMarkdown', 'marked']
          amd: ['jquery', 'simditor', 'to-markdown', 'marked']
          cjs: ['jquery', 'simditor', 'to-markdown', 'marked']
          global:
            items: ['jQuery', 'Simditor', 'toMarkdown', 'marked']
            prefix: ''

    watch:
      spec:
        files: ['spec/**/*.coffee']
        tasks: ['coffee:spec']
      scripts:
        files: ['src/**/*.coffee']
        tasks: ['coffee:src', 'umd']
      styles:
        files: ['styles/*.scss']
        tasks: ['sass:src']
      jasmine:
        files: ['lib/**/*.js', 'spec/**/*.js']
        tasks: 'jasmine'

    jasmine:
      test:
        src: ['lib/**/*.js']
        options:
          outfile: 'spec/index.html'
          specs: 'spec/<%= name %>-spec.js'
          styles: 'styles/<%= name %>.css'
          vendor: [
            'vendor/bower/jquery/dist/jquery.min.js'
            'vendor/bower/simple-module/lib/module.js'
            'vendor/bower/simple-hotkeys/lib/hotkeys.js'
            'vendor/bower/simditor/lib/simditor.js'
            'vendor/bower/to-markdown/dist/to-markdown.js'
            'vendor/bower/marked/lib/marked.js'
          ]

  grunt.loadNpmTasks 'grunt-contrib-sass'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-jasmine'
  grunt.loadNpmTasks 'grunt-umd'

  grunt.registerTask 'default', ['sass', 'coffee', 'umd', 'jasmine', 'watch']
  grunt.registerTask 'test', ['sass', 'coffee', 'umd', 'jasmine']
