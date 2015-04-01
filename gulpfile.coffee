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

gulp.task 'ejs', ->
  # json = JSON.parse fs.readFileSync('./index.json')
  gulp.src([
    Path.src + '**/*.ejs'
    '!' + Path.src + '**/_*.ejs'
  ])
  .pipe $.ejs()
  .pipe gulp.dest Path.dest
  .pipe browserSync.reload(stream: true, once: true)


# StyleSheet

gulp.task 'sass', ->
  gulp.src([
    Path.src + 'assets/css/**/*.scss'
    '!' + Path.src + 'assets/css/_lib/*.scss'
  ])
  .pipe $.rubySass
    style: 'compressed'
    sourcemap: false
    sourcemapPath: '../assets/css/'
    noCache: true
  .pipe $.pleeease
    fallbacks:
      autoprefixer: ["last 4 versions"]
    optimizers:
      minifier: false
  .pipe gulp.dest Path.dest + 'assets/css/'
  .pipe browserSync.reload(stream: true, once: true)


# JavaScript

gulp.task 'coffee', ->
  gulp.src Path.src + 'assets/js/**/*.coffee'
    .pipe $.coffee({bare:true})
    .pipe gulp.dest Path.dest + 'assets/js/'
    .pipe browserSync.reload(stream: true, once: true)

gulp.task 'concat', ->
  gulp.src Path.src + 'assets/js/*.js'
    .pipe $.concat('mod.js')
    .pipe gulp.dest Path.dest + 'assets/js/'

gulp.task 'uglify', ->
  gulp.src Path.src + 'assets/js/mod.js'
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

gulp.task 'svg', ->
  gulp.src Path.src + 'assets/svg/sprites/*.svg'
    .pipe svgSprites({
      mode: "symbols"
    })
    .pipe gulp.dest Path.dest + 'assets'


# Tasks

gulp.task 'bsReload', ->
  browserSync.reload()


# Watch

gulp.task 'default', ['bs'], ->
  gulp.watch Path.src + '*.html', ['bsReload']
  gulp.watch Path.src + '**/*.ejs', ['ejs']
  gulp.watch Path.src + 'assets/css/**/*.scss', ['sass']
  gulp.watch Path.src + 'assets/js/**/*.js', ['bsReload']
  gulp.watch Path.src + 'assets/js/*.coffee', ['coffee']


