yzzzzzzzzzzzzzzzzzzzzzzzzz
<!---- deploy info ---->

# Railsのルーティングを学ぶ（基礎編）

Webアプリケーションにはリクエスト(Webアプリケーションへの要求のことで主にURLにアクセスすることでリクエストが発生します。) に対して何を行うか決定するルーティングという仕組みがあります。

Ruby on Railsでは`routes.rb`というファイルにルーティングに関するコードを書いていくことでルーティングを実現させることができます。
この記事ではRuby on Railsのルーティングの基礎的な部分を学んでいきます。


## Ruby on Railsにおけるルーティングの仕組み

まずはリクエストを受け取ってからRuby on Railsの中でどのように処理されているか見ていきましょう。

[![https://diveintocode.gyazo.com/5cad2e3d9437c9755ec9132852aca243](https://t.gyazo.com/teams/diveintocode/5cad2e3d9437c9755ec9132852aca243.png)](https://diveintocode.gyazo.com/5cad2e3d9437c9755ec9132852aca243)

リクエストが送られてくるとまずルーターに遷移します。  
ルーターでは受け取ったリクエストを見て、どのコントローラ(Webアプリケーションの中でどのような処理を行うか管理しているものです。Webアプリケーション内に複数存在しています。)のなんの処理を行うかを決定してくれます。  
銀行で例えるなら「窓口へ案内するお姉さん」です。

つまりルーティングとは受け取ったリクエストを適切なコントローラへ案内させるための「ルール」のことを指します。
ルーティングはRailsアプリケーションの`configディレクトリの中にあるroutes.rb`に記載します。

## ルーティングの書き方

では早速ルーティングを書いてみましょう。
`routes.rb`ファイルの中に以下のコードを記載します。

```rb
Rails.application.routes.draw do
  get 'blogs', to: 'blogs#index'
end
```

書いたルーティングを確認するには`rake routes`というコマンドを実行することで確認できます。

```
Prefix  Verb  URI Pattern       Controller#Action
users   GET   /blogs(.:format)  blogs#index
```
`rake routes`コマンドを実行すると上記のような内容が表示されます。

これは`GET /blogs`というルーティングが作成されて、そこにアクセスすると`blogs_controller`の`index`アクションにある処理を行った結果を画面に表示するようなルーティングを設定していることを表します。
例えば`example.com`というドメインでRuby on Rails製のアプリケーションを導入して上記のようなルーティングが設定されている場合に`http://example.com/blogs`にアクセスするとブログの一覧画面が表示されるという意味合いになります。（indexアクションには何かしらの一覧を表示するような処理を作ることが一般的です。）

Ruby on RailsではRESTという考え方を導入しており、Ruby on Railsの規則に従ってアプリケーションを作成していくとRESTful(RESTに従っていること)なアプリケーションを作ることができます。
ルーティングでも`resources`を用いたルーティングの書き方をするとRESTに従ったルーティングが一気に作成することができます。

```rb
Rails.application.routes.draw do
  resources :blogs
end
```

`rake routes`コマンドでルーティングを確認すると以下のルーティングが作成されます。

```
Prefix    Verb   URI Pattern              Controller#Action
blogs     GET    /blogs(.:format)          blogs#index
          POST   /blogs(.:format)          blogs#create
new_blog  GET    /blogs/new(.:format)      blogs#new
edit_blog GET    /blogs/:id/edit(.:format) blogs#edit
blog      GET    /blogs/:id(.:format)      blogs#show
          PATCH  /blogs/:id(.:format)      blogs#update
          PUT    /blogs/:id(.:format)      blogs#update
          DELETE /blogs/:id(.:format)      blogs#destroy
```

生成されたルーティングの内容としては以下のような内容になります。

ルーティング | アクション | HTTPメソッド | 説明
--- | --- | --- | ---
/blogs(.:format) | index | GET | 一覧画面生成
/blogs(.:format) | create | POST | 登録
/blogs/new(.:format) | new | GET | 登録画面生成
/blogs/:id/edit(.:format) | edit | GET | 編集画面生成
/blogs/:id(.:format) | show | GET | 詳細画面生成
/blogs/:id(.:format) | update | PUT | 更新
/blogs/:id(.:format) | destroy | DELETE | 削除

このようにブログに関するCRUD(C: Create[登録], R: Read[参照], U: Update[更新], D:Delete[削除])処理に関するルーティングが一気にできあがります。  
先ほどしれっと登場したRESTという考え方はリソース(今回の場合はblog)をURLを使って表し、それに対してHTTPメソッドの「GET」「POST」「DELETE」「PUT」を用いて目的の処理を行うという考え方です。  
`resources`を使えば「GET」「POST」「DELETE」「PUT」を使用するルーティングを簡単に生成することができ、意識しなくてもRESTfulなアプリケーションを作成することができます。

基本的にRuby on Railsでは`resources`を活用してルーティングを作成していくことが多いので`resources`で生成されるルーティングは押さえておきたいところです。

次回は`member`や`collection`を使ったルーティングの作成方法を紹介していきたいと思います。
