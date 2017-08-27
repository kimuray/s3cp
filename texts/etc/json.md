jsonとは
jsonを使うのはweb apiサーバーを使うのがrailsでは多いかと思います。
できることとしてはサーバ上にたくさんのデータを貯めておきそれをiphoneやandroindのアプリで受け取ることができます。
異なったosで受け取ることができるので開発が楽になります。
データとしては

```
{"id":1,"name":"tarou","created_at":"2016-10-20T07:37:47.482Z","updated_at":"2016-10-20T07:37:47.482Z"}
```
このようなデータが取得できます。jsonで受けとることによってPHPやrubyといった言語を問わず決まった型のデータを受けるとこができます。今回はユーザの一覧を表示する簡単なアプリケーションを作成します。
Gemfileの中身

```
gem 'rails'

gem 'rails-api'

gem 'sqlite3'
```
コントローラの構成は
controllers/api/v1といったバージョンを管理できるようにするのが多いようです。

```
module Api
  module V1
    def index
        @users = User.all
        render json: @users
      end
  end
end
```

一応これだけでもデータは帰りますが不要なものは省きたくデータを操作していきます。
```
gem “jbuilder”
```
jbuilderを入れることによってjsonデータを操作しやすくなります。これはviewファイルに配置します。
```
json.users do |json|
  @users.each do |user|
    json.name user.name
  end
end
```

いつもの流れでこのように記述してしまうと返ってくるデータが

```
{"users":{"name":"9さん"}}

```

このようになってしまいます（実際は10人ユーザがいます。)
なので、

```
json.users do |json|
  json.array!(@users) do |user|
    json.name user.name
  end
end
```

このようにarray!を指定することによってコントローラから渡されたデータをすべて展開することができます。

データ型だけ渡したい時

```
@user = User.new
json.users do |json|
  json.extract! @user, :id, :name
end
```

入力フォームを作る時とかに使えそうですね。
active recordのattributeを返してくれるようなのでUser.newでもいけました。
githubが一番わかりやすいですね
