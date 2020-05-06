---
title: 2011-44 / HTML中の細かい文法ミス / $.getJSON/$.ajax が動かない / 久々にクライアント更新
slug: 2011-44
author: Ryoma Kai
date: 2011-10-23
hero: ./images/20120126210528.jpeg
excerpt: 
before_title: HTML中の細かい文法ミス / $.getJSON/$.ajax が動かない / 久々にクライアント更新
tags: ["javascript", "twitter"]
---

リンクのクリックでtwitterのタグ検索結果をExtJS4のグリッドタブページで開く処理を実装中のこと。

```js
var text=''; //ツイート本文
var tag = new Array(); //text中のタグ認識用

text.replace(pattern_hashtag,'<a href="javascript:void(0)"onclick="makeSearch('+tag[0]+')">'+tag[0]+'</a>');
```

- `makeSearch(word)` … API発行用メソッド

テキスト中のURLをタグ検索ページ用に書き換えるところ。

ここのonclickだけ他のonclickは動くのに動かず小一時間悩んでいたのだけど、

```diff
< text.replace(pattern_hashtag,'<a href="javascript:void(0)"onclick="makeSearch('+tag[0]+')">'+tag[0]+'</a>');
---
> text.replace(pattern_hashtag,'<a href="javascript:void(0)"onclick="makeSearch(\''+tag[0]+'\')">'+tag[0]+'</a>');
```

ものすごく細かい文法ミスしててリアルにorz状態に。
`makeSearch('#hoge')` みたいになるわけだから、最後にダッシュ残らないといけないのね。。。

----

javascript で短縮URLの展開やろうとして、手短にURL展開してくれる ss-o.net さんのAPIを使って展開を試みて、以下のコードを回した。

```js
function urlExpand(url){
	var exurl=url;
	$.ajax({
		type:"GET",
		url :"http://ss-o.net/api/reurl.json?callback=?",
		data:{url:url},
		dataType:"jsonp",
		success:function(data,status){exurl=data.url;},
		error:function(){Ext.Msg.alert('短縮URL取得失敗');}
	});
	return exurl;
}
```

だがこれでsuccessが呼ばれずerrorが呼ばれ、getJSONを使って同様にするもやはり動かず。
一応戻ってきたjsonファイルを確認するも、きちんとjqueryで関数名をつけた正規のjsonpが返ってきてた。
つまり、通信も成功してて、その中身も正しいjsonなのを確認したのだけど、何故か弾かれてしまっている。

結論から先に言うと、やっぱりjQueryがページ読込前には動けないってところと関係が深いらしい。

アプリ開いて最初に取得した分は思うように動かなかったのだが、アプリ開いたまま更新で取得した分は問題なく処理を終えた。
となると、アプリの骨組みを読み込むタイミングでonReadyとか$.系の処理を一旦完了して(jQueryを使用可能にして)、そこから更新作業で頑張らせたほうがいいらしい。

てかそもそも、業者じゃない個人運営のAPIを(例え個人的なソフトでも)使うのはなるべく避けたいなーとも思うので、できればrubyで一行展開してたような某記事のようなコードをさらっと書きたい。実際アクセスしてヘッダー見ればOKなだけだし。

![](./images/20120126210528.jpeg)

idやタグをもっと見やすくしてもいいのかな？と思うので強調してみる。
jsのシームレスな動きと合わせられるともう少し使いやすくなるかな？と思う。

後、ほぼついでだったけどタグ検索も実装。こちらはリスト表示。
