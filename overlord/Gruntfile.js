module.exports = function (grunt) {

  /*==========  custom tasks  ==========*/

  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),
    less: {
      default: {
        options: {
          paths: ["./public/css/less"],
          compress: true,
          syncImport: true,    // imports are read top-down
          strictImports: true, // inlines imports
          stripBanners: true,  // do not include header comments
        },
        files: {
          "./public/css/style.css": "./public/css/less/style.less"
        }
      }
    },
    browserify: {
      default: {
        files: {
          'public/js/dist/bundle.js': ['public/js/src/**/*.js'],
        },
        options: {
          browserifyOptions: {
            debug: true
          }
        }
      }
    },
    exorcise: {
      default: {
        files: {
          'public/js/dist/bundle.map': ['public/js/dist/bundle.js'],
        }
      }
    },
    watch: {
      less: {
        files: ['./public/css/less/**/*.less',
        '.public/css/less/*.less'],
        tasks: ['compile:css']
      },
      js: {
        files: ['public/js/src/**/*.js', 'package.json'],
        tasks: ['compile:js']
      }
    },
    shell: {
      shotgun: {
        command: 'shotgun config.ru'
      }
    },
    concurrent: {
      develop: {
        tasks: ['watch:less', 'watch:js', 'shell:shotgun'],
        options: {
          logConcurrentOutput: true
        }
      }
    }
  });


  /*==========  npm task registry  ==========*/

  grunt.loadNpmTasks('grunt-concurrent');
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-contrib-less');
  grunt.loadNpmTasks('grunt-browserify');
  grunt.loadNpmTasks('grunt-exorcise');
  grunt.loadNpmTasks('grunt-shell');


  /*==========  compile tasks  ==========*/

  grunt.registerTask('compile:js', ['browserify', 'exorcise']);
  grunt.registerTask('compile:css', ['less']);
  grunt.registerTask('compile:all', ['compile:js', 'compile:css']);


  /*==========  build tasks  ==========*/
  grunt.registerTask('build', ['compile:all']);


  /*==========  server tasks  ==========*/

  grunt.registerTask('up', ['compile:all', 'concurrent:develop']);
};
