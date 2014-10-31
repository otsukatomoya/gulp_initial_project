gulp = require 'gulp'
$ = require('gulp-load-plugins')()
svgSprites = require 'gulp-svg-sprites'
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
  gulp.src Path.src + 'assets/css/*.scss'
    .pipe $.rubySass
      style: 'compressed'
      sourcemap: true
      sourcemapPath: '../assets/css/'
      noCache: true
    .pipe gulp.dest Path.dest + 'assets/css/'
    .pipe browserSync.reload(stream: true, once: true)

gulp.task 'ple', ->
  gulp.src Path.src + 'assets/css/*.css'
    .pipe $.pleeease
      fallbacks:
        autoprefixer: ["last 4 versions"]
      optimizers:
        minifier: false
    .pipe gulp.dest Path.dest + 'assets/css/'


# JavaScript

gulp.task 'coffee', ->
  gulp.src Path.src + 'assets/js/**/*.coffee'
    .pipe $.coffee({bare:true})
    .pipe gulp.dest Path.dest + 'assets/js/'
    .pipe browserSync.reload(stream: true, once: true)

gulp.task 'concat', ->
  gulp.src Path.src + 'assets/js/*.js'
    .pipe $.concat('stats.js')
    .pipe gulp.dest Path.dest + 'assets/js/'

gulp.task 'uglify', ->
  gulp.src Path.src + 'assets/js/stats.js'
    .pipe $.uglify()
    .pipe gulp.dest Path.dest + 'assets/js/'


# Image

gulp.task 'image', ->
  gulp.src Path.src + 'assets/img/*'
    .pipe $.cache($.image({
      progressive: true
      interlaced: true
    }))
    .pipe gulp.dest Path.dest + 'assets/img/'

gulp.task 'sprites', ->
  gulp.src Path.src + 'assets/svg/sprites/*.svg'
    .pipe svgSprites({
      mode: "symbols"
      selector: "icon-%f"
    })
    .pipe gulp.dest Path.dest + 'assets'

gulp.task 'svgmin', ->
  gulp.src Path.src + 'assets/svg/sprite.svg'
    .pipe $.svgmin()
    .pipe gulp.dest Path.dest + 'assets/svg/'


# Tasks

gulp.task 'bsReload', ->
  browserSync.reload()

gulp.task 'svg', ->
  gulp.run 'sprites', 'svgmin'

gulp.task 'release', ->
  gulp.run 'ple', 'concat', 'uglify', 'image'


# Watch

gulp.task 'default', ['bs'], ->
  gulp.watch Path.src + '*.html', ['bsReload']
  gulp.watch Path.src + 'assets/css/**/*.scss', ['sass']
  gulp.watch Path.src + 'assets/js/*.coffee', ['coffee']