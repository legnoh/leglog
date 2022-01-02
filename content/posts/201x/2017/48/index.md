---
title: 2017-48 / Meetup, Concourse立ててる話
slug: 2017-48
author: Ryoma Kai
date: 2017-11-26
banner: ./images/23594290_488538458196107_434434803824066560_n.jpeg
excerpt: Concourse Meetupでの発表報告, 引越計画をまた始めた話など
before_title: 2017-48
tags: ["週報"]
---

done
----

###  Concourse Meetup で話した

- [Concourse CI/CD Meetup Tokyo #7 ! (Jp talk accepted too) | Meetup](https://www.meetup.com/ja-JP/Concourse-CI-Tokyo-Meetup/events/244165635/)
- [PIpeline template for CloudFoundry - Speaker Deck](https://speakerdeck.com/legnoh/pipeline-template-for-cloudfoundry)

というわけでお疲れ様でした。技術的な内容というよりは、どんな課題を見つけてどう対処してきたか、みたいなケーススタディに近い感じだったように思う。

もっと技術的にとんがったこと話せると良いのだけど、なかなか自前で好き勝手できる環境を手元に用意できてなくてそれができないのが辛いところ。

###  Concourse立ててる

- [concourse-bosh-deployment/lite at master · concourse/concourse-bosh-deployment](https://github.com/concourse/concourse-bosh-deployment/tree/master/lite)

と言い続けるのも逃げ腰感あるので、そろそろ自分用のConcourseが欲しいなぁと思い、時間もできたのでGCPでConcourse立ててきた。

GCPを選んだのは、色々な人と話してるとAWS/Azure等の他のクラウドと比べて、後発のGCPの方が値段が安いし動作も早いよー、的なことをよく聞いていたのが大きい。

ただぶっちゃけまだ失敗していて、VMは立つんだけどその後 `https://<IP>:6868` に生存確認飛ばしているところで（ログ取り損ねた）、timeoutを吐いてしまい、まだすぐに使える状態にはできていない。多分なんかドキュメントの読み落としがあると思うんだけど、土日では解決しそうになかったので一旦来週の自分に投げた。多分mbus_passwordの設定が適当じゃダメなのか、FWルールのどっちかで引っかかっていると思う。

issue
----

### 引越計画中(4回目)

homesとかsuumo見ても全然決まらなかったのに、athome見たら数分で好みの物件が立て続けにゴロゴロ出てくるからやっぱathomeすげーなって思ってる今日この頃。

というところまでは来たが、逆に「今引っ越していいのだろうか...」「また気に入らない場所が出てきて引っ越そうと思うんじゃ」「そもそも家賃もうちょい出せるようになったしもっと近くでもいいんじゃ」とか色々整理がつかずに迷走してる。引越魔すぎて引越ブルーである。細かい性格だなーおい。

とりあえず現時点で大枠で決まったこととしては以下で、あともう少し細かい部分を整備できたらより具体的に動いていこうと思う。

- 2025年までは家は買わない。
- 通勤時間は歩行時間を含めて片道50分以内にする。
- 家計のバランスシートを正常な状態にする（奨学金を一括返済可能な状態を常に保つ）。
- 30代のライフイベント全般に備えて、20＊＊年までに＊＊＊＊万円を作る。

来年の事を言えば鬼が笑う、とはよく言うものの、自分で制御できる範囲の金の話はなるべく予測可能な範囲を超えないようにしたいので、メリハリをつけた計画を練っていきたい。

todo
----

- 〇〇に行く(多分来週の週報ネタになります)

bookmark
----

この数週間はほぼZOZOSUITに会話ネタすべて持ってかれるくらいの勢いでしたね。もちろん注文しました。

- [ZOZOSUITについて - ZOZOTOWN](https://zozo.jp/_help/default.html?cid=44)
- [「ZOZOSUIT」への悔しさと感謝と、私たちはここからどう戦っていくべきなのかということ。｜最所あさみ｜note](https://note.com/qzqrnl/n/n6d7a1acd0927)
- [ZOZO｜ゾゾの通販 - ZOZOTOWN](https://zozo.jp/brand/zozo/)
- [お題「Amazon、Line、Googleに対抗するため 新しい音声アシストAIがでました。どんなものですか？」坪倉輝明](https://www.slideshare.net/teruakitsubokura/amazonlinegoogle-ai)
- [｢HomePod｣、発売が来年初旬に延期へ。Apple待望のスマートスピーカー | ギズモード・ジャパン](https://www.gizmodo.jp/2017/11/107392.html)
- [天才画家なんですがロブスターの群れに襲われて困っています｜ｍ｜note](http://b.hatena.ne.jp/entry/349713922/comment/Ryo_K)
- [ここは今から倫理です。 1／雨瀬 シオリ | 集英社コミック公式 S-MANGA](https://www.s-manga.net/items/contents.html?isbn=978-4-08-890791-8#&gid=null&pid=1)
- [「好きを仕事に」という欺瞞に騙されず、心の底から気持ちよく好きなことをやる方法 - 分裂勘違い君劇場 by ふろむだ](https://www.furomuda.com/entry/20171114/p1)

tweet
----

先週は姉貴の結婚式で実家に帰っておりました。

<Tweet tweetLink="https://twitter.com/legnoh/status/931844951100473345" />

<Instagram instagramId="BbmBQgTABQz" />
