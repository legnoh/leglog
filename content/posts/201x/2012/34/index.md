---
title: 2012-34 / TermExtract関連まとめ
slug: 2012-34
author: Ryoma Kai
date: 2012-08-20
excerpt: 
before_title: TermExtract関連まとめ
tags: []
---

大学の研究で [TermExtract](http://gensen.dl.itc.u-tokyo.ac.jp/termextract.html) というPerlモジュールを使ってテキスト解析を行おうとしてるのだけど、その初期設定だけで実家での作業が終わってしまう珍事、というより失態を晒してるので中間発表が既に危うい。スライドとレジュメ作成作業がまだ手付かずなので佐賀に帰ったら引篭り確定かな…。

作業記録用に今まで見てきたブログとか設定記事をまとめておくことにする。

## TermExtract関連

- [TermExtract Perlで出来る特徴語抽出 - プログラマになりたい](http://d.hatena.ne.jp/dkfj/20080804/1217819879)
- [ExtractTermで専門用語抽出 - mizchi log](http://d.hatena.ne.jp/mizchi/20100610/1276153122)
- [似た記事検索への長い道のり - みきろぐ♪](http://www.ttvision.com/blog/archives/2006/02/14-0122.php)
- [NAL研卒業研究ノート:: nemoへMeCabとTermExtractをインストール](http://www.nal.ie.u-ryukyu.ac.jp/note/note_detail/562/)
- [30分で理解する自然言語処理　まとめ - プログラマになりたい](http://d.hatena.ne.jp/dkfj/20080806/1217976619)

## Perl関連

- [「はてな教科書」をgithub上に公開しました - Hatena Developer Blog](http://developer.hatenastaff.com/entry/2012/04/11/104325)
- [PHPプロ！TIPS+ ファイルの文字コードをコマンドで一気に変換](http://www.phppro.jp/phptips/archives/vol30/1)
- [Perlデバッガの手引き - サンプルコードによるPerl入門](http://d.hatena.ne.jp/perlcodesample/20100302/1269670120)

## その他

- [テキスト解析:キーフレーズ抽出API - Yahoo!デベロッパーネットワーク](http://developer.yahoo.co.jp/webapi/jlp/keyphrase/v1/extract.html)

形態素解析は [MeCab](http://mecab.googlecode.com/svn/trunk/mecab/doc/index.html) を使用。UTF-8の文章を形態素解析できるところまでは確認したが、TermExtractに読み込ませると結果がemptyで返ってきてしまう。(モジュール自体は正常に動いているのだが、サンプルスクリプトから標準出力に出力結果が出て来ない。。。)恐らくモジュールの文字コードまわりの問題だと思われるのだけど、考えられる原因は全て当たったが期待どおりの結果は出ず。若干キレ気味に

```sh
find /usr/local/share/perl5/TermExtract -name '*.pm' | xargs nkf --overwrite -w
```

とか強硬策に出たりしたものの結果変わらず。多分凡ミスの気はするんだけど、これだけでずっと作業が止まってること考えると胃が痛い…。

また、悪銭苦闘中に見つけた [Yahoo!のキーフレーズ抽出API](http://developer.yahoo.co.jp/webapi/jlp/keyphrase/v1/extract.html) は TermExtract と同等のランク付けが行えるし、実際コード書いてみたら十分な結果が得られたのだが、APIという特性上 **長文が送信できない** という最大の弱点があった。40件くらいのデータまとめて送った所でERROR返されたので、短文で何度もリクエスト出すことになるが、スピードとランク出した後の結果統合の手間暇を考えると現実的な手段とは到底言い難い。

そんなこんなで、現実解としてはTermExtractさん機嫌直してくれよーと言いたいところだけれど、現状手詰まり感半端ないので佐賀で中間発表の準備と並行しながら解決策を考える所存。
