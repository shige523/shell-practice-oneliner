#!/bin/bash

# xargsはパイプで渡ってきた値を引数としてコマンドに渡すことができる
# for_eachみたいなものだと思えば良い
# なので列挙して処理ができる
# seq 4 | xargs mkdir／

seq 4 | xargs rmdir

# 1と3のディレクトリを作成する
seq 1 2 3 | xargs mkdir

# 入力された文字を２個ずつ渡す
# なので、下記の場合だと
# mv 1 2 と mv 3 4が続けて実行されることになる
# -nオプションは引数の個数を表す
seq 4 | xargs -n2 mv

# -Iオプションを使用することで任意の位置に引数を展開できる
# 下記の例だと引数を@に置き換えてmkdirの@の箇所で展開している
# なのでdir_数字のディレクトリを作成することができる
seq 4 | xargs -I@ mkdir dir_@

# xargsは強力だが、場合によってはマイナスな場合もある
# 処理速度、安全性等
# 思ったように引数が渡らないこともある
# アドホックなスクリプトだと良いのかもしれない

seq 4 | awk '{if ($1%2==0){print "mkdir even_"$1} else {print "mkdir odd_"$1}}' | bash

# 三項演算子でも書けるはず
seq 5 | awk '{print "mkdir " ($1%2? "odd_":"even_") $1}' | bash

