#!/usr/bin/ruby
# -*- coding: utf-8 -*-
#
# NOTE: 第1引数で gensec を指定した際には，SECONDSスクリプトを生成
#
arg1 = ARGV.shift
A = 0..15  # 入力 a の値の範囲
B = 0..15  # 入力 b の値の範囲
C = 0..1   # 入力 cin の値の範囲
time = 1   # 時刻
for a in A
  for b in B
    for cin in C
      sum = a + b + cin # 出力値の計算
      if sum > 15
        # sum が15より大きい場合は，下の4ビットのみ取り出し，coutを1に設定
        sum = sum & 15
        cout = 1
      else
        # sum が15以下の場合は，coutは0
        cout = 0
      end
      if arg1 == "gensec" then
        # SECONDSスクリプトの生成
        print format("set a %04b; set b %04b; set cin %1b; forward +1;",
                   a, b, cin)
        print format("\t# %2d + %2d + %1d -> sum=%2d cout=%1d\n", 
                   a, b, cin, sum, cout)
      else
        # 検証用パターンの生成
        print format("%-4d %04b %04b %1b %04b %1b\n",
                     time, a, b, cin, sum, cout)
      end
      time = time + 1
    end
  end
end

# End of file 

