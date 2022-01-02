---
title: 2012-48 / as3のXML解析にて嵌った
slug: 2012-48
author: Ryoma Kai
date: 2012-11-30
excerpt: 
before_title: as3のXML解析にて嵌った
tags: []
---

初めて使うFlashとas3に悪戦苦闘中…。
XMLをパースしてその一件目のタイトルをTextFieldで表示するプログラムを作っていたが、これだけで２日くらいハマったのでメモ。

```as3
public class Main extends Sprite {
	
	private var text_field:TextField;
	
	public function Main():void {
		
		text_field = new TextField();
		
		var loader:URLLoader = new URLLoader();
		var request:URLRequest=new URLRequest("(Y!検索API)");

		loader.addEventListener(Event.COMPLETE,function(event:Event) {
			var yXML:XML = new XML(event.target.data);
			text_field.text = yXML.Result[0].Title; // Error!!
		});
		loader.load(request);
	}
}
```

読み込ませたXMLデータはY!のアップグレード版Web検索APIで「javascript」を検索したもの。

```xml
<ResultSet xmlns="urn:yahoo:jp:srch" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" firstResultPosition="1" totalResultsAvailable="408000000" totalResultsReturned="10" xsi:schemaLocation="urn:yahoo:jp:srch http://search.yahooapis.jp/PremiumWebSearchService/V1/WebSearchResponse.xsd">
	<Result>
		<Title>JavaScript - ウィキペディア - Wikipedia</Title>
		<Summary>JavaScript（ジャバスクリプト）とは、オブジェクト指向スクリプト言語である。主にウェブ ブラウザなどのクライアントサイドで実装され、動的なウェブサイトの構築や、RIAなどの 高度なユーザインタフェースの開発に用いられる。</Summary>
		<Url>http://ja.wikipedia.org/wiki/JavaScript</Url>
		<ClickUrl>http://ja.wikipedia.org/wiki/JavaScript</ClickUrl>
		<ModificationDate/>
		<Cache>
			<Url>http://cache.yahoofs.jp/search/cache?c=zAD2D7XXwZoJ&u=http://ja.wikipedia.org/wiki/JavaScript&p=javascript</Url>
			<Size>98000</Size>
		</Cache>
	</Result>
	…
</ResultSet>
```

これで回したら、text_field.text = xml.Result[0].Title;　の部分にて、そんなプロパティねーよのエラーが発生。

```
TypeError: Error #1010: A term is undefined and has no properties.
	at Function/<anonymous>()[/Users/HAL/Code/Legdoxea/Main.as:234]
	at flash.events::EventDispatcher/dispatchEventFunction()
	at flash.events::EventDispatcher/dispatchEvent()
	at flash.net::URLLoader/onComplete()
```

調べたところ、XMLのqName、名前空間に関する問題だということが分かった。こんなの知らなかった…。

- [XML名前空間の簡単な説明](http://www.kanzaki.com/docs/sw/names.html)

要約すると、XMLの一つの文書の中に複数形式のXML文書が混ざった時、タグ名が混同すると面倒なので、そんな時のために接頭辞つけて区別しましょう、と。
それが xmlns (XMLNamespace,名前空間)であり、これがついた場合、**子孫のタグがすべてこの名前空間に属することになる。**
つまり `<Title>` が欲しくても、厳密には

- `xmlns="urn:yahoo:jp:srch"`
- `xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"`

の２つの名前空間に属しているため、`<Title>` ではなく、`<Title xmlns="urn:yahoo:jp:srch" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">` という認識をされていたため、「存在しないよ！」と怒られたらしい。

## 解決策

`xmlns:xsi`の方は、

```as3
removeNamespace("http://www.w3.org/2001/XMLSchema-instance");
```

という感じで [removeNamespace()](http://livedocs.adobe.com/flash/9.0_jp/ActionScriptLangRefV3/XML.html#removeNamespace()) メソッドを使うことで、子孫に至るまでの名前空間を取り除くことができる。

だが、`xmlns` の方は、これでは取り除くことができないので、この名前空間を [デフォルトの名前空間に設定](http://livedocs.adobe.com/flex/3_jp/html/help.html?content=13_Working_with_XML_09.html) してしまうことにする。

```as3
default xml namespace = new Namespace("urn:yahoo:jp:srch");
```

```as3
public class Main extends Sprite {
	
	private var text_field:TextField;
	
	public function Main():void {
		
		// デフォルト名前空間に設定
		default xml namespace = new Namespace("urn:yahoo:jp:srch");

		text_field = new TextField();
		
		var loader:URLLoader = new URLLoader();
		var request:URLRequest=new URLRequest("(Y!検索API)");

		loader.addEventListener(Event.COMPLETE,function(event:Event) {
			var yXML:XML = new XML(event.target.data);
			
			// xmlns:xsiの名前空間を削除
			yXML.removeNamespace("http://www.w3.org/2001/XMLSchema-instance");

			text_field.text = yXML.Result[0].Title; // JavaScript - ウィキペディア - Wikipedia
		});
		loader.load(request);
	}
}
```

## 参考

- [flash - AS3 Parsing XML - Stack Overflow](http://stackoverflow.com/questions/8160541/as3-parsing-xml)
- [AS3 の XML オブジェクトと namespace (xmlns) - #生存戦略 、それは - subtech](http://subtech.g.hatena.ne.jp/secondlife/20070211/1171120066)
- [AS3のXML名前空間で嵌まる - プログラミングとかそんなの](http://d.hatena.ne.jp/kkanda/20071004/p1)
- [デフォルトXML名前空間の件 - func09](http://www.func09.com/wordpress/archives/141)

他の記事で、as3にある `qName` クラスを使う方法、デフォルトにせず名前空間を指定する方法、またXML文書中から正規表現でxmlnsまで強引に排除する方法も紹介されているので一番勝手の良い物を使うのが良いかと。

てかアレですね、スパゲティスパゲティしてるとprivateマズかった？とか別の方向に解決方法見出そうとして遠回りしちゃうアレ、なんとかしたいですね('A`)
