---
title: 2022-01 / 近況報告
slug: 2022-01
author: Ryoma Kai
date: 2022-01-02
# banner: ./images/
excerpt: 
tags: ["週報"]
blog_url: https://leglog.lkj.io/2022-01
---

あけましておめでとうございます。1年以上ブログを書かないまま2021年を終えてしまいました。
久々に近況などをまとめるための記事を書きます。

## done

### 東京撤退

前回から考えていた東京撤退が去年の9月に完了した。候補としては最終的に船橋、柏、千葉、さいたま、立川、川崎、町田、相模大野、藤沢、小田原などに絞ったが、ハザードマップ、東京へのアクセス性能、物件のコスパ、空き物件の現状などを鑑みた結果、以前住んでいた柏に落ち着いた。同じ街に戻るのも芸がないなぁとは思ったのだが、5年前の自分の選択からあまり価値観が変わってないということなのかもしれない。

### デスク環境の変化

エンジニアあるあるなホームオフィス環境の変化の話でも。

#### デスクがデカくなる

<Tweet tweetLink="https://twitter.com/legnoh/status/1395185962276188160" />

部屋が1LDKになったのと端末が増えてきたこともあり、デスクを幅140から幅180のL字デスクに変更した。普段はデスクの上に何も置かないのですごい殺風景になるのだが、好きなように物を広げて作業ができるので、デスクはやはりでかいに越したことはない。
天板を木工業者に頼むパターンも気になってはいたのだが、L字にしたかったためにPLUSの相当でかい机を買った。

- [OXシリーズ エグゼクティブL字型デスク 幅180cm 奥行140cm ( 配線穴4か所付 ) の通販 | デスク | ガラージ 【 Garage 】](https://garage.plus.co.jp/products/detail.php?product_id=166535)

#### ルータ周辺をスッキリ

<Tweet tweetLink="https://twitter.com/legnoh/status/1379406247288446977" />

昔から気になっていた小型ONUを使えばルータ周りめちゃくちゃ綺麗にセッティングできるんじゃね？と思いつき、通信環境の強化も兼ねて以下の構成に乗り換えた。

- プロバイダ: ソフトバンク光 → DTI光(ホームゲートウェイなし)
- ONU: GE-ONU → 小型ONU(GE-PON<FA\>A SFP-ONU<1\>S TA06005-B907)
- ルータ: 光BBユニット → YAMAHA NVR510
- 無線AP: LINKSYS Velop MX5300

正直この構成にただするだけであれば特に難しくはないのだが、プロバイダがソフトバンク光だったこともあり、ONUの乗換え部分で知識不足もあってかなり難しいステップを踏むことになった。具体的にはこう。

1. プロバイダをソフトバンク光から適当なプロバイダ(今回は@Nifty)に事業者変更＋NTT東日本との光回線契約に乗換える
1. NTT東日本宛に小型ONUへの変更依頼を出し、小型ONUへの切替工事を実施する
1. 本命のプロバイダ(今回はDTI光)へ、事業者変更で光コラボ方式で乗り換える
1. 乗換え完了

なんでこんな面倒臭い手順になるのかというと、光コラボ事業者には小型ONUへの切替工事が依頼できないためである（NTTに取り次いでもらえない）。そのため、ソフトバンク光から直接DTI光に乗り換えると、小型ONUの交換ができなくなるというトラップが発生する。そのため、一度光コラボではない適当なプロバイダと契約しつつ、直接NTTに小型ONUの払出しを行なってもらい、その後光コラボで再契約する、という段取りを踏んだ。

このやり方はどこにも載っていない中で自分で思いついて試してみたのだが、結果的にはうまくいき、DTI光に移る時には何も言わなくても「手持ちの」ONUがそのまま使えると言ってもらえた。ホームゲートウェイありならもう少し解法があったとも思うのだが、少しでも月額を抑えたかったので、頑張った甲斐があった。

ps. たくさん情報を頂けたDTI光のカスタマーサポートさん、本当にありがとうございました。

今日はこのくらいで。
流石に書きたいネタのストックがそこそこあるので（笑）、しばらく空いたタイミングで更新していきます。

## bookmark

- [春秋: 日本経済新聞](https://www.nikkei.com/article/DGKKZO78891040R00C22A1MM8000/)
- [留年したくないのでスマブラのリトルマックで卒論を書いた - 玄界灘と限界オタ](https://toiharuka.hatenablog.com/entry/2021/12/25/151429)
- [ヤフーにおける技術獲得の考え方、AI倫理の議論も添えて - Yahoo! JAPAN Tech Blog](https://techblog.yahoo.co.jp/entry/2021121330233790/)
- [部活が変われば日本は変わる｜Dai Tamesue 為末大 （株）Deportare Partners代表｜note](https://note.com/daitamesue/n/n14ad39cb349e)
- [2021年だから人類はHTMLを手打ちしろ](https://youkoseki.com/f/2021_html)


## activity

柏にいると、少し自転車を走らせるだけで森やら沼やらなんでもあります。あゝ一面のクソミドリ。

<Instagram instagramId="CUjwzXgpMg1" />

- [Tweet Log - Twitter](https://twitter.com/search?q=(from%3Alegnoh)%20until%3A2022-01-02%20since%3A2021-12-27%20-filter%3Areplies&src=typed_query)
- [Commit Log - GitHub](https://github.com/legnoh?tab=overview&from=2021-12-27&to=2022-01-02)
- [Training Log - Strava](https://www.strava.com/athletes/47349424/training/log)

----

- [View with GitHub](https://github.com/legnoh/leglog/blob/master/content/posts/202x/2022/01/index.md)
