- seconds起動

```
$ seconds
```


- sflファイル読み込み

```
SECONDS> sflread program.sfl
```

secスクリプトがある場合は以下のように読み込みを行う。

```
SECONDS> sflread program.sfl < script.sec
```

ファイルとして出力して、サンプルの出力ファイルと差分を確かめるには、以下のようにする。


```
SECONDS> sflread program.sfl < script.sec > program.result
$ diff program.result sample.result
```


- モジュールの自動インストール

```
SECONDS> autoinstall program
```


- レポート機能の設定

```
SECONDS> rpt_add <key> <format> {<facility>}
```

- b: 2進数表示で出力
- d: 10進数表示で出力
- o: 8進数表示で出力
- x: 16進数表示で出力
- s: ステージ/セグメントファシリティの状態値を出力


e.g.

```
SECONDS> rpt_add A "t=%t | a=%b b=%b do=%b | c=%b\n" a b do c
```

- 参考

http://www-lab09.kuee.kyoto-u.ac.jp/parthenon/NTT/hajimete/secref/rpt_ad.htm



- 制御入力端子への値の設定 

```
SECONDS> set do 1
```

- 入力端子への値の設定

```
SECONDS> set a 0
```

- 制御入力端子、入力端子のホールド設定

```
SECONDS> hold do
SECONDS> hold a
```


- クロックを進める

```
SECONDS> forward +1
```


- 終了

```
SECONDS> bye
```
