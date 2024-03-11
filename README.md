# サービス名：「FindLibrary」
[![Image from Gyazo](https://i.gyazo.com/4cb7ee3f023a30db2fe8b72e3da50bca.png)](https://gyazo.com/4cb7ee3f023a30db2fe8b72e3da50bca)

https://cryptic-headland-70938-ab332c316ec4.herokuapp.com/

## サービス概要
「FindLibrary」は自習室のある図書館を手軽に検索できるサービスです。
自習室の有無だけでなく、wifi・電源の有無や座席数などの自習室の詳細情報や、図書館の位置情報も伏せて確認できます。
家以外の場所で、テレワークをしたいときの場所探しにぜひご活用ください。

## このサービスへの思い・作りたい理由
学生時代、図書館の自習室に篭って勉強するのがルーティンになっていました。
社会人となり、新しい街に引っ越してきた際、勉強しようと近くの図書館を調べると自習室自体がないことに衝撃を受けました。
他の市の図書館も調べようと、ホームページに飛んではメモをとり。市によって自習室の有無は様々でした。
そんなとき、もっと手軽に全国の図書館の自習室の情報を検索できないか？と考え、なければ自分の手で作ってみようと思い立ち、このサービスを開発することを決めました。

## ユーザー層について
- 決めたユーザー層：図書館の自習室を利用しているユーザー
- どうしてその層を対象にしたのか：図書館が定休日の日や、自習室が混んでいる場合など、別の図書館の情報を知っていれば状況に応じて場所を選択できるから。

## サービスの利用イメージ
1. 管理者・ユーザー側が自習室の情報を投稿
2. ユーザーは投稿から自習室のある図書館を見つける
3. 追加したい情報があればユーザーがコメントを追加

## ユーザーの獲得について
サービスをtwitter（X）で宣伝することでユーザーの獲得を図る。

## サービスの差別化ポイント・推しポイント
- 検索機能が充実しているところ
- 都道府県別、自習室の有無別に検索できる
- 位置情報を記載し、足を運びやすい場所に位置しているかも伏せて確認することができる

## 実装機能
### MVPリリース
- ユーザー登録機能
- ログイン機能
- ログアウト機能
- パスワードリセット機能
- プロフィール編集機能
- 投稿作成機能
- 投稿編集機能
- 投稿閲覧機能
- 投稿検索機能
- ブックマーク機能★

### 本リリース
- GoogleMap API等を用いた位置情報機能
- コメント機能★
- レコメンド機能★
- 検索画面でのオートコンプリート★

※★はREADMEレビュー以降追加した機能です。

## 技術構成
### 使用技術
| カテゴリ | 技術 |
| --- | --- |
| フロントエンド | TailwindCSS, Javascript, Hotwire (Turbo/Stimulus) |
| バックエンド | Ruby on Rails 7.1.2, Ruby 3.2.2 |
| データベース | PostgreSQL |
| インフラ | Heroku, Amazon S3 |
| API | Google Maps API (Geocoding API, Maps JavaScript API, Places API) |
| その他 | CarrierWave, Mini magick, Letter opener web |

### ER図
[![Image from Gyazo](https://i.gyazo.com/a0f0f8b943f649068de7cde013c5288e.png)](https://gyazo.com/a0f0f8b943f649068de7cde013c5288e)

### 画面遷移図
https://www.figma.com/file/L5U91EVX2ycd0E1gv6tJvb/%E7%84%A1%E9%A1%8C?type=design&node-id=22%3A23&mode=design&t=qXcNytzqvCZmnfOh-1
