ailsのルーティングを学ぶ

前回（[ルーティングを学ぶ(基礎編)]()）はRuby on Railsにおけるルーティングの基礎に触れ、resourcesで生成されるルーティングなどを見てきました。

今回はルーティングを生成するのに便利なオプション`member`、`collection`を学んでいきます。

## resourcesのルーティング再確認

```rb
Rails.application.routes.draw do
  resources :blogs
end
```
上記のようにルーティングを設定すると

| ルーティング | アクション | HTTPメソッド | 説明 |
| --- | --- | --- | --- |
| /blogs(.:format) | index | GET | 一覧画面生成 |
| /blogs(.:format) | create | POST | 登録 |
| /blogs/new(.:format) | new | GET | 登録画面生成 |
| /blogs/:id/edit(.:format) | edit|GET| 編集画面生成 |
| /blogs/:id(.:format) | show | GET | 詳細画面生成 |
| /blogs/:id(.:format) | update | PUT | 更新 |
| /blogs/:id(.:format) | destroy | DELETE | 削除 |

7つのルーティングが一気にできます。

ただこの7つのルーティングの役割ではないルーティングを作成したい！という場合がでてきます。  
その場合に`collection`や`member`が役に立ちます。

## collection
例えばblogの検索ページを表示するようなルーティングを作りたいといった場合に`collection`が有効です。

早速ルーティングを記載してみます。

```rb
Rails.application.routes.draw do
  resources :blogs do
    get :search, on: :collection
  end
end
```

この状態で`rake routes`をしてみると

```
      Prefix Verb   URI Pattern               Controller#Action
search_blogs GET    /blogs/search(.:format)   blogs#search
       blogs GET    /blogs(.:format)          blogs#index
             POST   /blogs(.:format)          blogs#create
    new_blog GET    /blogs/new(.:format)      blogs#new
   edit_blog GET    /blogs/:id/edit(.:format) blogs#edit
        blog GET    /blogs/:id(.:format)      blogs#show
             PATCH  /blogs/:id(.:format)      blogs#update
             PUT    /blogs/:id(.:format)      blogs#update
             DELETE /blogs/:id(.:format)      blogs#destroy
```

`resources`で生成されるルーティングの他に

```
search_blogs GET    /blogs/search(.:format)   blogs#search
```
というルーティングができていると思います。
こうすることでblogを検索できるような画面へのルーティングができました。
このようにidの指定をしないような基本CRUD以外のルーティングを設定したい場合は`collection`でルーティングを設定します。

## member
例えば特定のblogをお気に入りにできるような機能をつけたいとなった時には`member`が有効です。

```rb
Rails.application.routes.draw do
  resources :blogs do
    get :favorite, on: :member
  end
end
```

この状態で`rake routes`してみると

```
       Prefix Verb   URI Pattern                   Controller#Action
favorite_blog GET    /blogs/:id/favorite(.:format) blogs#favorite
        blogs GET    /blogs(.:format)              blogs#index
              POST   /blogs(.:format)              blogs#create
     new_blog GET    /blogs/new(.:format)          blogs#new
    edit_blog GET    /blogs/:id/edit(.:format)     blogs#edit
         blog GET    /blogs/:id(.:format)          blogs#show
              PATCH  /blogs/:id(.:format)          blogs#update
              PUT    /blogs/:id(.:format)          blogs#update
              DELETE /blogs/:id(.:format)          blogs#destroy
```

`resources`で生成されるルーティングの他に

```
favorite_blog GET    /blogs/:id/favorite(.:format) blogs#favorite
```

というルーティングが出来ています。
これで特定のblogをお気に入りにできるルーティングができました。
このように`member`を用いることで`特定のリソースに対するアクション(idを指定するようなアクション)`のルーティングを作成することができます。

## collection, memberをまとめて設定
上記の`member`、`collection`の例では一つのルーティングだけに設定できるように`on: :collection`、`on: :member`を用いて設定しましたが、下記のように記載すると二つ以上の`collection`、`member`のルーティングをまとめて設定できます。

```rb
Rails.application.routes.draw do
  resources :blogs do
    collection do
      get :search
      get :ranking
    end
    
   　member do
    　　get :favorite
    　　get :preview
  　　　end
  end
end
```

上記のように設定すると
```
       Prefix Verb   URI Pattern                   Controller#Action
 search_blogs GET    /blogs/search(.:format)       blogs#search
ranking_blogs GET    /blogs/ranking(.:format)      blogs#ranking
favorite_blog GET    /blogs/:id/favorite(.:format) blogs#favorite
 preview_blog GET    /blogs/:id/preview(.:format)  blogs#preview
```
resourcesで生成されるルーティングの他に`collection`、`member`で設定したルーティングが生成されます。

このように`collection do 〜 end`、`member do 〜 end`の中に設定したいルーティングを設定することで`collection`や`member`で設定したいルーティングを一気に設定することができます。

`collection`や`member`を使わなくてもルーティングは設定することができますが、Ruby on Railsが提供している機能を使用することでRESTfulなルーティングを作っていくことができるので積極的に使用していきましょう。

次回は`namespace`について記載していきます。
