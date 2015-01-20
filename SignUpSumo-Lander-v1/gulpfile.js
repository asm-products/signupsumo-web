

var gulp = require('gulp'),
	sass = require('gulp-ruby-sass'),
	autoprefixer = require('gulp-autoprefixer'),
	minifycss = require('gulp-minify-css'),
	jshint = require('gulp-jshint'),
	uglify = require('gulp-uglify'),
	imagemin = require('gulp-imagemin'),
	rename = require ('gulp-rename'),
	clean = require ('gulp-clean'),
	concat = require('gulp-concat'),
	notify = require('gulp-notify'),
	cache = require('gulp-cache'),
	livereload = require('gulp-livereload'),
	defineModule = require('gulp-define-module'),
	declare = require('gulp-declare'),
	runSequence = require('run-sequence'),
	connect = require('gulp-connect'),
	webserver = require('gulp-webserver'),
	cmq = require('gulp-combine-media-queries');


gulp.task('styles', function() {
	return gulp.src('app/assets/css/**/*.scss')
		.pipe(sass({
			compass: false,
			lineNumbers: true,
			loadPath: ['app/assets/css'],
			style: 'expanded'
		}))
		.pipe(autoprefixer('last 2 version', 'ie 10'))
		.pipe(rename({
			suffix: '.f' // Suffixed with .f so as to avoid any conflicts if RegularCSS files are called screen.min.css or screen.css
		}))
		.pipe(gulp.dest('public/assets/css'))
		.pipe(rename({
			suffix: '.min'
		}))
		.pipe(cmq({
      log: true
    }))
		.pipe(minifycss())
		.pipe(gulp.dest('public/assets/css'))
		.pipe(notify({
			message: "Styles task completed"
		}));
});

gulp.task('scripts', function() {
	return gulp.src([
			'app/assets/js/plugins/plugins.js',
			'app/assets/js/g.js',
			'app/assets/js/partials/*.js',
			'app/assets/js/main.js'
		])
		.pipe(concat('main.js'))
		.pipe(gulp.dest('public/assets/js'))
		.pipe(rename({
			suffix: '.min'
		}))
		.pipe(uglify())
		.pipe(gulp.dest('public/assets/js'))
		.pipe(notify({
			message: "Scripts task completed"
		}));
});

gulp.task('modernizr', function() {
	return gulp.src([
			'app/assets/js/modernizr/*.js',
		])
		.pipe(concat('modernizr-custom.js'))
		.pipe(gulp.dest('public/assets/js'))
		.pipe(notify({
			message: "modernizr task completed"
		}));
});


gulp.task('images', function() {
	return gulp.src('app/assets/images/**/*')
		.pipe(gulp.dest('public/assets/images'))
		.pipe(notify({
			message: 'Images task complete',
			onLast: true
		}));
});

gulp.task('html', function() {
	return gulp.src('app/**/*.html')
		.pipe(gulp.dest('public'))
		.pipe(notify({
			message: "HTML task complete"
		}));
});

gulp.task('all-js', function() {
	runSequence('plugins', 'scripts');
});

gulp.task('fonts', function() {
	return gulp.src('app/assets/fonts/*')
		.pipe(gulp.dest('public/assets/fonts'))
		.pipe(notify({
			message: 'Fonts task complete',
			onLast: true
		}))
});

/*
	regularCSS allows us to include CSS files that might not be able to be used within the .scss files
	Ensure to uncomment the gulp watch task and regularCSS object from the gulp build array.
*/

gulp.task('regularCSS', function() {
	return gulp.src('app/assets/css/*.css')
		.pipe(gulp.dest('public/assets/css'))
		.pipe(notify({
			message: 'Regular CSS task complete',
			onLast: true
		}))
})

gulp.task('webserver', function() {
	return gulp.src('public')
		.pipe(webserver({
			host: '0.0.0.0',
			livereload: true,
			directoryListing: false,
			port: 8000
		}));
});

gulp.task('default', ['webserver'], function() {
	gulp.watch(['app/assets/js/**/*.js'], ['scripts']);
	gulp.watch('app/assets/css/**/*.scss', ['styles']);
	// gulp.watch('app/assets/css/*.css', ['regularCSS']); // Uncomment to allow uncompiled CSS files to be used.
	gulp.watch('app/assets/images/**/*', ['images']);
	gulp.watch('app/**/*.html', ['html']);
	gulp.watch('app/assets/fonts/*', ['fonts']);
});

gulp.task('build', function() {
	runSequence(
		'scripts',
		'styles',
		'modernizr',
		// 'regularCSS' // Uncomment to allow uncompiled CSS files to be used.
		'images',
		'html',
		'fonts'
		);
});


