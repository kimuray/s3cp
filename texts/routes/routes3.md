ailsのルーティングを学ぶ(最終回)

前々回（[ルーティングを学ぶ(基礎編)]()）はRuby on Railsにおけるルーティングの基礎に触れ、resourcesで生成されるルーティング、前回([ルーティングを学ぶ(基礎編)]())ではresourcesで生成されるルーティング以外のルーティングを作るためのcollectionとmemberを学びました。

「Railsのルーティングを学ぶ」最終回となる今回は`namespace`使ったルーティングの生成を見ていきます。

## namespaceとは
Ruby on Railsのルーティングを作成するとき`namespace`を使うと指定したルーティングの配下にルーティングを設定することができます。

早速実例を見ていきましょう。

```rb
Rails.application.routes.draw do
  namespace :hoge do
    resources :blogs
  end
end
```

このようなルーティングを設定して、`rake routes`を実行してみると

```
        Prefix Verb   URI Pattern                    Controller#Action
    hoge_blogs GET    /hoge/blogs(.:format)          hoge/blogs#index
               POST   /hoge/blogs(.:format)          hoge/blogs#create
 new_hoge_blog GET    /hoge/blogs/new(.:format)      hoge/blogs#new
edit_hoge_blog GET    /hoge/blogs/:id/edit(.:format) hoge/blogs#edit
     hoge_blog GET    /hoge/blogs/:id(.:format)      hoge/blogs#show
               PATCH  /hoge/blogs/:id(.:format)      hoge/blogs#update
               PUT    /hoge/blogs/:id(.:format)      hoge/blogs#update
               DELETE /hoge/blogs/:id(.:format)      hoge/blogs#destroy
```

上記のようなルーティングが作成されます。
作成されたルーティングを見ると`resources :blogs`だけでルーティングを設定した時とは違い、ルーティングに`hoge`や`/hoge`が付いています。
このように`namespace :指定したいルーティング do 〜 end`と記載すると指定したいルーティングがnamespaceの中で記載したルーティングに付与されるようになります。

ルーティングをグルーピングしたい際などに`namespace`を用いることでルーティングをいい感じに設定することができます。

## namespace使用シーン
`namespace`の利用方法として多いのは管理画面のルーティングを作成する際によく用いられることがあります。

```rb
Rails.application.routes.draw do
  namespace :admin do
    resources :blogs
    resources :users
    ...
  end
end
```

上記のようなadminのnamespaceを切って、namespaceの中に開発しているWebアプリケーションのリソースのルーティングをどんどん入れていって管理画面でDBのCRUD処理をできるようにするルーティングを作成するといったケースは多いと思います。

## namespace以外でルーティングを指定
ルーティングをグルーピングする機能として`namespace`以外にも`scope`と`scope module`があります。

それぞれの作成されるルーティングを見てみましょう。

###scope
```rb
Rails.application.routes.draw do
  scope :hoge do
    resources :blogs
  end
end
```

```
   Prefix Verb   URI Pattern                    Controller#Action
    blogs GET    /hoge/blogs(.:format)          blogs#index
          POST   /hoge/blogs(.:format)          blogs#create
 new_blog GET    /hoge/blogs/new(.:format)      blogs#new
edit_blog GET    /hoge/blogs/:id/edit(.:format) blogs#edit
     blog GET    /hoge/blogs/:id(.:format)      blogs#show
          PATCH  /hoge/blogs/:id(.:format)      blogs#update
          PUT    /hoge/blogs/:id(.:format)      blogs#update
          DELETE /hoge/blogs/:id(.:format)      blogs#destroy
```

`scope`でルーティングを設定するとURI Patternだけに`/hoge`が付与されています。

### module
```rb
Rails.application.routes.draw do
  scope module: :hoge do
    resources :blogs
  end
end
```

```
   Prefix Verb   URI Pattern               Controller#Action
    blogs GET    /blogs(.:format)          hoge/blogs#index
          POST   /blogs(.:format)          hoge/blogs#create
 new_blog GET    /blogs/new(.:format)      hoge/blogs#new
edit_blog GET    /blogs/:id/edit(.:format) hoge/blogs#edit
     blog GET    /blogs/:id(.:format)      hoge/blogs#show
          PATCH  /blogs/:id(.:format)      hoge/blogs#update
          PUT    /blogs/:id(.:format)      hoge/blogs#update
          DELETE /blogs/:id(.:format)      hoge/blogs#destroy
```
`scope module`でルーティングを指定するとController#Actionのみ`hoge`が付与されます。

`namespace`では`Prefix`、`URI Pattern` 、`Controller#Action`
`scope`では`URI Pattern` のみ
`scope module`と`Controller#Action`のみ

このように指定の仕方で設定されるルーティングの内容が変わってくるので必要な指定の仕方を意識していけば狙ったルーティングを作成できるようになります。

全3回で`Railsのルーティング基礎`、`resources`、`memberとcollection`、`namespace`を学んできました。
この内容を覚えておけばRuby on Railsにおける基本的なルーティングは作成できるようになります。

ただRuby on Railsのルーティングはもっと柔軟に色々な設定ができるオプションなどがあるので、適宜調べて最適な記述方法を身につけていけば、素敵なルーティングを設定できるようになります。

