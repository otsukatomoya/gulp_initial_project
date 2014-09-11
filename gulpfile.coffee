gulp = require 'gulp'
$ = require('gulp-load-plugins')()
browserSync = require 'browser-sync'

Path =
  src: '_template/'
  dest: '_template/'


# BrowserSync

gulp.task 'bs', ->
  browserSync.init(null, {
    server:
      baseDir: Path.src
  })

# HTML

gulp.task 'slim', ->
  gulp.src Path.src + '*.slim'
    .pipe $.slim()
    .pipe gulp.dest Path.dest


# StyleSheet

gulp.task 'sass', ->
  gulp.src Path.src + 'css/*.scss'
    .pipe $.rubySass
      style: 'compressed'
      sourcemap: true
      sourcemapPath: '../css/'
      noCache: true
    .pipe gulp.dest Path.dest + 'css/'
    .pipe browserSync.reload(stream: true, once: true)

gulp.task 'ple', ->
  gulp.src Path.src + 'css/*.css'
    .pipe $.pleeease
      fallbacks:
        autoprefixer: ["last 4 versions"]
      optimizers:
        minifier: false
    .pipe gulp.dest Path.dest + 'css/'


# JavaScript

gulp.task 'coffee', ->
  gulp.src Path.src + 'js/**/*.coffee'
    .pipe $.coffee({bare:true})
    .pipe gulp.dest Path.dest + 'js/'
    .pipe browserSync.reload(stream: true, once: true)

gulp.task 'concat', ->
  gulp.src Path.src + 'js/*.js'
    .pipe $.concat('stats.js')
    .pipe gulp.dest Path.dest + 'js/'

gulp.task 'uglify', ->
  gulp.src Path.src + 'js/stats.js'
    .pipe $.uglify()
    .pipe gulp.dest Path.dest + 'js/'


# Image

gulp.task 'image', ->
  gulp.src Path.src + 'img/*'
    .pipe $.cache($.image({
      progressive: true
      interlaced: true
    }))
    .pipe gulp.dest Path.dest + 'img/'


# Tasks

gulp.task 'bsReload', ->
  browserSync.reload()

gulp.task 'release', ->
  gulp.run 'ple', 'concat', 'uglify', 'image'


# Watch

gulp.task 'default', ['bs'], ->
  gulp.watch Path.src + '*.html', ['bsReload']
  gulp.watch Path.src + 'css/**/*.scss', ['sass']
  gulp.watch Path.src + 'js/*.coffee', ['coffee']