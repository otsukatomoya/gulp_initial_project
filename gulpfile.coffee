gulp = require 'gulp'
$ = require('gulp-load-plugins')()
browserSync = require 'browser-sync'


# BrowserSync

gulp.task 'bs', ->
  browserSync.init(null, {
    server:
      baseDir: '_template/'
  })

# HTML

gulp.task 'slim', ->
  gulp.src '_template/*.slim'
    .pipe $.slim()
    .pipe gulp.dest '_template/'


# StyleSheet

gulp.task 'sass', ->
  gulp.src '_template/css/*.scss'
    .pipe $.rubySass
      style: 'compressed'
      sourcemap: true
      sourcemapPath: '../css/'
      noCache: true
    .pipe gulp.dest '_template/css/'
    .pipe browserSync.reload(stream: true, once: true)

gulp.task 'ple', ->
  gulp.src '_template/css/*.css'
    .pipe $.pleeease
      fallbacks:
        autoprefixer: ["last 4 versions"]
      optimizers:
        minifier: false
    .pipe gulp.dest '_template/css/'


# JavaScript

gulp.task 'coffee', ->
  gulp.src '_template/js/**/*.coffee'
    .pipe $.coffee({bare:true})
    .pipe gulp.dest '_template/js/'
    .pipe browserSync.reload(stream: true, once: true)

gulp.task 'concat', ->
  gulp.src '_template/js/*.js'
    .pipe $.concat('stats.js')
    .pipe gulp.dest '_template/js/'

gulp.task 'uglify', ->
  gulp.src '_template/js/stats.js'
    .pipe $.uglify()
    .pipe gulp.dest '_template/js/'


# Image

gulp.task 'image', ->
  gulp.src '_template/img/*'
    .pipe $.image()
    .pipe gulp.dest '_template/img/'


# Tasks

gulp.task 'bsReload', ->
  browserSync.reload()

gulp.task 'release', ->
  gulp.run 'ple', 'concat', 'uglify', 'image'


# Watch

gulp.task 'default', ['bs'], ->
  gulp.watch '_template/*.html', ['bsReload']
  gulp.watch '_template/css/**/*.scss', ['sass']
  gulp.watch '_template/js/*.coffee', ['coffee']