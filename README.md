# gulp_initial_project

## Spec

* Slim
* Sass
* CSS Autoprefixer
* CoffeeScript
* JavaScript Concat&Uglify
* Imagefile Minify
* BrowserSync

※ CSS Autoprefixer...オートプリフィックスに加え、メディアクエリの一括化も行う。  
※ BrowserSync... ファイルの編集/保存により、リアルタイムでブラウザが更新。またGoogle Chromeで行った操作、たとえばスクロールなどについても、その他ブラウザに反映される。

## Usage

    $ npm install --global gulp
    $ cd (project folder)
    $ npm install
    $ gulp

* デフォルトのタスクコマンド「$ gulp」においては、Sass/CoffeeScriptのコンパイルおよびHTML/CSS/JSの監視
* 「$ gulp release」においては、CSS Autoprefixer/JS Concat&Uglify/Image Minifyを行う

## Log

### 2014.09.09

* リポジトリ化
* README.md修正
