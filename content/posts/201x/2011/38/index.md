---
title: 2011-38 / Web表示機能追加 / twitter の URL の取り扱い方(自分用まとめ)
slug: 2011-38
author: Ryoma Kai
date: 2011-09-12
hero: ./images/20120126210527.jpeg
excerpt: 
before_title: Web表示機能追加
tags: ["twitter"]
---

![](./images/20120126210527.jpeg)

IFRAME でライトな web ブラウザ的な使い方ができるようにしてみた。
これだけだと付加価値なくて面白く無いので、今後は本文抽出とか、RSSとの連携等の機能を追加して個性をつけていく予定。

これの実装後、Titanium側でIFRAME開くと特定のサイトでTitaniumごと強制終了する例が出てきた。
恐らくサイトのjsと競合しあっていると思うのだけど、現状打つ手が無いのと、発生しているサイトの情報はほぼAPIで情報を拾えるサイトなので、今後の対応で改善できるレベルかと思う。

----

2011年9月16日現在で自分が確認したもの。

- 基本 … TLの取得時にentities情報を付加する
    - ツイートされた場合、全てのURLはツイート上ではt.coで省略されている。これを何らかの方法で展開したい。
- APIを出すときに、`&include_entities=true` をつける
    - これにより、返ってくるJSONデータにentitiesが入り、t.coで省略されたURLを見れるようになる。
- entitiesの中身がややこしい
    - これまた非常にややこしい。
    - 基本的なURLはすべて `entities.urls[0].expanded_url`に入る
        - urlsは複数URLを貼っている分だけ増える
    - `url`, `display_url`, `expanded_url` と３つ枝があるが、 `url` はt.coで省略されたもの、 `dispay_url` は表示用に `…` で丸められたもの、 `expanded_url` は展開されたURLが入っている。
    - ただし、bit.ly等の短縮サービスを利用したURLの場合、 `expanded_url` に入っているのはbit.lyで短縮されたもののままである。
    - これを更に展開するには短縮元を調べる必要があり、若干表示部のタイムロスが出そうで微妙な所である。
    - 単純な生のURLに置き換える場合、 `expanded_url` を参照してtextに正規表現で置き換えれば良い。
- hootsuiteで呟かれたURLは省略されたURLが `entities.urls[0].url` に入る
    - hootsuite経由でツイートされたURLは `expanded_url` がnullになり、urlにow.lyで短縮されたもののみ入っている。`display_url` の枝もない。
    - これも展開する場合、展開先の確認が必要だろう。
- twitterの公式写真アップロードのURLは `entities.urls[0].media[0]` に入る
    - twitterの公式写真アップロードで投稿されたURLは、 `urls` には何も入っておらず、 `entities.media[0]` に入っている。
    - この中身は画像、サムネ、ページのURL等々色々と入っているので、どんなことやるにしても困ることはないだろう。
    - ただし、mediaの枝はこの時しか無いので、単純にnullで分岐しようとするとundefinedを返されるので注意。
