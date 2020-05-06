---
title: 2018-21 / HomeKitを使ってスマートホームを作り込んだ話
slug: 2018-21
author: Ryoma Kai
date: 2018-05-20
hero: ./images/20180520142812.jpeg
excerpt: 2018年5月時点でのHomeKitでの各デバイスのオススメなどについて書きました。一部古い情報もありますのでご注意ください。
before_title: HomeKitを使ってスマートホームを作り込んだ話
tags: ["HomeKit"]
---

# 免責事項

この記載内容はあくまで個人の判断によって行ったもので、うまくいかなかった場合の責任は追い兼ねます。チャレンジャー精神でトライしましょう。

## 概要

過去半年くらいにわたって、地道に検証と改良を重ねてきたHomeKitのスマートホームづくりがひと段落ついたので、スマートホームを作るにあたって、何を決めていくべきなのか、具体的にどうやって考えて今の構成に至ったのか、どのような障害があったのかをまとめて書いてみようと思います。これから作る人たちの参考になれば幸いです。

## どんな感じ？

実際にどのような内容かについてはこちらをご覧ください。見えているものですべてになります。更にシチュエーションも決められていて、自宅から出たり/帰宅したり、特定の時間が来ると自動的に動くような仕掛けも多数あります。

![](./images/20180520142812.jpeg)
![](./images/20180520142808.jpeg)
![](./images/20180520142816.jpeg)
![](./images/20180520142818.jpeg)

# その1: スマートホームのコアにする技術を考える

スマートホームづくりをするにあたって、一番最初に決めるべき重要なポイントは、**"どのハブをスマートホームの核にするか"**ということです。

日本で比較的手に入りやすい代表格としては以下の4つが選択肢として挙げられるでしょう。

