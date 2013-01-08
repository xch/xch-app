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
  grunt.registerTask('default', 'less stylus jade coffee concat')
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
      'chrome-app': {
        src: dependencies.concat(['cache/app/chrome-extension.js']),
        dest: 'chrome-extension/xch.js'
      },
      'chrome-assets': {
        src: [
          'bootstrap',
          'bootstrap-responsive',
          'app'
        ].map(function (asset) {
          return 'cache/assets/' + asset + '.css'
        }),
        dest: 'chrome-extension/xch.css'
      }
    },
    jade: {
      no_options: {
        src: ['app/templates/*.jade'],
        dest: 'cache/templates/'
      }
    },
    stylus: {
      compile: {
        options: {
          compress: false
        },
        files: {
          'cache/assets/app.css': 'assets/app.styl'
        }
      }
    },
    less: {
      bootstrap: {
        src: 'components/bootstrap/less/bootstrap.less',
        dest: 'cache/assets/bootstrap.css'
      },
      'bootstrap-1200': {
        src: 'components/bootstrap/less/responsive.less',
        dest: 'cache/assets/bootstrap-responsive.css'
      }
    }
  })
}