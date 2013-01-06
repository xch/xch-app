module.exports = function (grunt) {
  ([
    'grunt-stylus',
    'grunt-coffee',
    'grunt-less',
    'grunt-jade',
    'grunt-replace'
  ]).forEach(function (task) {
    grunt.loadNpmTasks(task)
  })
  grunt.registerTask('default', 'jade coffee concat')
  var dependencies = (dependencies = require('./dependencies')).components.concat(dependencies.templates.concat(dependencies.app))
  grunt.initConfig({
    coffee: {
      app: {
        src: ['app/**/*.coffee', 'app/*.coffee'],
        dest: 'cache/app/',
        options: {
          bare: false
        }
      },
      'chrome-extension': {
        src: ['app/chrome-extension.coffee'],
        dest: 'cache/app/',
        options: {
          base: true
        }
      }
    },
    concat: {
      chrome: {
        src: dependencies.concat(['cache/app/chrome-extension.js']),
        dest: 'chrome-extension/xch.js'
      }
    },
    jade: {
      no_options: {
        src: ['app/templates/*.jade'],
        dest: 'cache/templates/'
      }
    }
  })
}