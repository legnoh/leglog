---
title: 2012-09 / Ust + Livetube + ニコ生 で天鳳の画面を 3面配信した時のまとめ
slug: 2012-09
author: Ryoma Kai
date: 2012-03-02
hero: ./images/no-hero.png
excerpt: 
before_title: Ust+Livetube+ニコ生で天鳳の画面を3面配信した時のまとめ
tags: []
---

## PCスペック

- Windows7 Professional(64bit)
- 6GB RAM
- Intel Core i7 860(2.80GHz)
- 下り帯域50Mbps / 上り帯域 5Mbps
- いずれも音声ソースにCreative SB X-Fi 内蔵の再生リダイレクト(ステミキ)使用

## Ustream

- FlashMediaLiveEncorder 3.2
- SCFH DSF 4.01
- 映像288kbps+音声96kbps=384kbps
- 29.97fps
- 1024×768(原寸)

## Livetube.cc

- SCFH DSF 4.0
- 映像+音声=400kbps
- 15fps
- 640×480

## ニコニコ生放送

- NiconicoLiveEncorder 1.1.1
- 映像128kbps+音声48kbps=176kbps
- 16~20fps？(映像ソースが確認できない為正確には不明)
- 512×384

UstreamとLivetube.ccに使われているSCFH DSFはソフト間の干渉を防ぐため別のバージョンを使いました。同様に、ニコ生でも最初はFlashMediaEncorder2.5+NiconamaVisualStationを使用する予定でしたが、これが正常に作動しなかったため、ニコ生ライブエンコーダーに切り替えたという経緯があります。

上記の設定で、全ての配信で正常に見えることを確認しました。
ただ、ニコ生ではPC音声にダブりが出ていたため、原因調査中です。
