---
title: 2020-20 / ブログ再構築
slug: 2020-20
author: Ryoma Kai
date: 2020-05-17
hero: ./images/leglog-logo.jpg
excerpt: ブログを Gatsby, Netlify, GitHub Actions, GitPod で再構築した話
tags: ["週報"]
blog_url: https://leglog.lkj.io/2020-20
---

随分と久々に書きます。久々に新しい記事を書くのでまずはこのブログのことから。

## ブログについて

過去ログを見ると、ブログを書き始めてからもう10年ほどになるのだが、引越し魔よろしく様々なプラットフォームに乗り換えてきた。

- エムペ!(高校時代の~~黒歴史~~私的なもので削除済)
- FC2ブログ
- はてなダイアリー
- Wordpress
- Note
- はてなブログ
- Notion
- はてなブログ(出戻り)

これまで媒体を変えてきたのは様々な原因があったのだが、主に課題として感じていたのは以下のことだった。

### 課題1: 情報としての粒度がバラバラ

ブログはその名の通り「ログ」なので、フローに当たる情報になる。元々ブログ自体、私の思想やその時どう考えたか？を書きたかったので、これ自体は問題ない。
ただ、ある程度一定期間流れない情報、つまりストックとなる情報を選別し、特に長期間変わらないであろう"原則"のようなものや、そういった質の良い情報を置く場所が欲しかった。

それを考えると、現行のブログ1本体制はやや厳しいものがあると感じ、フローとストックをそれぞれ貯められるサイトを作りたいと感じるようになった。

#### どうしたか？

当初は、フローとストックのページ階層を分けて分別するだけにしようと考えていたが、うまくハマる方法がなかったのでサイト構成を分けることにした。
これを2サイト構成に整理することを考えて、既存のブログサイトに加え、wikiサイトを別に作ることにした。
今回はGWで時間もあったので、それぞれのサイトロゴも手作りした。イメージをなるべく揃えるためにデザインはかなり近いものにした。
ダークモードなどにも対応できるよう、かなりシンプルなロゴになっている。

![leglog-logo](./images/leglog-logo.jpg) ![legwiki-logo](./images/legwiki-logo.jpg)

また、ロゴのアイコン部分はFont Awesomeをそのまま使っている。[CC BY 4.0](https://fontawesome.com/license/free)で使えてSVGで配布されていて汎用性が高く、個人サイト用としては十分と感じたので採用。

- [Bicycle Icon | Font Awesome](https://fontawesome.com/icons/bicycle?style=solid)
- [Compass Icon | Font Awesome](https://fontawesome.com/icons/compass?style=solid)

### 課題2: 書きにくい、汎用性がない

各ブログサービスのエディタはそれぞれ個性があるが、前使っていたはてなブログが一番厳しかったのは、長文の対応があまりよくなかった点だった。Markdownで長文を書くと、どうしてもプレビューが遅くなり、場合によってはプレビューが常時失敗するような挙動をされることがあった。私の場合、ブログでそこそこ長い文を書くのでこれが致命的で、一度公開をしないと長文がストレスなく書ける状態にはならなかった。

#### どうしたか?

まずははてなブログを止めることを前提に考えた。他のブログサービスがそんなに書きやすいか？となったので、次の課題の中でまとめて手法を整理することにした。

### 課題3: 保管方法

各社によって提供されているブログサービスは機能がまちまちだが、そのどれもが「サービス終了」という壁がある。例えば「Yahoo!ブログ」は前年サービス終了となったが、この際に移行ツールが提供され、一定期間後にデータを廃棄することが明記されている。

- [Yahoo!ブログ サービス終了のお知らせ](https://promo-blog.yahoo.co.jp/close/index.html)

折に触れてよく話すことではあるが、私は自分が必要以上に長く生きることについて否定的な思想である。そのため、いくら医療が進歩しようが不老不死になるなんてごめんだし、それは次に生まれてくる生命の居場所を奪うことにもなる。とはいえ、自分という存在がいたことはどうにかして形に残したい。つまり自分という存在がいたことは、数十メガバイトの文書ファイルになって残っていれば、私はそれだけで、それだけで良いのだ。

> 人は、いつ死ぬと思う・・・？
> ・・・人に、忘れられた時さ・・・！！！
- 出典：ONE PIECE／尾田栄一郎　集英社

とはいえどこかのサービスを使い続ける限り、自分がもし交通事故でなくなったら、自分の生きた痕跡は数十年後にこの地球上から抹消されるだろう。現在の日本の役所では、戸籍の保管期限は150年とされており、それ以降になってしまうと日本の戸籍上から名前が抹消されてしまう。絶対に、というのは難しいが、少なくとも数千年程度はこの地球に爪痕を残しておきたいと思うようになった。

#### どうするか?

現時点で、一般人が使える一番信頼できるアーカイブ方法を利用すべく、GitHub Archive Program を利用して管理することを考えた。これは、米マイクロソフト傘下であるGitHub社が提供しているもので、ソースコードを複数の媒体を使って超長期間保管してくれるもので、最長の期限であるProject Silicaに至っては、10,000年間保管ができるようになっている。

- [GitHub Archive Program | The GitHub Archive Program will safely story every public GitHub repo for 1,000 years in the Arctic World Archive in Svalbard, Norway.](https://archiveprogram.github.com/)

もちろん、1万年間保管できる保証などどこにもないし、戦争が起き、過去の遺産を理解しない為政者によって、我々のコードも何もかもが破壊されることはあるかもしれないし、保管媒体が性能を発揮できず、せいぜい数百年で壊れてしまうかもしれない。1万年前と言えば私たちからすれば新石器時代であり、そんな時代の文章など今の私たちの役には立たないだろうとも思う。

ただ、もし1万年後。未来の誰かやロボットが私の書いた文章を見つけ「こんな人がいたのか」と思いを馳せるかもしれない、これ以上の"浪漫"がどこにあるだろう！ 私はこの浪漫にこそ自分のソースコードと文章を預けたいと考える。

## bookmark

- [links here]()


- [Bookmark Log - Hatena Bookmark](https://b.hatena.ne.jp/Ryo_K/bookmark)

## activity

<Tweet tweetLink="" align="center" />
<Instagram instagramId="" />
`youtube: `

- [Tweet Log - Twitter](https://twitter.com/search?q=(from%3Alegnoh)%20until%3A2020-05-17%20since%3A2020-05-11%20-filter%3Areplies&src=typed_query)
- [Commit Log - GitHub](https://github.com/legnoh?tab=overview&from=2020-05-11&to=2020-05-17)
- [Training Log - Strava](https://www.strava.com/athletes/47349424/training/log)

----

- [View with GitHub](https://github.com/legnoh/leglog/blob/master/content/posts/202x/2020/20/index.md)