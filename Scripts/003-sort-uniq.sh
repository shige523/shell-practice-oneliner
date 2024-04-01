#!/bin/bash

set -euo pipefail

seq 5 | awk '{if ($1%2==0){print "偶数"} else {print "奇数"}}'

echo "====三項演算子====="

# 三項演算子でもかける
# 1がTrueなので、あまりで判定するならこの書き方も可能
# uniq -c で重複する行がいくつあるか数えることができる
seq 5 | awk '{print $1%2? "奇数":"偶数"}' | sort | uniq -c | awk '{print $2,$1}'

# sortのオプション
# -n 数字順のソート
# -k 列を指定してのソート

echo "====sort -n ====="

seq 5 | awk '{print $1%2? "奇数":"偶数"}' | sort -n

echo "====sort -k ====="

seq 5 | awk '{print $1%2? "奇数":"偶数"}' | sort | uniq -c | awk '{print $2,$1}' | sort -k2,2n
