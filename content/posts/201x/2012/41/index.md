---
title: 2012-41 / Ubuntu@VMwareFusion で OpenGazer を使う
slug: 2012-41
author: Ryoma Kai
date: 2012-10-11
hero: ./images/20121230191243.jpeg
excerpt: 
before_title: Ubuntu@VMwareFusion で OpenGazer を使う
tags: []
---

友人が悩んでいるようなので俺も1年ぶりくらいにUbuntu触りながら後追いしてみた。(このエントリは途中で挫折してるので、参考にされる際はお気をつけ下さい)

## 環境

- VMWare Fusion 5
- Ubuntu 12.04 (64bit)
- OpenCV
- OpenGazer 0.1.2
- VXL 1.17.0
- MPlayer

流石にタルいのでVMwareFusion入ってることは前提で。ネット回線はMac共有で構わない。
後Fusionのバージョンはそんなに関係なさそうな感じ。

## 1.Ubuntu12.04(64bit)ダウンロード

[ここ](http://www.ubuntu.com/download/desktop) から64bit版を選びダウンロード。32bit推奨になってるけど大体64bitで大丈夫でしょって感じで。

## 2.Ubuntuインストール

VmwareFusion上にインストール。この時 **簡易インストールは外す**。
後々エラーやバグの温床になる可能性が非常に高いので。

インストールする際、英語に慣れてない時は日本語環境に設定しておく。
これは単に試すかインストールするかの選択画面の左側にセレクトボックスがあるのでこちらから選ぶ。

## 3.公式アップデート

無事インストールが完了したらまずは公式アップデートを一通りしておく。
左上の「Dashホーム」から「update」とタイプして「アップデートマネージャ」を起動。
数百個アップデートがあるはずなので全部チェックを入れてさくっとアップデートを終わらせる。終わったら再起動。

## 4.Google日本語入力(mozc)インストール

左上の「Dashホーム」から「terminal」とタイプして「端末」を起動。
まずはapt-getのリストを更新して、それから日本語入力をインストールする。

```sh
$ sudo apt-get update
$ sudo apt-get install ibus-mozc
$ sudo reboot
```

コマンド1発入れて再び再起動したら、左上の「Dashホーム」から「input」とタイプして「キーボード・インプット・メソッド」を起動。
2つ目の「インプットメソッド」タブで「使用するインプットメソッドをカスタマイズ」にチェックし、「インプットメソッドの選択」から「日本語」→「Mozc」と選択し、「追加」。「Anthy」は選んで削除。

![](./images/20121230190859.jpeg)

この状態にする。このあとに1つ目のタブで、英字・かな入力変換キーを自分の好みに変えておく。私はMacの変換と被るのを避けるため「Shift+Space」にしている。

## 5.VMware tools インストール前準備

カーネルを確認してインストール作業を行う。まずは確認。

```sh
$ uname -a
Linux (コンピュータ名) 3.2.0-31-generic #50-Ubuntu SMP (日付時刻) x86_64 x86_64 x86_64 GNU/Linux
```

ここでコンピュータ名の数字+英字の部分を確認する。ここでは「3.2.0-31-generic」なので、以下のようにインストール。

```sh
$ sudo apt-get install linux-headers-3.2.0-31-generic
```

ここで私の場合、古いヘッダー(3.2.0-29-generic)が無用なので削除しろとか言われたがスルーキメた。

## 6.VMware tools インストール

Macのメニューバーから「仮想マシン」→「VMware toolsのインストール」を選択すると、VMwaretoolsの仮想イメージがマウントされるので、これを解凍してデスクトップにでもドラッグする。

![](./images/20121230190925.jpeg)

次にターミナルから以下を入力。エンターキーを叩くだけの簡単なお仕事です。「デスクトップ」は全角カタカナなのでコマンド入力中に変換すること。

```sh
$ cd /home/(ユーザー名)/デスクトップ/vmware-tools-distrib
$ sudo ./vmware-install.pl -d
(無心でエンターキー連打)
```

Enjoy. の一文が出たらインストール終了。

## 7.必要な周辺ソフトをインストール

```sh
$ sudo apt-get install cmake cmake-curses-gui mplayer libcv-dev libhighgui-dev libcvaux-dev libgtkmm-2.4-dev libcairomm-1.0-dev libboost-dev
```

OpenCVとかmplayerとかcmakeとかccmakeとかそのまわりをさらっと入れる。

## 8.VXLをインストール

[ここ](http://sourceforge.net/projects/vxl/files/vxl/1.17/vxl-1.17.0.tar.gz) からダウンロードする。落としたtarボールは解凍してフォルダをホームフォルダ上に移す。ついでにわかりやすいようにフォルダ名を「vxl」にリネームする。

![](./images/20121230191005.jpeg)

こんな感じで。

```sh
$ cd /home/(ユーザー名)/vxl
$ ccmake . ←半角スペースが一つ間に入ってるのに注意
```

を入れると、

![](./images/20121230191056.jpeg)

こんな感じの設定画面が出る。ここで果敢に「c」を押してconfigureすると、

![](./images/20121230191115.jpeg)

ずらーっと設定が射出されてくる。

![](./images/20121230191128.jpeg)

ここでよく見ると、`BUILD_SHARED_LIBS` がOFFになっているので、こいつをONに変えておく。「BUILD_SHARED_LIBS」にカーソルを進めてエンター。

![](./images/20121230191205.jpeg)

で、ONになった。これが終わったら、「c」をもっかい押してconfigure、更に「g」を押してmakefileを生成し、ccmakeを出る。

後はmake。

```sh
$ make
$ sudo make install
```

これでVXLまでのインストールが完了する。makeが結構長いので、**make installを忘れないようにね**！

## 8. OpenGazerのインストール前準備

何はともあれ [ここ](http://www.inference.phy.cam.ac.uk/opengazer/opengazer-0.1.2.tar.gz) から落とす。
解凍してまたまたホームフォルダへと移動。

![](./images/20121230191243.jpeg)

D&Dで移動。名前変更はお好みで。

OpenGazerのソースが一部古くなっている部分があるので、手直し＆VXLの場所に合わせて事前にソースの修正を行う。
以下「opengazer-0.1.2」内のファイル。

### Makefile

#### 3行目

```diff
-VXLDIR= /opt
+VXLDIR= /home/(ユーザー名)/vxl
```

#### 9行目

```diff
-INCLUDES = $(foreach prefix,/usr/local/include $(VXLDIR)/include $(VXLDIR)/include/vxl, \
+INCLUDES = $(foreach prefix,/usr/local/include $(VXLDIR), \
```

なんかこのへん超怪しい気がする。libまわりに書き換えるんじゃないかなーとか。

### PointTracker.h

#### 11行目

```diff
-class TrackingException: public exception {};
+class TrackingException: public std::exception {};
```

以上３点の修正が終了したら改めて `make` する。警告ビービー出されるが華麗にスルーする。

```sh
$ make
```

これでOpenGazerを使える状態に~~なった。~~ならない。エラー１個吐かれたので原因調査中。

## 9.PATHを通して、追加設定を少々

UbuntuでOpenGazerを使えるように、.profileにパスを数本通しておく。

```sh
gedit ~/.profile
```

出てきたファイルを適当に改行して、以下の2文を追加する。

```
export VXLDIR=/home/(ユーザー名)/vxl:$VXLDIR
export LD_LIBRARY_PATH=$VXLDIR/lib:$LD_LIBRARY_PATH
```

最後に、端末を開いて以下を設定。

```sh
$ sudo addgroup $USER video
```

ここまで終わったら再度再起動する。

```sh
$ sudo reboot
```

## 10.macのカメラをUbuntuに接続

再起動後、VMwareFusionのUSB関連項目から、MacのiSightカメラをUbuntuに接続する。
カメラ単体で使えるかどうか確認する。以下のコマンドを入力するとmplayerに自分の顔が映るので確認可能。

```sh
$ sudo mplayer tv://0
```

## 11.Opengazerを起動

```sh
$ /home/(ユーザー名)/opengazer-0.1.2/opengazer
```

動けば完了。お疲れ様！

## 参考サイト
- [How to build Opengazer(on Ubuntu 10.04) - 僕の部屋の真ん中らへん](http://d.hatena.ne.jp/kazekyo/20100505/1273062727)

内容的には後半はほとんどこの記事のコピペに近い内容だったりします。
前半部分のUbuntuのセットアップをちょこちょこと書き添えた感じ。
