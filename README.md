# gulp_initial_project

## Spec

* Slim
* Sass
* CSS Autoprefixer
* CoffeeScript
* JavaScript Concat&Uglify
* Imagefile Minify
* SVG Sprites
* SVG Minify
* BrowserSync

※ CSS Autoprefixer...オートプリフィックスに加え、メディアクエリの一括化も行う。  
※ BrowserSync... ファイルの編集/保存により、リアルタイムでブラウザが更新。またGoogle Chromeで行った操作、たとえばスクロールなどについても、その他ブラウザに反映される。

## Usage

    $ npm install --global gulp
    $ cd (project folder)
    $ npm install
    $ gulp

* デフォルトのタスクコマンド「$ gulp」においては、Sass/CoffeeScriptのコンパイルおよびHTML/CSS/JSの監視
* 「$ gulp svg」...assets/svg/sprites内のsvgでSVGスプライトを生成、圧縮する
* 「$ gulp release」...CSS Autoprefixer/JS Concat&Uglify/Image Minifyを行う

## Author

### Tomoya Otsuka

I am a Designer.

* [Portfolio](http://otsukatomoya.com)
* [twitter](https://twitter.com/tomoya_otsuka)
* [Pinterest](http://jp.pinterest.com/tomoyaotsuka/)

## License

Released under the MIT License, see LICENSE.txt.

## Log

### 2014.10.31

* gulp-svg-spritesの追加
* img, css, jsをassets内で管理

### 2014.09.26

* gulp-svgmin追加

### 2014.09.11

* gulp-cache追加（圧縮処理後の画像については判定外にする）
* src, dest 各パスをオブジェクトで管理

### 2014.09.09

* リポジトリ化
* README.md修正
