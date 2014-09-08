/**
 * Created by jbonfante on 8/30/14.
 */
module.exports = function (grunt) {

    // Project configuration.
    grunt.initConfig({
            pkg: grunt.file.readJSON('package.json'),
            uglify: {
                options: {
                    banner: '/*! <%= pkg.name %> <%= grunt.template.today("yyyy-mm-dd") %> */\n'
                },
                build: {
                    src: 'src/<%= pkg.name %>.js',
                    dest: 'build/<%= pkg.name %>.min.js'
                }
            },
            bowercopy: {
                options: {
                    srcPrefix: 'bower_components'
                },
                fonts: {
                    options: {
                        destPrefix: 'public/fonts'
                    },
                    files: {
                        '': 'bootstrap/fonts/*.*'
//                        'angular/angular.js': 'angular/angular.js'
//                        'react/react.js': 'react/react.js'
                    }
                },
                angularjs_utilities:{
                    options: {
                        destPrefix: 'public/js/'
                    },
                    files: {
                        'directives/': 'angularjs-utilities/src/directives/*.*',
                        'modules/': 'angularjs-utilities/src/modules/*.*'
//                        'angular/angular.js': 'angular/angular.js'
//                        'react/react.js': 'react/react.js'
                    }
                },

            },
            concat: {
                angular: {
                    files: {
                        'public/js/angular.js': ['bower_components/angular/angular.js', 'bower_components/angular-resource/angular-resource.js', 'bower_components/angular-route/angular-route.js'
                        ]
                    }
                },
                ngKeypad:{
                    files: {
                        'public/js/modules/ngKeypad.js': ['bower_components/ng-keypad/src/ngKeypad/*.js'],
                        'public/js/modules/ngDraggable.js': ['bower_components/ng-keypad/src/ngDraggable/*.js']
                    }
                },
                bootstrap: {
                    files: {
                        'public/js/bootstrap.js': ['bower_components/bootstrap/dist/js/bootstrap.js'],
                        'public/css/bootstrap.css': ['bower_components/bootstrap/dist/css/bootstrap.css'],
                        'public/css/bootstrap.css.map': ['bower_components/bootstrap/dist/css/bootstrap.css.map'],
                        'public/css/bootstrap-theme.css': ['bower_components/bootstrap/dist/css/bootstrap-theme.css'],
                        'public/css/bootstrap-theme.css.map': ['bower_components/bootstrap/dist/css/bootstrap-theme.css.map']
                    }
                },
                jquery: {
                    files: {
                        'public/js/jquery.js': ['bower_components/jquery/jquery.js'],
                        'public/js/jquery.steps.js': ['bower_components/jquery-steps/build/jquery.steps.js'],
                        'public/css/jquery.steps.css':['bower_components/jquery-steps/demo/css/jquery.steps.css']
                    }
                },
                sprintf: {
                    files: {
                        'public/js/sprintf.js': ['bower_components/sprintf/src/sprintf.js']
                    }
                }

            },
            "bower-install-simple": {
                options: {
                    color: true,
                    directory: "bower_components"
                },
                "prod": {
                    options: {
                        production: true
                    }
                },
                "dev": {
                    options: {
                        production: false
                    }
                }
            }
        }
    )
    ;


// Load the plugin that provides the "uglify" task.
    grunt.loadNpmTasks('grunt-contrib-uglify');
    grunt.loadNpmTasks('grunt-bower-install-simple');
    grunt.loadNpmTasks('grunt-contrib-concat');
    grunt.loadNpmTasks('grunt-bowercopy');

// Default task(s).
    grunt.registerTask('default', ['uglify']);
    grunt.registerTask('bower', [
        'bower-install',
        'concat',
        'bowercopy'
    ]);
    grunt.registerTask("bower-install", [ "bower-install-simple" ]);
//    grunt.registerTask("concat", ["concat"])


}
;