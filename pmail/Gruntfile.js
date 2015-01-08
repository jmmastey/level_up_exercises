module.exports = function(grunt) {

  // Project configuration.
  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),

    concat: {
      dist: {
        src: ['js/main.js', 'js/plugins/*.js'],
        dest: 'js/build/production.js'
      }
    },

    uglify: {
        build: {
            src: 'js/build/production.js',
            dest: 'js/build/production.min.js'
        }
    },

    imagemin: {                          // Task
      dynamic: {                         // Another target
        options: {
          cache: false
        },
        files: [{
          expand: true,                  // Enable dynamic expansion
          cwd: 'img/prebuild',                   // Src matches are relative to this path
          src: ['**/*.{png,jpg,gif}'],   // Actual patterns to match
          dest: 'img/build/'                  // Destination path prefix
        }]
      }
    },

    sass: {                              // Task
      dist: {                            // Target
        options: {                       // Target options
          style: 'compressed'
        },
        files: {                         // Dictionary of files
          'css/build/main_unprefixed.css': 'sass/styles.scss'      // 'destination': 'source'
        }
      }
    },

    svgstore: {
      options: {
        prefix : 'shape-',
      },
      default : {
          files: {
            'img/svg-defs.svg': ['svgs/*.svg'],
          }
      }
    },

    autoprefixer: {

      single_file: {
        src: 'css/build/main_unprefixed.css',
        dest: 'css/build/main.css'
      },
    },

    connect: {
      uses_defaults: {}
    },

    watch: {
      scripts: {
        files: ['js/main.js', 'js/plugins/*.js'],
        tasks: ['concat','uglify'],
        options: {
          spawn: false,
        },
      },

      css: {
        files: ['sass/*.scss', 'sass/*/*.scss'],
        tasks: ['sass'],
        options: {
          spawn: true,
        },
      },

      styles: {
          files: ['css/build/main_unprefixed.css'],
          tasks: ['autoprefixer']
      },

    }

  });

  // Load the plugin that provides the "uglify" task.
  grunt.loadNpmTasks('grunt-contrib-concat');
  grunt.loadNpmTasks('grunt-contrib-uglify');
  grunt.loadNpmTasks('grunt-contrib-imagemin');
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-contrib-sass');
  grunt.loadNpmTasks('grunt-autoprefixer');
  grunt.loadNpmTasks('grunt-contrib-connect');
  grunt.loadNpmTasks('grunt-svgstore');

  // Default task(s).
  // Need to manually run imagemin
  grunt.registerTask('default', ['concat', 'uglify', 'sass', 'autoprefixer', 'connect', 'watch']);


};
