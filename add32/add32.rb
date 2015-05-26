#!/usr/bin/ruby
# -*- coding: utf-8 -*-
#
# NOTE: 第1引数で gensec を指定した際には，SECONDSスクリプトを生成
#                 genpat を指定した際には，Verilog 入力パターンを生成
#                 genout を指定した際には，Verilog 入出力パターンを生成
arg1 = ARGV.shift
SEED = 20090608   # 乱数の種
srand(SEED)
C = 0..1          # 入力 cin の値の範囲
time = 1          # 時刻
N = 2000          # テストパターンの数(実際はこの数の2倍のパターンを生成)
MAX = 0xffffffff  # 32ビットで表現できる最大の数
N.times do
  a = rand(MAX + 1) # ランダムな入力信号
  b = rand(MAX + 1) # ランダムな入力信号
  for cin in C  
    sum = a + b + cin # 出力値の計算
    if sum > MAX
      # sum が MAX より大きい場合は，下の32ビットのみ取り出し，coutを1に設定
      sum = sum & MAX
      cout = 1
    else
      # sum が MAX 以下の場合は，coutは0
      cout = 0
    end
    if arg1 == "gensec" then
      # SECONDSスクリプトの生成
      print format("set a %032b; set b %032b; set cin %1b; forward +1;\n",
                   a, b, cin)
# 長くなるので表示しない
#      print format("\t# %2d + %2d + %1d -> sum=%2d cout=%1d\n", 
#                   a, b, cin, sum, cout)
    elsif arg1 == "genpat" then
      # Verilog テストベンチ用の入力信号パターンの生成
      print format("%032b_%032b_%1b\n", a, b, cin)
    elsif arg1 == "genout" then
      # Verilog テストベンチ用の検証用信号パターンの生成
      print format("%4d %032b %032b %b %032b %b\n",
                   time, a, b, cin, sum, cout)
    else
      # 検証用パターンの生成
      print format("%-4d %032b %032b %1b %032b %1b\n",
                   time, a, b, cin, sum, cout)
    end
    time = time + 1
  end 
end

# End of file 

