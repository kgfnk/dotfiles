---
title:  {{_input_:案件名}}会議議事録
author: {{_expr_:expand('$USER')}}
tags: [meeting]
...

## 日時・場所・出席者

日時　　：{{_expr_:strftime('%Y-%m-%d(%a) %H:00')}} - {{_expr_:strftime('%H:00', localtime() + (60 * 60))}}  
場所　　：{{_input_:場所}}  
出席者　：○○・○○・○○(敬称略)  

## アジェンダ

* ○○○○○○○○○
* ○○○○○○○○○

## 議事内容

* ○○○○○○○○○
* ○○○○○○○○○

## 決定事項

* ○○○○○○○○○
* ○○○○○○○○○

## 次回開催予定

{{_expr_:strftime('%Y-%m-%d(%a) %H:00', localtime() + (7 * 60 * 60 * 24))}} -