|規格(アシスタント)名|ハブ機器|提供企業|その他関連技術|
|---|---|---|
|[**Apple HomeKit(Siri)**](https://www.apple.com/jp/ios/home/)|AppleTV, iPad, HomePod|Apple|macOS, iOS, AppleMusic, (homebridge)|
|[**Google Assistant**](https://assistant.google.com/intl/ja_jp/)|Google Home|Google|Android, GooglePlayMusic|
|[**Amazon Alexa**](https://www.amazon.co.jp/b?ie=UTF8&node=5364379051)|Amazon Echo|Amazon|Amazon Dash Button, Amazon Prime Music|
|[**LINE Clova**](https://clova.line.me/)|Clova WAVE|LINE| LINE(チャット), LINE Music|

なぜこれを一番最初に決めるのかと言えば、これによって購入すべきスマートホームデバイスや関連技術がガラッと変化するからです。例えば温度計などを発売している[Elgato社](https://www.elgato.com/ja/eve)の場合、HomeKitは連携できますが、他の3つとは連携して利用できませんし、ElgatoはAndroidアプリすらも用意されていません。つまりHomeKit以外をハブにしたい場合は選択肢に入れられないことになります。

他にも、AppleMusicユーザであればHomePodとの絡みから一番選択肢にしやすいですが、GooglePlayMusicのユーザであれば、GoogleHomeをスマートスピーカーとして使いたいでしょうし、GoogleAssistantにするのが自然と言えるでしょう。

このように、自分が何をスマートホーム化したいのか、どれが今の自分の周辺環境に一番噛み合っているのか、それらを考えながらデバイスを選択していきつつ、どの技術を核に据えるのかを考えていくと良いでしょう。

- [Apple TV 4Kを購入 - Apple（日本）](https://www.apple.com/jp/shop/buy-tv/apple-tv-4k)

### なぜHomeKitベースにしたのか？

私がHomeKitを選んだのは、身の回りがほぼAppleデバイスばかりだったこともありますが、それ以上にHomeKitがプロダクトとして一番使いやすそうだな、という印象を受けたのが決め手でした。

他の3社は「スマートスピーカーで操作できる！」というだけで、それを統括してコントロールできる、[homeKitの"ホーム"](https://www.apple.com/jp/ios/home/)のようなダッシュボードアプリが存在しません。

普段の実生活を考えたとき、声だけで細かい処理を実現していくのはかなりハードルが高いと感じたのと、プラットフォームとしてとっちらかってるなーと率直に感じたので、HomeKitが一番自分にはあいそうだ、と感じたのが理由です。


## その2: 対応できる家電について調べる

正式にHomeKit対応ができる家電については、この本家のサイトにまとまっています。このページではこれに従って各ジャンルのデバイスを紹介します。

- [iOS - ホーム対応アクセサリ - Apple（日本）](https://www.apple.com/jp/ios/home/accessories/)

しかし、この中で"日本で導入可能なもの"がどれだけあるかというと、およそ3割にも満たないのが現状です。理由としては後で詳しく書きますが、日本家屋の問題や、HomeKit対応が各社で進めきれていない、認証が取れていないことなどが理由です。

後者については、homebridgeと呼ばれるNode.jsサーバを立てて、HTTP APIがあるものであればそれを叩きに行くか、IRkitなどの赤外線通信ができるデバイスと組み合わせるプラグインを書いて、無理矢理対応させてしまうことも可能です。なるべくなら正規認証を持っている構成にした方がブリッジなどの無駄なものがなくなったりUXが良くなって便利なのですが、これは最後の手段として選択肢に入れておくと良いです。

- [homebridge/homebridge: HomeKit support for the impatient](https://github.com/homebridge/homebridge)
- [OSXにHomebridgeをインストールしてお家をスマートハウスにする - ワタナベ書店](https://senyoltw.hatenablog.jp/entry/2016/02/22/080000)

また、実際にどんな構成を実現できるのか、ダミーのダッシュボードで動作を確認したい！という技術寄りな方であれば、macOSがあればHomeKit accessory simulatorを使って、家電を作って試してみるのも良いです。これをやると、仮にhomebridgeで自前対応しよう！となった時でも比較的開発のイメージがしやすいと思います。

homeKitの正式ドキュメントであるHAPも一度見ておくと尚良いでしょう(これは非コンシューマ版なので、一部存在しないServiceもあることに注意してください)。

- [お金をかけずにHomeKitアプリ開発体験 - Qiita](https://qiita.com/dobnezmi/items/678f14958b07d1be77e9)
- [HomeKit Accessory Protocol Specification (Non-Commercial Version) - Support - Apple Developer](https://developer.apple.com/support/homekit-accessory-protocol/)

ちなみに、自分はhomebridgeサーバとして、Raspberry Piではなく、mac miniを最低スペックで購入しました。理由は色々あるのですが、常時稼働のサーバという側面で考えたとき、脆弱性が発生した際にOSアップデートがやりやすかったり、画面共有で他のMacからUIで操作しやすいという利点があるので、その点だけでもmacの方が比較的に安心できるかなと感じています。見た目も揃えられるしね。価格だけで言えばラズパイ圧勝ですが、もう一つのハブとして数万払うだけの価値はあります。

- [Mac mini - Apple（日本）](https://www.apple.com/jp/mac-mini/)
    - 追記: その後、紆余曲折あってRaspberry pi に乗り換えました。理由は後述。

## 照明

まず初手として、比較的手を出しやすい分野です。ほぼこの分野はPhillips Hueの独走状態になっていると言って差し支えないでしょう。自分はこのスターターキット1つに加えてランプを3個追加し、合計2.4万円ほどで導入できました。

- [Amazon | Philips Hue(ヒュー) | ホワイトグラデーション スターターセット | E26スマートLEDライト2個+ブリッジ1個+ディマースイッチ1個 |【Amazon Echo、Google Home、Apple HomeKit、LINEで音声コントロール】 | フィリップスライティング(Philips Lighting) | ホーム＆キッチン 通販](https://www.amazon.co.jp/dp/B01N8SLVRN)

ランプを少しでも安くしたい...!と言うことであれば、IKEAの電球がひっそりHomeKit対応している！と一時期話題になりました。まだハブが日本発売されていないのですが、hueのハブがそのまま使えるらしいので、ハブだけhueのものを買ってランプはIKEAで、と言うのはアリかもしれません。まぁhueのスターターキットがかなりコスパ良いので結局こっちを買ったほうがいい気はするのですが。

- [TRÅDFRI トロードフリ LED電球 E26 806ルーメン - ワイヤレス調光 電球色 温白色, 電球色 温白色 球形 オパールホワイト - IKEA](https://www.ikea.com/jp/ja/p/tradfri-led-bulb-e26-806-lumen-wireless-dimmable-warm-white-warm-white-globe-opal-white-10410068/)

2018年後期になって以降、**LIFX** という有力な選択肢も登場しています。Hueとの大きな違いは、ハブとなる常設デバイスが不要、ルーメン数が高い(1100lm)、暗視効果などがあり、ほぼ上位互換と言って差し支えない性能のようです。ただしHueより更に高い値段設定のため、暗視効果のついたハイスペックモデルだと1個10,000円を越します。Hueのシングルランプ相当のモデルであれば4,000~5,000円程度なので、まだHueに手を出していない人であればこちらを導入するのがベストではないでしょうか。

- [Wi-Fi enabled LED smart lights - LIFX.com – LIFX US](https://www.lifx.com/)
- [Amazon.co.jp： LIFX LED電球 一般電球形 1100lm（暖色/寒色を含む1600万色）LIFX+ A19 - E26 Edison Screw LHA19E26UC10PJP: ホーム&キッチン](https://www.amazon.co.jp/dp/B078STG1KL)
- [Amazon.co.jp： LIFX Mini Day & Dusk A19 E26 スマートLED電球/Alexa スマホ操作 【国内正規品】 L3A19MTW08E26JP: ホーム&キッチン](https://www.amazon.co.jp/dp/B07D77MC5R)

## スイッチ

端的に言ってしまえば「何かを動かすための物理ボタン」なのですが、何を動かすのかと、有線・無線のどちらのタイプを選ぶのかが大事です。

例えば「家の中で導線の深い部屋から玄関の鍵を開ける」「ロフトベットの上から照明を常夜灯に変える」と言ったような、「ちょっと不便な操作をさらっとやりたい時に使うもの」が欲しい場合、どこにでもつけられる無線のスイッチが適しています。必要であれば個別購入しても良いですが、Hueのスターターキットにも1つついてくるので、そちらを使っても良いでしょう。個人的にはまだここは使えていないので省略しますが、買うならシンプルに使えそうなEveのButtonを買うかと思います。

- [Eve Button | evehome.com](https://www.evehome.com/en/eve-button)

これに対し、今ある照明器具などが壁面の埋め込みスイッチになっており、それをHomeKitで操作できるようにしたい！と言う場合には有線接続するスイッチを使います。つまり今の物理スイッチを外して電気工事を行う必要がありますが、この工事には日本だと「第二種電気工事士」という資格が必要です。この資格を持たずに独自に工事をすると法律違反となり罰則を受けますので注意してください。

資格取るのが面倒！と言う方であれば、スイッチを買った上で電気工事店に頼みましょう。相場は電気店の有無によってブレますが、スイッチ1個3,500円~5,000円くらいで作業してくれると思います。

- [電気工事士の資格を取ってコンセントやスイッチを改造しようぜ - Qiita](https://qiita.com/rukihena/items/a30f07f93ca1718dff8e)

また、自分も資格がないので正確な記述ができているかどうかは怪しいですが、以下のタイプが有線接続のものです。アメリカ製品が多くあるので、日本でそのまま使えるかは必ずご自身で判断or電気店に相談して、使えるかどうか判明した上で購入をお願いします。

- [https://www.ecobee.com/lighting/smart-light-switch/](https://www.ecobee.com/lighting/smart-light-switch/)
- [Single & Double Switch - Smart light switch | FIBARO](https://www.fibaro.com/en/wp-content/uploads/sites/3/2017/09/header-static-desktop.jpg)
- [The iDevices Wall Switch](https://store.idevicesinc.com/idevices-wall-switch/)
- [Insignia Wi-Fi Smart In-Wall Light Switch - White - Model: NS-CH1XIS8 - - Amazon.com](https://www.amazon.com/Insignia-Wi-Fi-Smart-Wall-Switch/dp/B078J4N9MY)
- [Wi-Fi Enabled Smart Light Switch - Koogeek.com](https://www.koogeek.com/smart-home-2418/p-kh01.html)
- [Two Gang Wi-Fi Enabled Smart Light Switch - Koogeek.com](https://www.koogeek.com/smart-home-2418/p-kh02.html)
- [Leviton DH15S-1BZ](http://www.leviton.com/en/products/dh15s-1bz)
- [Leviton DH6HD-1BZ](http://www.leviton.com/en/products/dh6hd-1bz)
- [Leviton DH1KD-1BZ](http://www.leviton.com/en/products/dh1kd-1bz)
- [Smart Lighting Dimmer Switch for Wall and Ceiling Lights](http://www.casetawireless.com/Pages/Products.aspx)

## コンセント

コンセントのON/OFFを直接操作できるカテゴリになりますが、これはこれで逆に選択が難しくなります。

基本ON/OFFをコンセントだけで操作可能なものって、おおよそカテゴリとしてはレトロな製品が多いんですね。物理スイッチだけとか、電子版がないとか、そういうものって製品としてはかなり際どいものが多くなるので、そこまでして自動化すべきものなのか、デジタル対応したものに買い換える選択はできないのかというのは、一度購入前に考えても良いのかなと感じます。

そしてこの分野、実はほとんどの製品がアメリカ式の3本足です。そのため日本で使うには、海外旅行用の変換プラグとか、その手のものも合わせて購入する必要があるのも忘れないでください。個人的にはEveの製品がわかりやすいので好きですが、これも3本足でやや価格も高めなので、買うかなぁ、どうかなぁと言ったところです。

- [Eve Energy | evehome.com](https://www.evehome.com/en/eve-energy)

## サーモスタット

今ひとつ聞きなれない家電ですが、日本における冷暖房設備だと考えてもらうのが良いかと思います。

- [グーグルが買収したNestって何がすごいの？ そもそもサーモスタットって？ | ギズモード・ジャパン](https://www.gizmodo.jp/2014/07/nest_2.html)

日本ではほぼ全ての家庭においてエアコンを使うのが主流となっているため、これを使うことはないと考えてもらって良いと思います。

## 窓とブラインド

まず、電動の窓開閉についてはかなり厳しいものとお考えください。日本の家事情として、賃貸などで両開き窓のついた手で開ける窓が一般的ですが、窓自体をリモコンなどで開けられるようになっているものは今のところほぼ皆無です。からくり仕掛けを自分で作ればできなくはないかもしれませんが、なかなか手をつけづらい分野かなと感じます。

次にブラインドについて考えてみましょう。日本はカーテンを使う家庭が多いので、普通に考えると「カーテンの開け閉めを自動化しよう！」となりますが、これはHomeKitで定義されていないジャンルです。また日本だとMornin'くらいしか選択肢がありませんが、BLEで独自通信を使っているため、これをHomeKit対応させるのは恐らく相当骨が折れます。

- [めざましカーテン mornin' plus (モーニンプラス）](https://mornin.jp/)

ということで、素直にブラインド（ロールカーテン）を買ってみましょう。選択肢の方を見ると、ほぼ海外の製品ばかり、しかも特注しないといけないものが殆どでハードルが天元突破しそうな勢いですが、認証製品抜きで考えると、最近はニトリでも販売してますので、実は以外と安価に手に入りますし、カーテンレールに直付けできるので、賃貸でも導入できたりします。

例えば以下のような所にある製品でチェーンがついたものであれば、比較的安く手に入ります。自分は遮光と採光のロールスクリーンを1本ずつ買って、同じ窓に重ねてつけてます。

- [ロールスクリーン・ロールカーテン通販 | ニトリネット【公式】　家具・インテリア通販](https://www.nitori-net.jp/ec/cat/CurtainRailBlind/RollScreen/1/)

これに対して、SOMA Smart Blindというデバイスで巻き取り部分だけを自動化しつつ、HomeKit化できるツールを組み合わせたところ、ほぼ想定通りに動作し、HomeKit連携も可能になります。ただし、先ほどのサイトの中にメーカーとして入っておらず、正規の認証を取っていない件には注意しましょう。動かなくはないですが、設定した窓に日本語名をつけるとHomeKit連携ができない、というような意外な落とし穴もあったので、ここは気をつけましょう。サポートもしっかりしてるみたいなので、いざとなったらサポートに聞いてみると言う手も使えます。

- [SOMA Smart Shades - Smart Motor for Roller Shades - SOMA Smart Home](https://www.somasmarthome.com/)

ただ、ロールスクリーン2機、SOMAからはスピアネットを使った個人輸入となってしまったため、合計4万強くらいかかりました（ロールスクリーン 自体は1万円くらいですが）。。。満足度は高いですが、こだわりと執念がないと中々手を出しづらい分野なので、一気にお金を突っ込んでももはやそこまで後悔しない一番後か、モチベの保ちやすい一番最初にやるのをオススメします。あとロールスクリーンの巻き取り部が結構扱い難しいです。

ちなみに、SOMA Connectはそのまま買うと+99ドルかかりますが、Raspberry pi のhomebridgeがあればpluginとして動作させることが可能です。コストを抑えたい、ある程度自力でなんとかしたい人はこちらを試すと良いでしょう。

- [Buy SOMA Connect - HomeKit, Google Home, Alexa Shades and Blinds - SOMA Smart Home](https://www.somasmarthome.com/products/soma-connect-blinds-control-for-amazon-alexa-apple-homekit-google-home)
- [paolotremadio/SOMA-Smart-Shades-HTTP-API: Control SOMA smart shades over HTTP](https://github.com/paolotremadio/SOMA-Smart-Shades-HTTP-API)
- [paolotremadio/homebridge-minimal-http-blinds: Minimalistic HTTP blinds Homebridge plugin](https://github.com/paolotremadio/homebridge-minimal-http-blinds)

## 換気扇(シーリングファン・扇風機)

言葉の響きで言うと、[キッチンとかについてるアレ](https://www.amazon.co.jp/換気扇/b?ie=UTF8&node=2033793051)を想像すると思うのですが、実際に並んでいる対応製品を見る限り、[シーリングファン](https://www.amazon.co.jp/s/ref=nb_sb_noss?field-keywords=シーリングファン)とか、扇風機が正しい翻訳と思って問題ないです。

そしてこのシーリングファンは悩ましいところで、日本の家屋ですと、1つの部屋に2つ以上の天井照明ソケットがついている部屋は稀で、ほぼ1つしかついていないことが多いと考えられます。

そのため照明とファンを両方つけようと思うと、シーリングファンライトにする、と言う選択になるのですが、この時点で認証のついている製品はほぼ対象外になります（そもそも日本の天井ソケットと規格も違う）。

そのため、もし導入したいのであれば、通常のシーリングファンライトを一機購入し、それを赤外線で操作する中継ハブを用意して操作し、最後にhomebridgeで操作する、と言う感じで独自対応するのが現時点での解になるかと思います。[Bond](https://bondhome.io)などはシーリングファン対応を自ら謳っているので多少やりやすいかもしれません。

ただ何れにしても、シーリングファンを導入しているご家庭はかなり少数派だと思うので、まずはエアコンから手をつけるのが良いかと思います。

あと、面白いところだとDysonの扇風機に対応したhomebridgeプラグインは見かけましたね。Dysonは正直あんまり好きじゃないので追ってないのですが、ここら辺は実現しやすいのかも。扇風機だとほぼ赤外線対応してる製品しかないので、Dyson以外はあまり選択肢見ませんね。

- [homebridge-dyson-link - npm](https://www.npmjs.com/package/homebridge-dyson-link)

## エアコンとヒーター

というわけでエアコンとヒーターです。まだ対応機器が異常に少なく、そのうち日本で買える正規認証の製品はデロンギの据え置きヒーターだけです。お値段9万円！ﾌｧｯｷｭ━━━( ﾟДﾟ)凸━━━ !!

- [マルチダイナミックヒーター Wi-Fiモデル MDH15WIFI-SETの製品情報 | ゼロ風暖房デロンギ ヒーター 風が出ないのに、部屋全体が暖かい。](https://oilheater.delonghi.co.jp/product/mdh15wifi-set.html)

つーわけで流石に暖房だけの据え置き機に9万とか...ってまずなるはずなので、別の手段を考えます。日本だとよく話を聞くのがNatureRemoですね。

- [Nature Remo — Nature](https://nature.global/jp/nature-remo)

これとhomebridgeプラグインを組み合わせるのが良いかと思いますが、現在nature remo関連で出てきているプラグインでは肝心のエアコン操作を行うプラグインを作っている人がまだいません。そのため、ここは自前で作ることになります。

私の場合、nature remoのセットアップがbuggyだったのと、内部の温度計がEveの温度計と乖離が頻繁に起きてしまいあまり信用できないと感じたため、結局tado AC Controlを米アマゾンから購入してしまいました。こちらは既にかなり質の良いhomebridgeプラグインが存在しますので、比較的に楽に導入可能かと思います。

（nature remoもほぼ同じロジックが使えると思うので、自分で作っても良いかもなぁとは思ってたり...時間あればかなー。）

- [Control your AC automatically with your Smartphone](https://www.tado.com/us/products/smart-ac-control)
- [Tado Smart Air Conditioner and Heater Controller, Wi-Fi, Compatible with iOS and Android, Works with Alexa - - Amazon.com](https://www.amazon.com/gp/product/B010ACFKNE)
- [nitaybz/homebridge-tado-ac: Homebridge plugin to support Tado Smart AC Control devices.](https://github.com/nitaybz/homebridge-tado-ac)

あと、追加で発見しましたがSensibo Skyも悪くないソリューションに見えます。日本への直販やセールもやってるみたいなので、気が向いたら買ってみたいですね。

- [Sensibo: Smart Air Conditioner | Control Your AC With Your Phone](https://sensibo.com/)
- [Amazon.com: Sensibo Sky (International) - Air Conditioner Controller, Wi-Fi, Compatible with iOS and Android, Compatible with Alexa & Google Home: Home Improvement](https://www.amazon.com/dp/B01MU2YSR4/)
- [homebridge-sensibo-sky - npm](https://www.npmjs.com/package/homebridge-sensibo-sky)

## 空気清浄機(除湿・加湿器)

目下一番悩ましい分野です（導入->現在はなし）。

日本は夏の多湿、冬の乾燥、そして春の花粉と大陸からのPM2.5ととにかく空気が汚れやすく、湿度もコントロールしにくい環境と重要度は非常に高いと考えられます。

その一方、現在正規の選択肢として出てきているのはすべて海外製品で（しかも正確な情報がまだ少ない）、日本の主要メーカーであるダイキン、シャープ、パナソニックといった会社は独自規格のスマホアプリが主流で（しかも最高ランク製品のみ）、それ以外は赤外線リモコンもついていないためhomebridgeで...なんてことすら封じられている状況です。仮に金を積んでも中々実現できないと分かっているのが現状つらいわけですね。

そのため、現状実現可能な手段としては、Xiaomiの出している空気清浄機と加湿器+homebridgeが候補かなと考えています。値段も比較的安い。

- [Mi Global Home](https://www.mi.com/global/air)
- [Formaldehyde Haze Cleaner White CN PLUG Air Purifier Sale, Price & Reviews | Gearbest](https://www.gearbest.com/home-smart-improvements/pp_268522.html)
- [seikan/homebridge-mi-air-purifier: A Xiaomi Mi air purifier plugin for Homebridge.](https://github.com/seikan/homebridge-mi-air-purifier)
- [智米除菌加湿器 - 小米商城](https://www.mi.com/humidifier)
- [russtone/homebridge-mi-humidifier: A Xiaomi Mi humidifier plugin for Homebridge](https://github.com/russtone/homebridge-mi-humidifier)

Xiaomiよくわからんねん！とか、日本で買えるものがいい！と言う方であれば、Blueairの空気清浄機もアリかもしれないと言うのは同僚から聞きました。ヨドバシなんかでも手に入りますしhomebridgeプラグインもありますが、やや価格はXiaomiより高めです。

- [【公式】ブルーエア空気清浄機 | Blueair | きれいな空気と暮らそう。世界基準No.1。](https://www.blueair.jp/wp-content/uploads/2020/03/KV_PC_02.jpg)
- [mylesagray/homebridge-blueair: BlueAir air purifier plugin for homebridge](https://github.com/mylesagray/homebridge-blueair)

ただこの構成でも「除湿機どこいったんや...」ってなりますし、それなら[ダイキンの除加湿空気清浄機](http://www.daikinaircon.com/ca/cz/index.html)にして、HomeKitは諦めて24時間365日放置する方が良いかもなぁと思ったり。いまひとつ正着が見えないので、しばらく様子見が正解なのかなぁとはずっと思ったりして1年過ぎました。ほんとどうしようここ。

## センサー

比較的手を出しやすい分野その2。日本でも正規品が色々出ています。ただし注意すべきはその内容で、温度、湿度、空気の質、一酸化炭素、二酸化炭素、煙、水漏れ、照度、モーション、人感とかなり多くの種類が定義されています。自分の場合、屋外にも置けるEve weather(販売終了, 後継はEve degree)をバルコニーに置いて温度・湿度、Eve degreeをバスルームに設置して温度・湿度を測っています。バルコニーで外気温を直接測れるのは個人的にすごく気に入ってます。

- [Eve Degree | evehome.com](https://www.evehome.com/en/eve-degree)

また、Backerkitで応募したPointと呼ばれるセンサーもオーダーしているのですが、こちらは煙、騒音、人感、温度、湿度などを見れるようです。

- [Minut Smart Home Sensor](https://www.minut.com/)

とにかく全てをカバーしようと考えるとまず無理ゲーなので、どこで何を監視したいのかをあらかじめ決めて、それに見合うセンサーを必要なぶんだけ買いましょう。水漏れセンサーとかまず必要になること早々ないでしょうし。
あと、この分野はあんまり「スマートホームしてる感」が出なかったり、エアコンとか空気清浄機買ってセンサーが付いてて、「気づいたら温度湿度センサーがめっちゃたくさんあった」みたいな状況が生まれやすいので、一番最後に必要なものだけ買った方が無駄がないです。

## スピーカー

**HomePodを買え。買うんだ。**

- [HomePod - Apple](https://www.apple.com/homepod/)

自分は先日アメリカに行く機会があったため、現地のAppleStoreで現金で購入しました。日本ではどうかというと、[発売は2019年以降](https://www.gizmodo.jp/2018/04/homepod-sell-japan.html)、なんていうマジかよーなニュースも入ってきているので、待てない人は個人輸入、ヤフオク!、メルカリあたりで買っちゃえば良いと思います。

- [ヤフオク! -HomePodの中古品・新品・未使用品一覧](https://auctions.yahoo.co.jp/search/search?p=HomePod)
- [HomePodの中古/新品通販【メルカリ】No.1フリマアプリ](https://www.mercari.com/jp/search/?sort_order=&keyword=HomePod)

ちなみにAppleの各国別Storeは色々制約も多いので、買う際にはフォームの入力内容に注意しましょう。

- [Apple Online Store (US) で日本のクレカを使ったiPad(3rd)他の注文に成功! - forzando@net](http://f.orzando.net/pukiwiki-plus/index.php?ZakkiCho%2FOrderIpad3rdOnAppleStoreUs)

HomePodの良さは語り尽くせませんが、Siriの常駐端末、AppleTVに変わるホームハブとしての機能以外にも、iTunesを直接AirPlayで繋げてmacから直接ライブラリの再生操作もできますし、iPhoneのスピーカーフォンとしても機能するので用途はなんでもアリです。

- [HomePod - Official Apple Support](https://support.apple.com/homepod)

ちなみに、HomePodのSiriちゃんはiPhoneに比べるとめっちゃ反応良いのでその点もストレスないです。ささやき声でも反応します（ただし英語）。

## セキュリティシステム

公式サイトにはHoneywellの機能が一つだけ挙がってますが、内容を見る限り各種センサーのセットを自宅に組み込んでるような感じっぽいですね。日本での導入なら無視して良いと思います。

## 鍵

スマートロックは恐らく一番UX的に来る部分なのでぜひ導入をお勧めします。ただここも例に漏れず、日本は鍵の規格が見事にガラパゴス化しており、様々なハードルがあります。

まず、使える鍵・ドアハンドルの形式が限られます。日本の賃貸物件でよく見られる[プッシュプルタイプのドアハンドル](https://www.google.com/search?tbm=isch&q=プッシュプル+ドア)を持つ鍵がその最たるものです。自宅のドアがこのタイプの場合、スマートロックの装着はかなり厳しくなります。そしてこのハードルを超えても、二大メーカーであるMIWA、GOAL共にHomeKit対応などは発表していませんし、海外のHomeKit対応したものも、鍵の軸部分が海外メーカーと違うため、そのままはほぼ使えないと思ってください。

また、賃貸住宅の場合、共用部である鍵の外側部分を改造する行為は賃貸借契約上不可能なことが多いです。そのため、[Akerun](https://akerun.com/smartlock/)のようなサムターンの上に被せて使うタイプ、もしくは部屋側のサムターン部分だけを外して付け替えるタイプが限界、ということになります。（後者については微妙な切り分けのことも多いので、必ず契約書をよく読んで、不明な点は管理人に相談しましょう。）

さて、ここまでハードルを超えた上で、唯一日本で手に入る正規認証品はDanalock v3ですが、レビューなどを見るとかなり荒れているので更に勇気が必要になります。そもそももう品切れなので手に入りませんが...。

- [Danalock V3 Smart Lock · Danalock](https://danalock.com/products/danalock-v3-smart-lock/)
- [Poly Control danalock V3 BTHK スマートロック Apple HomeKit 対応 日本正規代理店品 日本専用取り付け部品付き](https://www.amazon.co.jp/dp/B076RGFJBT)

私の場合、米AmazonからAugust Smart Lockを購入しました(ハブがある場合、August Connectは不要なので単品買いでOKです)。 

- [August Smart Lock Pro | The Ultimate Smart Lock for Your Smart Home](https://august.com/products/august-smart-lock-pro-connect)
- [Amazon.com: August AUG-SL-CON-S03 Silver Smart Lock Pro, 3rd Generation-Dark Gray, Apple HomeKit Compatible and Z-Wave Plus Enabled: Home Improvement](https://www.amazon.com/gp/product/B0765JNS2D/)

また自宅の鍵がMIWA製だったのでそのままは使えませんでしたが、ちょうどDMM.makeでこの部品を作られている方がいらっしゃったため、こちらを利用しています。一番安いMJFで注文しましたが、今の所この組み合わせで問題なく動作しています。特に目立つ動作遅延もなく快適です。

- [オーガスト スマートロック August smartlock 美和ロック用パーツ - DMM.make クリエイターズマーケット](https://make.dmm.com/item/906136/)

GOAL製の場合はDanalock v3の再入荷を待つほかありませんが、CADが使える人であれば、自分で上記のようなパーツを作ってしまって、August Smart Lockを買う方が良いかもしれません(ちなみに米Apple Storeに行った際、Appleの店員さんもAugustはかなりオススメしてました)。

あと、これは注意ですが、スマホを持って外出している時でも、必ず物理キーは持って外出しましょう。これはロックがバッテリー切れで解錠できなくなったとかのトラブル防止や、そもそもオートロックのあるマンションだとエントランスで足止めを食らうためです。物理キーを取り出さなくて良くなると考える方が健全です。

## カメラ

未導入なので検討段階です。ここでのカメラは、主に監視、コミュニケーション用のカメラとしての用途が主になります。そのため防犯用途で必要と判断すればつけても良さそうです。日本で室内、防犯・コミュニケーション用途であれば、まずほぼD-Linkのカメラ一択と考えて差し支えありません。

- [DSH-C310 Omna 180 Cam HD | D-Link](https://eu.dlink.com/global/-/media/product-pages/dsh/c310/omna.png)

Netatmoも国内販売がありますが、こちらは更に顔認識の機能がついており、登録した人間以外がドアから入ってくると警告します。その分お値段も高いですが、より厳密な監視がしたいならこちらでしょう。

- [Smart Indoor Security Camera | Netatmo](https://www.netatmo.com/en-us/security/cam-indoor)

室外用途であれば、同じくNetatmoの室外用カメラが良さそうです。ガレージ持ってる人なんかはこれが良いのかも。

- [Smart Outdoor Camera | Netatmo](https://www.netatmo.com/en-us/security/cam-outdoor)

## ドアベル

鍵方面で強いAugustからドアベルが登場。ただ日本だとマンションのオートロックやセキュリティがしっかりしている関係上、一戸建ての人が導入するのが現実的かなーと思います。遠隔からカメラの相手と通話してそのまま解錠まで持っていけるので、頻繁にゲストが来る環境であれば導入しても面白そうですね。

- [August Doorbell Cam Pro | Home, even when you're not.](https://august.com/products/august-doorbell-cam-pro)

## ガレージのドア

未導入。もはやそこまでやるのかという感じですが、アメリカと日本でガレージのドアの仕様とか全くわからんのでレビューできません／(^o^)＼
説明書とか読む感じだと、端子に直付けする感じっぽいですね。この辺とかいいんじゃないですか（適当）

- [IT4WIFI The smart garage door interface | Nice](https://www.niceforyou.com/en/it4wifi)

`youtube: https://www.youtube.com/watch?v=Lu96irSRGxE`

## ブリッジ

ブリッジというのは、これまでのべてきた様々なデバイスを集約して管理する中継器のことです。よくあるパターンとして「単体だとスマホだけだけど、ハブを買えばHomeKit連携できるよ！」というパターン。お金もかかるので各社なるべくハブを減らして欲しいなぁと思う今日この頃です...。


# その3. 諦める分野の製品

これはあくまで個人的な意見ですが、Appleが定めた規格に対応していない製品を無理やりHomeKit対応させるのはあまり体験が良くないと感じています。

よくみるケースとして、赤外線リモコン学習装置を使って、テレビのリモコンを無理矢理操作するものがあります。テレビがそもそもHomeKit対応していないという事情もあるのですが、良く考えてみると、テレビは単独で何らかの機能を果たす機器ではありません。あくまで「見たいものがあって、それに入力を切り替える」という操作はいずれにしても発生するので、それをリモコンなしでやるのはUX上好ましくないと感じます。

PS4やSwitchをつけるにしても、コントローラを握れば自動で電源がつくはずなので、わざわざHomeKitを介する必要性は今の所ないように感じます（とはいえ、私も朝の6時に自動でオンタイマー仕掛けてるので、こういう用途には確かに欲しいなーと思うのですが。やせ我慢...。）

- [Hey Siri でテレビがつく！テレパソHomeKitの設定手順 – 海外で日本のテレビを見る](https://blog.watchjtv.com/index.php/2017/01/05/manual-homekit/)

同じくルンバのようなお掃除ロボットもまだ定義されていないデバイスに該当します。自宅のルンバは800番台なのでそもそも赤外線以外できないという事情はあるのですが、HomeKitに登録されてから考え始めた方がより最適化されるのかなと考えて手をつけていません。

- [Roomba（ルンバ） とマイホームとIoT - Qiita](https://qiita.com/umesan/items/ea9d1603d139387b6a97)

そして最後になりますが、個人的には赤外線通信しないと使えないリモコン対応デバイスは、いっそのこと捨ててしまった方が良いと考えています。

エアコンにtadoが出てきたようにカバーする価値のある・環境の整ってるものであれば良いと思うのですが、例えば照明機器なんかはHueを買った方がUXが段違いに改善します。数万の導入費用で済むのなら、赤外線通信用のリモコンツールを買うより、新しいHomekit対応済の認証品に惜しまず突っ込んだ方が得策です。

# その4. 違うところで頑張る製品

例えば、「自分が寝たら電気を消して欲しい」とか、そういうパターンのやつですね。はっきり言います。**諦めましょう。**なんでかってーと、Appleの場合はその領域はHealthKitが担当する領域だからです。

- [iOS - ヘルスケア - Apple（日本）](https://www.apple.com/jp/ios/health/)

このHealthKitとHomeKitの領域がコラボする話は今のところは一切聞かないので、それぞれ別に考えた方が良いと思います。この例であれば、時間になったら自動的に電気を暗くしていくとか、hue側で対応するのが無難って感じでしょうか。HealthKitについてもちょいとい投資してますので、そっちの話もまた機会があれば書こうと思います。

# その5. 自宅の設備がどうしても厳しい

例えば「どうしてもスマートロックをつけたいけど、自宅の鍵がプッシュプル式(´・ω・)」とか「照明が埋め込み式でHueつけられない(´・ω・)」とか、日本は特にそういう環境の部屋も多いのかなと感じています。

諦められない人は**いっそのこと引越しましょう。**「どうしてもガレージのドアをHomeKitで管理したい！」とか、そういう稀有な人でもない限り、1Kで条件にあう部屋を探すのにそこまで苦労はしないと思います。個人的にはどこかでマイホームを買いたいなぁと思いつつ、一寸先は闇な業界なので、なかなか踏ん切りつかねぇなぁと悩ましく思う今日この頃です...。

----

というわけで、個人的に挑戦・思考した体験内容を一通り書いてみましたがいかがでしたでしょうか。皆様のHomeKitライフに少しでもお役立ちできれば幸いです。
