---
title: 2011-36 / 最終着地点 / 認証部実装
slug: 2011-36
author: Ryoma Kai
date: 2011-08-31
banner: ./images/20120126210525.jpeg
excerpt: 
before_title: 最終着地点 / 認証部実装
tags: ["javascript", "twitter"]
---

この一か月間、どんな構成が良いか吟味検討しつつ、以下の選択肢を挙げていました。

- javascript+ExtJS4+ChromeApp
- javascript+ExtJS4+Titanium
- javascript+ExtJS3+ADOBE AIR
- java+swing
- java+GWT+GoogleAppEngine
- java+GWT+ExtGWT+GoogleAppEngine

安定性のあるサーバを用意する資金が無いので、最初からwebアプリorローカルアプリに路線を絞りました。

AIRは、ExtJS4と相性が悪く、3でも少々難アリな雰囲気だったので没。

swingはUIが気に入らなかったのと、将来的にブラウザで扱える環境に持ち込み辛いだろう、という判断でNG。

GAEは手の空いた時にモックアップ的なものを制作しましたが、UIが貧弱でExtGWTもかなり難しい、更にGAE値上げという色々な情報も相まって断念。

ChromeAppは最初期の候補かつ最後まで残った精鋭だったのですが、画面遷移を極端に減らしつつ情報を読込みたい、という仕様から、より自由度の高いTitaniumの路線に落ち着きました。

最初の段階から躓き気味だけど、ペース上げて頑張ろう。

----

![](./images/20120126210525.jpeg)

一応認証部分だけ完成。
コンシューマキーとシークレット等を渡して戻ってきたトークンを格納している。
後はこれ使ってツイートを取得すれば見えるものにはなるなー。
