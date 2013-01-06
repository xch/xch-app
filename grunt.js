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
  grunt.registerTask('default', '')
  grunt.initConfig({

  })
}