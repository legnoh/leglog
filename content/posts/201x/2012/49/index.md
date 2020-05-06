---
title: 2012-49 / Automator で Mail.app起動が便利すぎて禿げた
slug: 2012-49
author: Ryoma Kai
date: 2012-12-05
hero: ./images/20121230194836.jpeg
excerpt: 
before_title: AutomatorでMail.app起動が便利すぎて禿げた
tags: []
---

最近メインのメールアドレスをgmail.comからiCloud.comへと乗り換えた。

gmailでは [InboxWhiz](http://jp.techcrunch.com/archives/20121120grexits-inboxwhiz-keeps-you-from-obsessively-checking-your-gmail-by-hiding-it-from-you/)という拡張を使って、一日にメールを読む時間を制限していたのだけど、icloudではその方法がない。

同時にブラウザ上のgmailからMail.appへの乗り換えを行ったため、 Dock に Mail.app が居座るのが気に食わなかった(iOSみたく起動なしでもpushしろやと思うが)。なるべくなら普段は引っ込んでて欲しいので [Dock Dodger](http://www.moongift.jp/2008/09/dock_dodger/)で Dock から排除しようとするも Mail.app が起動しなくなり失敗。。。

そんでどうしたもんかと思った矢先、Automatorの「カレンダーアラーム」を使う方法を思いついた。


1. 起動後、「カレンダーアラーム」を選択してOK
  ![](./images/20121230194756.jpeg)
2. 「アクション」→「ライブラリ」→「メール」の中にある「新規メールを受信」を右へD&D
  ![](./images/20121230194836.jpeg)
3. `Command+S` で名前をつけて保存
  ![](./images/20121230194846.jpeg)
4. 自動でiCal.appが立ち上がり、現時刻に作ったイベントが追加される。イベントの移動は通常のカレンダー項目と同じように扱えるので、繰り返しなんかもそのまま設定できる。
  ![](./images/20121230194855.jpeg)

イベントを複製して何個か置いておけば、指定時刻の度に Mail.app が立ち上がり、新着メールを取りに行ってくれる。終わったら Mail.app を `Command+Q` で閉じればいいので Dock に常駐することもない！まさに一石二鳥。

Automator の存在はちゃんと知ってはいるものの、忍者？というかなんというか、「Automator使うか」という発想が毎回最初に出て来ないのだが、困ったときに頼ると大体のことができてしまうから毎度発見だらけですげー存在だなと思う。

最初にご紹介した InboxWhiz も騙されたと思って使うとかなり便利なのが実感できるので、gmail の人はぜひお試しあれ。

P.S.抜け毛がちょっと気になってます。誰か良いシャンプー教えてください（切実）
