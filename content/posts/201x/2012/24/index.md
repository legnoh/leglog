---
title: 2012-24 / PHP でエンコードの違う HTML を上手く捌く方法
slug: 2012-24
author: Ryoma Kai
date: 2012-06-10
hero: ./images/no-hero.png
excerpt: 
before_title: エンコードの違うHTMLを上手く捌く方法
tags: ['php']
---

マッシュアップの検索エンジンを使って~~遊んでる~~研究してるのだけど、現状shift_jisやeuc-jp等の日本語エンコードが扱えなかったので対応させるにはどうすればいいかな、と悩んでた。要件としては、

- コードはPHP
- URLからHTMLヘッダーのkeywordsとdecriptionをUTF-8で出力する
- 日本語扱えればいいしShift-JIS,EUC-JPくらいまで対応出来ればおｋ ISO-2022-JPあたりも


最初はページ全部貰って来てエンコード判定スクリプトに突っ込めばええやんとか思ったのだけど処理速度考えるとちょっと辛い。
なのでHTMLヘッダを `get_headers(url)` で貰ってきて、その中の Content-Type を見ることにした。

```php
$tags = get_meta_tags($res->url);
$headers = get_headers($res->url,1);
$ctype = $headers['Content-Type'];
 
if(preg_match('/utf-8|euc-jp|shift_jis|iso-2022-jp/iu',$ctype,$cset)){
 
  switch($cset[0]){
    case 'euc-jp':
    case 'EUC-JP':
      $tag_key  = mb_convert_encoding( $tags['keywords'],   'UTF-8' , 'eucJP-win');
      $tag_desc = mb_convert_encoding( $tags['description'],'UTF-8' , 'eucJP-win');
      break;
 
    case 'shift_jis':
    case 'Shift_JIS':
    case 'SHIFT_JIS':
      $tag_key  = mb_convert_encoding( $tags['keywords'],   'UTF-8' , 'SJIS-win');
      $tag_desc = mb_convert_encoding( $tags['description'],'UTF-8' , 'SJIS-win');
      break;
 
    case 'iso-2022-jp':
      $tag_key  = mb_convert_encoding( $tags['keywords'],   'UTF-8' , 'ISO-2022-JP');
      $tag_desc = mb_convert_encoding( $tags['description'],'UTF-8' , 'ISO-2022-JP');
      break;
 
    case 'utf-8':
    default:
      $tag_key = $tags['keywords'];     // keyword
      $tag_desc = $tags['description']; // description
      break;
  }
}else{
   $tag_key = $tags['keywords'];     // keyword
   $tag_desc = $tags['description']; // description
}
```

本当はUTF-8をわざわざ書くまでも無いのだけど、コード判定の結果をフォント変えて出力したかったので。
これで7割以上は対処できるようになったけど、一部リダイレクトとか `text/html;` 以降が読み込まれずまだ完全ではない。

読み込めなかったページに関しては判定スクリプトで回して対処すればええと思うけど、そこまで重要な課題では無いので気楽に考えとこう。
