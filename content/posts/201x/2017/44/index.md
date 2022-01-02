---
title: 2017-44 / AppleTV, Caskroomなどの話など色々
slug: 2017-44
author: Ryoma Kai
date: 2017-10-29
banner: ./images/20171029213545.jpeg
excerpt: ゲーム, AppleTV, Elgato Eve, Caskroom の話。雑多に。
before_title: 2017-44
tags: ["週報"]
---

実に半年ぶりくらいの週報です。週報の定義が乱れる。

done
----

###  ゲームばっかりしていた話

ぶっちゃけこの半年くらいそんな印象。こいつのゲームの話しかしてねぇな。
ただ比率はかなり変わってきてて、

- PSO2: また過疎ってきた
    - Hrのレベル上げが終わってバスクエも過疎ってたから自然とそうなった
- wlw: ほぼ行かなくなった
    - AiME持たなくなったので自然と行かなくなった
- FGO
    - なぜか大量の☆5を引き育成が追いつかずやめられない
- 7月: PSVR購入
    - だいたいサマーレッスンしかしてない
- 9月: Switch購入
    - だいたいスプラトゥーンしかしてない
        - ローラー楽しい！☞ホクサイ楽しい！☞スクイックリン楽しい！☞黒ザップ楽しい！ ←今ここ
        - とりあえずはランク30目標に地味にランク上げ中。そろそろ行けるので本腰入れてガチバトルいく
    - [エスコンVR](https://www.jp.playstation.com/blog/detail/5323/20170720-ac7.html)はよ
- 10月: 駅メモ開始
    - だいたいホーム駅しか取ってない
    - ようやく気合い入れて東京23区西部から埼玉近郊までを一通り取った。現在8路線コンプ。

###  AppleTV

![](./images/20171029213545.jpeg)

ようやく4K対応のバージョンアップが来たのでお迎え。今のところ毎朝の音楽再生に使われている。あとはNetFlixやdアニメストアの再生とか、ストリーミング再生にもそこそこ働いてくれている。

とは言え、こいつの真価はあくまでHomekitだと思ってるので、早くHomePod来てくれーって感じ。

###  Elgato eveに手を出した

そしてHomekit対応家電の第一弾として、温度計を室外用・室内用に1つずつ買った。

室外用としてはEve Weatherを調達し、軒下にぶら下げている。目立たない白い色なので、マンションのバルコニーにさりげなく置くことができる。

- [Amazon.co.jp： Eve Weather ※ワイヤレス アウトドア センサー / Apple HomeKit対応 【日本正規代理店品】: 家電・カメラ](https://www.amazon.co.jp/dp/B0016663EY)

室内用としては、表示機能もあるEve degreeを調達。室内の温度はすぐわかるようにしてある。

- [Amazon.co.jp： Eve degree ※温度&湿度 モニター / Apple HomeKit 対応 【日本正規代理店品】: 家電・カメラ](https://www.amazon.co.jp/dp/B073S5KL37)

Homekit対応なので、Siriにも対応しているのでボイスコマンドが色々使える。自分はよく朝着替えながら「Hey Siri, バルコニーの温度を教えて」って言って、外気温を教えてもらっている。

![](./images/20171029215734.jpeg)

とは言え、これだけでは終わらせる気は毛頭ないので、IR Kitも購入したので、homebridgeを使った独自オートメーションもそろそろ進めようかなーと思ってる。

エアコンの自動制御が第二弾になりそうだが、そこから先は何をやろうかなぁと言う感じ。

###  CaskroomにPRを出し始めた話

自分のdotfilesをより最適化するにあたって、ないものがあるならやっぱPR出すべきだよなぁと思い、最近はちょくちょく必要なものをPullRequestで追加してもらうようになった。

- [Add nttcom-smart-card-reader-driver 1.1.1 by legnoh · Pull Request #156 · caskroom/homebrew-drivers](https://github.com/caskroom/homebrew-drivers/pull/156)
- [Add eid-jp 3.0 by legnoh · Pull Request #33 · caskroom/homebrew-eid](https://github.com/caskroom/homebrew-eid/pull/33)
- [Add eid-jp-myna 1.0.2 by legnoh · Pull Request #34 · caskroom/homebrew-eid](https://github.com/caskroom/homebrew-eid/pull/34)

まぁまだ一発通過するPRは難しいなぁと感じているけど、十数行のruby1枚でも貢献になるので、CaskroomへのPRはOSSの中でもすごくやりやすいものだろうなーという気はしている。

コミュニティの中でissueの議論に加わるくらいの知見とか将来は持てると良いなーとは思いつつ、中々普段の内情が見えないものも多いので、どういう話をしているのかちゃんと追えるようにするところからかなぁ。

issue
----

###  ネットが重い

最後まで悩まされたこの問題だが、いよいよもって「どうにもならない」と結論が出たので、来年を目処に引越そうと思う。またかよ。

しかし前2回の引越はある程度自責でやったものだからいいんだけど、今回ばかりは流石に運が悪かったなぁと感じる。正直場所はここで良いので、フレッツさえ引かせてくれれば後10年くらい住んでも全然良いんだけどなぁ...。辛い。

###  次の目標的なもの

ここ4年くらい掲げていたキャリア上の目標を、この10月でめでたく達成することになり、さぁ次はどうしよう、とひとしきり悩んでる。

現状では、チームの内情などを鑑みながらプロダクトオーナーに近い立ち位置で、チーム全体にロードマップやアイディアを配れるようになることを目標にしているものの、やってみて相当大変ではあるが、数年もかかるほどの目標ではないよなぁと感じていて、5年後、10年後にそれをずっとやっていたいかと言われると、それはちょっと違うかなぁと。

もともとエンジニアを後5年もやっていられるかどうかは怪しいと思っているのだけど、だからと言って今のキャリアをすぐ投げ捨てるほど愚かにもなれないし、自分がそうしたいか、と言われるとやっぱり違うなと。

と言うわけで絶賛お悩み中。自分の中では2025年（プレ・シンギュラリティ、2025年問題）が一つのターニングポイントだと思っていて、ここに対して行動していくのが一番肝要だと思うので、少なくともそこまでの未来は見据えて行動を積み重ねる戦略にしたいと思う。

todo
----

- homekitに関しての勉強
- 次に住む物件の条件選定
- スーツを買う

bookmark
----

流石に半年分となるとめちゃめちゃ数が多いですが、はてブは人生の肥やしになってるものが多くてほんと見てて良いなーと思います。


- [オタク婚活なら結婚相談所「とら婚」](https://toracon.jp/)
- [Cloud Foundry Developer Certification | Cloud Foundry](https://www.cloudfoundry.org/certification/)
- [cloudfoundry-incubator/cflocal: Stage and launch CF apps, push and pull droplets, and connect to real CF services -- in Docker](https://github.com/cloudfoundry-incubator/cflocal)
- [​【レポート】『Fate/Grand Order』事例から学ぶインフラ運用設計…海外展開のために必要な要項についても詳しく紹介 | Social Game Info](https://gamebiz.jp/?p=188024)
- [August Doorbell Cam Pro | Home, even when you're not.](https://august.com/products/august-doorbell-cam-pro)
- [DNAに書き込まれた悪意あるコードがそれを読み込んだコンピューターに感染した | TechCrunch Japan](https://jp.techcrunch.com/2017/08/12/20170809malicious-code-written-into-dna-infects-the-computer-that-reads-it/)
- [GoogleのQUICの論文が知見の塊だった - ASnoKaze blog](https://asnokaze.hatenablog.com/entry/2017/08/13/022447)
- [はてなhttps問題で「はてな？」となっているあなたへ | 羽田空港サーバー](https://www.haneda-airport-server.com/entry/hatena-https)
- [幻滅期に向かうAIとRPA、ガートナーが予測 | 日経クロステック（xTECH）](https://xtech.nikkei.com/it/atcl/column/14/346926/100501152/)
- [ぽっちゃりタレントが続々と痩せ始めた理由 | テレビ | 東洋経済オンライン | 経済ニュースの新基準](https://toyokeizai.net/articles/-/191782)
- [「バカか、てめえ」新国立建設で自殺　過酷労働の内情 - 東京オリンピック：朝日新聞デジタル](https://www.asahi.com/articles/ASKB26Q4LKB2ULFA04P.html)
- [「投票しろ！だけ言うのは無責任」26歳が作った“頑張らない”選挙情報サイト](https://www.buzzfeed.com/jp/harunayamazaki/japan-choice)
- [焦点：世界初、ＡＩで日銀総裁の表情解析　政策予想に応用も - ロイター](https://jp.reuters.com/article/ai-facial-expression-kuroda-idJPKBN1CP0GH)
- [立憲民主党の街頭演説が「SNS映え」する理由　自民党と比べたらわかる秘策が](https://www.buzzfeed.com/jp/saoriibuki/cdp-ldp-gaisen)
- [選択肢を理解する――経産省、若手・次官プロジェクト資料について « SOUL for SALE](http://blog.szk.cc/2017/05/22/to-understand-our-choices/)
- [ベーシックインカムとして国民2000人に毎月7万円を与えたフィンランドではストレスや仕事のモチベーションはどうなったのか？ - GIGAZINE](https://gigazine.net/news/20170622-basic-income-in-finland/)
- [１日５人が餓死で亡くなるこの国](https://ironna.jp/article/976)
- [Pivotal Container Service(PKS)とその関連技術のはなし - Cloud Penguins](http://jaco.udcp.info/entry/pivotal-container-service-kubernetes)
- [Xperiaハウス誕生へ。ソニモバ・東電がホームIoT「TEPCOスマートホーム」提供開始 - Engadget 日本版](https://japanese.engadget.com/2017/08/07/xperia-iot-tepco/)
- [Googleが社内のドキュメンテーションスタイルガイドを公開 | TechCrunch Japan](https://jp.techcrunch.com/2017/09/08/20170907google-publishes-its-documentation-style-guide-for-developers/)
- [DockerもついにKubernetesをネイティブでサポート、Swarmの併用も可能 | TechCrunch Japan](https://jp.techcrunch.com/2017/10/19/20171017docker-gives-into-invevitable-and-offers-native-kubernetes-support/)
- [やはりHTML/DOMは再発明されるべきじゃないか - mizchi's blog](https://mizchi.hatenablog.com/entry/2017/10/02/074916)
- [【特集】ケーブル選びに失敗しないための「USB Type-C」基礎知識 - PC Watch](https://pc.watch.impress.co.jp/docs/topic/feature/1075458.html)
- [富裕層が人生を"積分"「もう蓄財やめた」 実質「20歳で人生半分終了」に戦慄 | PRESIDENT Online（プレジデントオンライン）](https://president.jp/articles/-/22136)
- [推しの声優のラジオを録音して聞く環境を整えた - razokulover publog](https://razokulover.hateblo.jp/entry/2017/10/12/192951)
- [CDN切り替え作業における、Web版メルカリの個人情報流出の原因につきまして - Mercari Engineering Blog](https://tech.mercari.com/entry/2017/06/22/204500)
- [エンジニアは業務時間外に勉強すべきかの話 - terurouメモ](http://terurou.hateblo.jp/entry/2017/08/06/154501)
- [子供を欲しがる友人に共感できない深刻理由 | 今週のHONZ | 東洋経済オンライン | 経済ニュースの新基準](https://toyokeizai.net/articles/-/191138)
- [「AlphaGo」という“神”の引退と、人類最強の19歳が見せた涙の意味：現地レポート｜WIRED.jp](https://wired.jp/2017/05/28/future-of-go-summit-day5/)
[インターネットは当初目指したものではなくなってしまった:Geekなぺーじ](http://www.geekpage.jp/blog/?id=2017-9-12-1)
- [隆盛「eスポーツ」に法の壁 賞金たった10万円: 日本経済新聞](http://www.nikkei.com/article/DGXMZO18789710S7A710C1000000/)
- [普通の人がお金のことについて勉強しておくべきこと - ゆとりずむ](https://www.yutorism.jp/entry/MoneyLiteracy)
- [「サラリーマンブロガー」こそ攻守最強　（ヨッピーの本が出ました） - ヨッピーのブログ](https://yoppymodel.hatenablog.com/entry/2017/09/20/113332)
- [皆さんに本当に必要なのはライフハックではなく筋肉](https://anond.hatelabo.jp/20110304092556)
- [アイドルやめたらAVのオファーとかきた話。](https://anond.hatelabo.jp/20171022113705)
- [Google Cloud Platform Japan 公式ブログ: Google の新しい専門職 : CRE が必要な理由](https://cloudplatform-jp.googleblog.com/2016/10/google-cre.html)
- [研究者として生きていくコツ](https://gist.github.com/kaityo256/f56c4998f88eefd82ac5e07d16eda9d3)
- [優秀なプログラマーになるためのコツ](https://gist.github.com/shyouhei/266178ffedab5767a5b69b972c76f88a)
- [gdamdam/awesome-decentralized-web: an awesome list of decentralized services and technologies](https://github.com/gdamdam/awesome-decentralized-web)
- [Node.jsのコミッターを迎え - linotice＊ | Yahoo! - Tumblr](https://linotice.tumblr.com/post/166348035844/20171013)
- [米国ではなく日本で生活する - Atsuya Takagi - Medium](https://medium.com/@atsuya/8f78c76b2719)
- [「10万人の宮崎勤」はあったのか？(dragoner) - 個人 - Yahoo!ニュース](https://news.yahoo.co.jp/byline/dragoner/20170929-00075748/)
- [現代におけるプロダクト開発とPHPを選定するワケ #phpkansai - Speaker Deck](https://speakerdeck.com/potato4d/xian-dai-niokerupurodakutokai-fa-tophpwoxuan-ding-suruwake-number-phpkansai)
- [仕事して寝るだけの「趣味を持たない人」と過ごして分かった、「物事を楽しむ」ことを無価値だと思っている人の存在 - Togetter](https://togetter.com/li/1110198)
- [最近の大学生がインタビューの文字起こしをするのに「iPhone」と「iPad」の２台だけを使っている理由 - Togetter](https://togetter.com/li/1158214)
- [サイバー攻撃が新次元に　ウクライナ危機の全貌　　:日本経済新聞](https://www.nikkei.com/article/DGXKZO22133970R11C17A0X11000/)
- [TEDで必ず見ておきたい「お金に関する名動画」8選 | ZUU online](https://zuuonline.com/archives/167876)

tweet
----

GTDソフトも見直ししてるんですが、やっぱりOmniFocusから離れられそうにないです。Thingsも頑張れー。

<Tweet tweetLink="https://twitter.com/legnoh/status/924329036100222978" />
