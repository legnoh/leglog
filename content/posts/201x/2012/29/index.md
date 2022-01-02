---
title: 2012-29 / さくらのレンタルサーバ/VPSに MediaWiki を導入のまとめ
slug: 2012-29
author: Ryoma Kai
date: 2012-07-18
banner: ./images/20121230185733.jpeg
excerpt: 
before_title: さくらのレンタルサーバにMediaWikiを導入のまとめ
tags: []
---

個人用のWikiを [PukiWiki](https://pukiwiki.osdn.jp/) から [MediaWiki](https://www.mediawiki.org/wiki/MediaWiki/ja) に変えようと思い、ひと通り使えるように環境構築した。

CMS だしそんなに手間はかからないだろうと思っていたら、texやエラーで案外手間取ってしまったのでメモ。

## 環境

- [さくらのレンタルサーバ　スタンダード](https://www.sakura.ne.jp/standard.html)
- [MediaWiki 1.19.1](https://www.mediawiki.org/wiki/MediaWiki/ja)
- FreeBSD 8.1
- PHP 5.3.14
- MySQL 5.5.15

共用サーバなので、下3つは元々準備済み。PHP のバージョンを変えてる人は再設定する必要がある。
CUI の方法が多く情報として出ているが、初心者なのでなるべく GUI からやってみる。

## 1.色々とダウンロード

- [MediaWiki 1.19.1](https://www.mediawiki.org/wiki/MediaWiki/ja)
- [Extension:MathJax - MediaWiki](https://www.mediawiki.org/wiki/Extension:MathJax)
    - TeXによる数式記述を可能にするプラグイン

## 2.MySQLのDBを作成

- さくらの[サーバコントロールパネル](https://secure.sakura.ad.jp/rscontrol/) を開き、「データベースの設定」→「データベースの新規作成」
  - verionは5.5、データベース名は適当に決め、文字コードはUTF-8を選択しておく。
  - サーバ、ユーザ名、パスワード、データベース名は後の手順で使うのでページを開いておくかメモしておく。

## 3.MediaWiki配置

先程DLしたMediaWikiのファイル群をサーバ上に置く。 アクセス権は755。userが自分のユーザ名になってるか確認。

基本そのままで大丈夫だが、FTPクライアントによってアクセス権を書き換えられている可能性もあるため、一応確認しておく。
また、私はCoda2を使って解凍済のものをアップロードしたが、その際 `maintenance` フォルダ周辺で原因不明のエラーが発生した。
固有の環境問題だと思うが、このフォルダはスキップされていないか特に注意した方がいい。

## 4. `.htaccess` の配置

現環境だと `images` フォルダにアップロードが効かないらしいので `.htaccess` でアクセス権を部分的に書き換えたりもにょもにょする。

`images` フォルダの中に `.htaccess` を新規作成し、その中に以下を書き込む。

```apache
<ifModule rewrite_module>
	RewriteEngine On
	RewriteCond %{QUERY_STRING} .[^\/:*?x22<>|%]+(#|?|$) [nocase]
	RewriteRule . - [forbidden]
</ifModule>

AllowOverride None
AddType text/plain .html .htm .shtml .php
php_admin_flag engine off
```

## 5. MediaWikiインストール

ブラウザから `mw-config/index.php` にアクセスし、インストール作業を行う。

途中データベースのホストと名前を聞かれるので、2.で作ったデータを入力。
データベースの種類はInnoDB,バイナリを選択。「インストールのために同じアカウント…」はチェックを入れる。

ユーザー等の設定項目をひと通り終えたらインストールも可能だが、ここでは念のため更に続行を選択。

後はプラグイン等の設定があるがプラグインに全てチェックを入れておく。使うかもしれないし。
これでインストールを実行する。途中一度だけ止まるがそのまま続行ボタンを押すとインストール完了画面になる。

## 6.ヘルプファイルのインポート

なぜか分からないが、MediaWiki の初期状態ではヘルプファイルが空の状態になっている。
そこで、MediaWiki 公式ページからこれを引っ張って来ることにする。

まず [MediaWiki公式のエクスポートページ](http://www.mediawiki.org/wiki/Special:Export) に行き、四角の大きなテキストボックスに以下を入力後、Exportボタンを押す。

```
Help:Contents/ja
Help:Navigation/ja
Help:Searching/ja
Help:Tracking_changes/ja
Help:Editing/ja
Help:Editing_pages/ja
Help:Starting_a_new_page/ja
Help:Formatting/ja
Help:Links/ja
Help:Talk_pages/ja
Help:Categories/ja
Help:Images/ja
Help:Subpages/ja
Help:Templates/ja
Help:Tables/ja
Help:Variables/ja
Help:Managing_files/ja
Help:Moving_a_page/ja
Help:Redirects/ja
Help:Deleting_a_page/ja
Help:Preferences/ja
Help:Skins/ja
Help:Namespaces/ja
Help:Range_blocks/ja
Help:Special pages/ja
Help:External searches/ja
Help:Patrolled edits/ja
Help:User_page/ja
Category:Help/ja
Template:PD_Help_Page
Template:PD
Template:Mediawiki
Template:Admin_tip/ja
Template:Hl2
Template:Hl3
Template:Thankyou
Template:Languages
Template:Languages/Lang
Image:Example.jpg
Image:Geographylogo.png
Image:PD-icon.svg
Image:PD-Help icon.png
Image:Tools.svg
Image:M-en-sidebar.png
Image:M-en-userlinks.png
Image:M-en-pagetabs.png
Image:M-en-recentchanges.png
Image:M-en-interwiki lang.png
```

xmlファイルが出力されるので、今度はそれを自分のMediaWikiのインポートページからインポートする。
日本語だとURLが変わってしまっているので、Wikiのトップページから「特別ページ」→「ページファイルの取り込み」と進むと見つかるはず。

インポートが完了しても、ヘルプファイルの目次とURLが違うため、表に出てこない。
そこで、Help:Contents/jaページで右上の▼マークから、「移動」を選び、新しいページ名に「**ヘルプ**」(セレクトボックス)と「**目次**」(フリー入力)と入力し、「ページを移動する」をクリック。
これでツールバーのリンクからヘルプ一覧にアクセスできるようになる。

## 7.MathJax有効化

`wiki` フォルダの中の `extensions` にMathJaxを置き、`LocalSetting.php` に以下を追記して拡張へのフックをかける。
ついでに MediaWikiの1.19.*だとバグがあるらしいので、キャッシュを無効化して対処する。

```php
$wgParserCacheType = CACHE_NONE;
require_once( "$IP/extensions/MathJax/MathJax.php" );
```

これで数式も表示されるようになった。
ここまで来たら一度MediaWikiのコードにリフレッシュをかけておくと吉。

```sh
[root@root]# php /var/www/html/wiki/maintenance/update.php --quick
```

[拡張の紹介ページ](http://www.mediawiki.org/wiki/Extension:MathJax) に実例が載っているので、適当なページで試してみると良い。

----

VPSでも同じ作業をした更なる蛇足を書く。

難点があちこちに散らばってて単なる拡張導入のつもりが思わぬ勉強になってしまった。


## 環境
- CentOS(x86_64) 6.2 @ さくらのVPS(2G)
- Apache 2.2.15
- MediaWiki 1.19.1
- PHP 5.3.14

以下は今からの過程で導入するもの。
- Extension:Math
- Ocaml 3.11.2
- TeX Live 2012
- ImageMagick 6.5.4-7

ここでは、MediaWiki を `/var/www/html/wiki` に導入し、URLから見れるところまで完了した、という前提で解説する。

## 下準備

yum 多用するので、Fedora EPEL,remi,rpmforgeリポジトリを過去に追加していない場合は以下を実行して全部追加しておく。

```sh
$ su
# wget http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-7.noarch.rpm
# wget http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
# wget http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.2-2.el6.rf.x86_64.rpm
# rpm -Uvh epel-release-6-7.noarch.rpm remi-release-6.rpm rpmforge-release-0.5.2-2.el6.rf.x86_64.rpm
```

更に、TeXのインストールにはX Window SystemとDesktopのインストールが必要なので、こちらも追加していなければ追加する。

```sh
# yum groupinstall "X Window System" "Desktop"
```

## 作業手順

### TeX Live 2012をインストール

```sh
$ wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
$ tar xzf install-tl-unx.tar.gz
$ install-tl-YYYYMMDD
$ ./install-tl
```

以降は対話形式のインストール画面になる。
各言語のドキュメントを対象外にすると200MB程度の容量削減になるのでやっておく。
```sh
Enter command: l
Enter letter(s) to select language(s): ABCDEFGHIJKLMNOPSTUVWXY
Enter letter(s) to select language(s): r
Enter command: i
```

30分程度放置するとインストールが完了する。
途中ネットワークアクセスが発生するので、別の作業などで帯域を使わないよう注意。ファイル受信が失敗するとインストールが止まってしまう。

### Ocaml・ImageMagickをインストール

Fedora EPEL版のImage Magickはバージョンが少し古い(6.5.4-7)ため、最新版を使いたい場合は[公式パッケージ](http://www.imagemagick.org/script/binary-releases.php) を用いること。

```sh
# yum --enablerepo=remi,epel,rpmforge install ocaml imagemagick -y
```

### rootとApacheに環境変数を設定

TeXやImageMagickは、動作のためにバイナリフォルダへの環境変数を設定する必要がある。
だが今回はApacheを介してLaTeXを用いるので、rootや他ユーザ(/etc/profileや~/.bash_profile)に環境変数を設定しても

```sh
sh: latex: command not found
```

と返されて実行することができない。
CentOSの場合は、/etc/sysconfig/httpd にApache用の環境変数設定ファイルがあるので、このファイルの末尾に以下をまるっと追加する。

```
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin:/usr/local/texlive/2012/bin/x86_64-linux
MANPATH=/usr/local/texlive/2012/texmf/doc/man
INFOPATH=/usr/local/texlive/2012/texmf/doc/info
MAGICK_HOME=/usr
LD_LIBRARY_PATH=/usr/lib64
```

あまり中身が環境変数のファイルっぽく無いが、これでちゃんと動くのでご心配なく。
念のため、rootでも動くように/etc/profile の分も更新しておく。

```sh
export PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin:/usr/local/texlive/2012/bin/x86_64-linux:$PATH
export MANPATH=/usr/local/texlive/2012/texmf/doc/man:$MANPATH
export INFOPATH=/usr/local/texlive/2012/texmf/doc/info:$PATH
export MAGICK_HOME=/usr:$MAGICK_HOME
export LD_LIBRARY_PATH=/usr/lib64:$LD_LIBRARY_PATH
```

### Extension:Math をインストール

MediaWikiに [Extension:Math](http://www.mediawiki.org/wiki/Extension:Math) を導入する。
[ここ](http://www.mediawiki.org/wiki/Special:ExtensionDistributor/Math) から「1.19.x」を選ぶと自動でDLされる。

解凍してSFTP等でサーバに送信しておくか、GUIで取って `tar xzf` するかはおまかせ。
いずれも、その後MediaWiki内の `/extensions` に格納する。

![](./images/20121230185733.jpeg)

ディレクトリ構造はこのようになっているはずだ。

#### texvcをコンパイル

`math` フォルダでコンパイルを行うと `texvc` のバイナリが３つ生成される。(`texvc`, `texvc_test`, `texvc_tex`)

```
# cd var/www/html/wiki/extensions/Math/math
# make
```

`make` は `gmake` でも良いが、Ocamlのインストールが無事に終わっていればどちらでもOK。
これを、先程パスを張った/usr/local/bin にコピー。

```sh
# cp texvc /usr/local/bin
# cp texvc_test /usr/local/bin
# cp texvc_tex /usr/local/bin
```

#### LocalSetting.phpの書き換え

`wiki` フォルダの中にある `Math.php` へのフックを最終行に追記。

```php
require_once( "$IP/extensions/Math/Math.php" );
```

初期状態の `LocalSetting.php` に追記するのはこの一行だけで良い。
`$wgUseTeX=true;` はここで書かなくても良いので、過去に書いていたのなら削除しておくこと。
更に、[CentOSを日本語環境で利用している](http://www.server-world.info/query?os=CentOS_5&amp;p=japanese) 場合は `$wgShellLocale` の値を書き換えておくのもお忘れなく。

```sh
## If you use ImageMagick (or any other shell command) on a
## Linux server, this will need to be set to the name of an
## available UTF-8 locale
$wgShellLocale = '''"ja_JP.UTF-8"''';
```

#### extensions/Math/Math.phpの書き換え

`$wgTexvc` が初期値だとどうも上手く動かないようなので、先程コピーしたフォルダへの絶対パスに変更する。

```sh
/** Location of the texvc binary */
$wgTexvc = ''''/usr/local/bin/texvc'''';
```

#### imagesフォルダのアクセス権書き換え

```sh
# chmod -R 755 /var/www/html/wiki/images
```

### 全行程完了

ここまで終わったら、MediaWikiの設定を一度更新させ、CentOS(+Apache)自体も再起動しておく。

```sh
# php /var/www/html/wiki/maintenance/update.php --quick
# reboot
```

これで数式が見れるようになっているはず。試しに以下を入力してみると出力が可能になるはずだ。

```
<math>\sum_{n=0}^\infty \frac{x^n}{n!}</math>;
```

## 参考サイト

- [Extension:Math - MediaWiki](http://www.mediawiki.org/wiki/Extension:Math)
- [ウェブ開発者のための、1時間でできるLAMP環境構築術（CentOS編）](http://tanaka.sakura.ad.jp/2011/05/centos-linux-apache-php-perl-mysql-lamp.html)
- [Apache2の環境変数PATHを設定する](http://d.hatena.ne.jp/masahi6/20090720/1248081907)
- [TeX Live のインストール](http://www.muskmelon.jp/?page_id=317)

Apache、TeX、MediaWiki とそれぞれの箇所でピンポイントな設定が必要なため、3日間くらい苦戦してしまった…。
ネット上の情報も広範囲に散らばったものが多いので、エラーログ、wiki編集中のプレビューで出てくる赤字、pngファイルの生成失敗で出てきた.tex 等…なるべく色々な場所にアンテナを立てながら設定していくことをオススメする。

----

そしてここまで書いた後に言うのもなんだけど、やっぱWordpressの方が100倍便利。(この記事も元々はMediaWikiで備忘録的に書いたものだった)

wiki より Wordpress の tag の方が探しやすいし、何より MediaWiki は VPS・レンタルサーバだとかなり重い。
極めつけに、今回書いたTeXの環境構築は、wordpressだと [JetPack](http://jetpack.me/) 導入すれば一発で対応できる。

MathJax の美麗な数式でも、[LaTeX for Wordpress](http://wordpress.org/extend/plugins/latex/) ならこれも一発だ。

まだ勉強できることが多く、良い経験にはなったものの、複数人で編集しない時にWikiは無粋だなって認識できた3日間だった。
