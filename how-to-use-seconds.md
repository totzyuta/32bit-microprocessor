- seconds起動

```
$ seconds
```


- sflファイル読み込み

```
SECONDS> sflread program.sfl
```


- モジュールの自動インストール

```
SECONDS> autoinstall program
```


- レポート機能の設定

```
SECONDS> rpt_add A "t=%t | a=%b b=%b do=%b | c=%b\n" a b do c
```

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
