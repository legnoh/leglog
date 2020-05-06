---
title: 2013-04 / 配列のインデックスに 小数を入れるとどうなるか
slug: 2013-04
author: Ryoma Kai
date: 2013-01-23
hero: ./images/no-hero.png
excerpt: 
before_title: 配列のインデックスに小数を入れるとどうなるか
tags: []
---

研究の実装最中に、配列に関して少しトリッキーな技を使えないかなと、こんなことを考えてた。

## 例

```as3
for(var i:int=0; i<20; i++){

    var num:Number = i / 10 ; // 0 < num < 2 の範囲をとる小数値
    var box:Array = ["a","b"]; // box[0]="a", box[1]="b"
    trace(box[num]); // 出力

}
```

この時、 `box[num] `のとる値は何になるか。
`num` は小数値をとっているので `box[0.1]` とか、`box[1.8]` とか、そんなことになるのだが。

## 回答

どうやら言語によって答えが変わるらしい。

### PHP

```
aaaaaaaaaabbbbbbbbbb
```

Number型がintに自動的に切り詰められるので、1未満は0, 1以上2未満は1として扱われて動作する。
このへんPHPは相当親切だなぁと実感。

ちなみにPerlでも似たような挙動を示すらしい。

[Perl の配列のインデックスに小数を使うと - BitWalker](http://bitwalker.dtiblog.com/blog-entry-112.html)

### ActionScript・JavaScript

`num=0` は当然動くが、1で

```
Error #1010: A term is undefined and has no properties.
```

jsでは、

```
undefined
```

いわゆる「そんなもんねーよ」のエラー。ブチッと止まる。
一番無難な、融通の効かない感じの反応になる。


だが両言語とも、配列は連想配列としても定義できるため、

```js
box[0.1]="c";  // 本当はbox["0.1"]の方がよろしい
```

なんて指定をしていた場合、0.1がStringとして認識されるので、ちゃんと"c"と出て動いてしまう。
`undefined` はその意味で「指定していない」ということとも取れるけど、どうなんだろね。

## 結論

素直にIf使いましょう

```as3
for(var i:int=0; i<20; i++){
    
    var num:String = 0;
    var box:Array = ["a","b"]; // box[0]="a", box[1]="b"

    if( i >= 10){
        num = 1;
    }

    trace(box[num]); // 出力
}
```

しかしLLはフリーダムだなー('A`)
気が効きすぎててどこかでポカしてることあるから逆に神経使いたくなる…。
