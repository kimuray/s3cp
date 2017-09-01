aaaa
# ハッシュを覚えよう

Rubyを勉強しているとハッシュというものに出会います。
ハッシュはRubyに限らず、他のプログラミング言語でも出会うことはしばしばあると思います。(PHPだと連想配列と言われていたりします。)

このハッシュは結構扱いを覚えると便利な存在なのですが、プログラミング初学者などが出会うとわりと混乱しやすいんじゃないかなと感じています。（私自身、プログラミング初学の時はハッシュを扱う感覚がいまいちつかめず苦戦した記憶が…）

なので今回はハッシュの基本的なところを学んでいきたいと思います。

## まずハッシュってなに？
ハッシュとはキーに任意の名前をつけることができる配列のようなものです。

キーとか配列とかいきなり言われても…というのがあると思うのでまずは配列を復習しましょう。

```rb
ary = ['dive', 'into', 'code']
=> ["dive", "into", "code"]
ary[0]
=> "dive"
```
配列はこのように`[]`の中にカンマ（,）区切りで値を書くことによって一つの変数の中に値を複数持つことができるもので、例のように`ary[0]`とアクセスすると`[]`で最初に書いた値を取り出すことができます。
配列を作成すると`0`から順番に値にアクセスするための番号が振られます。この番号を`キー`と呼びます。

この復習したことを頭に入れてハッシュを見ていきましょう。
```rb
hash = {'company' => 'diveintocode', 'ceo' => 'noro'}
=> {"company"=>"diveintocode", "ceo"=>"noro"}
hash['company']
=> "diveintocode"
hash['ceo']
=> "noro"
```
ハッシュを作成する時は配列とはことなり`{}`の中に値を書いていきます。
`{}`の中では`'キーの名前' => '設定する値'`のように書きます。
このようにハッシュを設定することで`hash['キーの名前']`で意図した値を取得することができます。

配列とハッシュの使い分けとしては、配列はとにかく大量のデータを入れる場合、ハッシュは代入する値が大体決まったパターン担っている場合に使っていきます。

## ハッシュの操作
ハッシュの操作でよくあるのは値の追加、値の取り出しが主になります。
ハッシュにはハッシュを操作するメソッドが用意されているので見ていきましょう。

* 要素の追加
```rb
hash = {'company' => 'diveintocode', 'ceo' => 'noro'}
=> {"company"=>"diveintocode", "ceo"=>"noro"}
hash.store('employee', 'kimura')
=> "kimura"
hash
=> {"company"=>"diveintocode", "ceo"=>"noro", "employee"=>"kimura"}
```
要素の追加は`store('キーの名前', '値')`で行うことができます。


* 要素の削除
```rb
hash = {'company'=>'diveintocode', 'ceo'=>'noro', 'employee'=>'kimura'}
=> {"company"=>"diveintocode", "ceo"=>"noro", "employee"=>"kimura"}
hash.delete('employee')
=> "kimura"
hash
=> {"company"=>"diveintocode", "ceo"=>"noro"}
```
要素の削除は`delete('キーの名前')`で削除することができます。

* 要素の取り出し
```rb
hash = {'company'=>'diveintocode', 'ceo'=>'noro'}
hash.each do |key, value|
  puts key  
  puts value  
end

=>
company
diveintocode
ceo
noro 
```
`each`メソッドを使うことでhashの中身を繰り返しで取得します。
取得したものは`|key, value|`のようにブロック変数に`キー`、`値`の順に値を渡して処理に使用することができます。

* キー一覧の取得
```rb
hash = {'company'=>'diveintocode', 'ceo'=>'noro'}
=> {"company"=>"diveintocode", "ceo"=>"noro"}
hash.keys
=> ["company", "ceo"]
```
`keys`メソッドを使うことでキーの一覧を取得することができます。キーを選択することで値を出力させるような処理を作成する際に役立ちます。

## Ruby on Railsでのハッシュ
Ruby on Railsでもハッシュはよく使われています。
際たる例としては`params`があります。
例として投稿者の名前(name)とタイトル、内容を入力できるブログでブログを作成した際の`params`を見てみましょう。
```rb
params
=>{"utf8"=>"✓", "authenticity_token"=>"token文字列", "blog"=>{"name"=>"kimura", "title"=>"初登校", "content"=>"やったぜ"}, "commit"=>"Create Blog", "controller"=>"blogs", "action"=>"create"}
```

`params`の中身はこのように色々値がはいっています。
ここでblogの内容を取り出したいとなったら`params['blog']`とすれば取得できるわけです。

```rb
params['blog']
=> {"name"=>"kimura", "title"=>"初登校", "content"=>"やったぜ"}
```
このように入力された値を取得できます。
ハッシュの操作を覚えておくことでRuby on Railsでも`params`の操作などを行うことができるようになります。
