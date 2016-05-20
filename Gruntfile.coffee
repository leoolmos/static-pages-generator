module.exports = (grunt) ->

	grunt.initConfig
		pkg: grunt.file.readJSON("package.json")

		## Coffee ----------------------------------------------------------------

		coffee:
			compile:
				expand: true
				cwd: 'src'
				src: ['**/*.coffee']
				dest: 'build'
				ext: '.js'


		## Sass -----------------------------------------------------------------

		sass:
			dist:
				files: [
					expand: true
					cwd: 'src'
					src: ['**/*.scss']
					dest: 'build'
					ext: '.css'
				]

		## Handlebars -----------------------------------------------------------

		handlebarslayouts:
			dev:
				files:
					'build/*.html': 'src/templates/*.hbs'
				options:
					partials: [
						'src/components/**/*.hbs'
						'src/partials/**/*.hbs'
						'src/layout.hbs'
					]


		## Copy ----------------------------------------------------------------

		copy:
			img:
				expand: true
				cwd: 'src'
				src: ['**/*.{jpg,gif,png}']
				dest: 'build'

		## Clean ---------------------------------------------------------------

		clean:
			img:
				src: ['build/img']

		## Watch ---------------------------------------------------------------

		watch:
			options:
				spawn: false
				livereload: true

			img:
				files: ['src/**/*.{jpg,gif,png}']
				tasks: ['clean:img','copy:img']

			hbs:
				files: ['src/**/*.hbs']
				tasks: ['handlebarslayouts']

			coffee:
				files: ['src/**/*.coffee']
				tasks: ['coffee:compile']

			sass:
				files: ['src/**/*.scss']
				tasks: ['sass']

	## Load Tasks --------------------------------------------------------------

	## measures the time each task takes
	require('time-grunt')(grunt);

	## load grunt tasks
	require('load-grunt-tasks')(grunt);

	## Register Tasks ----------------------------------------------------------

	grunt.registerTask "default", ['clean:img','copy:img','coffee:compile','sass','handlebarslayouts']