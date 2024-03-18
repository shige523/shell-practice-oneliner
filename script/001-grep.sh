#!/bin/bash

set -euo pipefail

# xargsをで出力を横に並べる
seq 100 | grep "0" | xargs

# 先頭が8のもの
seq 100 | grep "^8" | xargs

# 最後が8のもの
seq 100 | grep "8$" | xargs

# 8で始まる二文字
seq 100 | grep "8." | xargs

# 「1で始まり、あとは0が0個以上続いて行末に達する
seq 100 | grep "^10*$" | xargs

# 02468 で終わるもの全て | 偶数
# []はかっこないのどれか一文字
seq 100 | grep "[02468]$" | xargs

# 02468 以外で終わるもの全て | 奇数
# [^ ]でカッコ内の文字列以外の全て
seq 100 | grep "[^02468]$" | xargs

# ゾロ目を出す | ゾロ目
# ^(.)に１番がつくので。\1とすることで同じ文字=ゾロ目となる
seq 100 | grep -E "^(.)\1$" | xargs

# 田が後ろにつく名前だけを出力する
# スペースでない一文字の後ろに田がつく
# 山田と田代の間に空白があるので、ここをチェックできる
# grep -o で正規表現にマッチする部分だけを出力できる
echo 中村 山田 田代 上田 | grep -o '[^ ]田'

seq 5 | awk '/[24]/'

# 計算式を使うことができる
seq 5 | awk '$1%2==0'

# 検索にマッチした行に処理を加える
# %sはprintfの２番目の引数に書いた変数$1の値を入れる場所
seq 5 | awk '$1%2==0{printf("%s 偶数\n",$1)}'
# 下記の書き方の方が一般的
# $1と文字列の間に神間が必要
seq 5 | awk '$1%2==0{print $1,"偶数"}'

# awkはまずシングルクォートで処理を囲む
# 条件式やコマンドは{}で囲ってやる
seq 5 | awk '{if ($1%2==0) {print $1}}'

# BEGIN で初期化 ENDで最終処理を記述
# BEGINはawkの処理が始まる前、ENDはawkの処理が終わった後の処理を記述できる
# BEGIN〜ENDの間で、初期化ブロック、ifブロック、SUMするためのブロックがある
seq 5 | awk 'BEGIN{a=0} {if($1%2==0) {print $1, "偶数"} else {print $1, "奇数"}} {a=a+$1} END{print "合計",a}'
# 普通に+=を使用できるよ
seq 5 | awk 'BEGIN{a=0} {if($1%2==0) {print $1, "偶数"} else {print $1, "奇数"}} {a+=$1} END{print "合計",a}'
