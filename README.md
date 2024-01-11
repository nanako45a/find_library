# find_library

■サービス概要
家以外の場所で勉強したいと思った時、場所探しに困ったことはありませんか？カフェや飲食店などで勉強すると、お金はかかるし、お店が混んでいると長居はできない。
そんなときに便利なのが、図書館の自習室です。無料で利用でき、かつ自習するためのスペースのため、飲食店とは違い時間を気にせず勉強できる。
このアプリは自習室のある図書館を簡単に検索できるサービスです。

■ このサービスへの思い・作りたい理由
学生時代、図書館の自習室に篭って勉強するのがルーティンになっていました。
社会人となり、新しい街に引っ越してきた際、勉強しようと近くの図書館を調べると自習室自体がないことに衝撃を受けました。
他の市の図書館も調べようと、ホームページに飛んではメモをとり。市によって自習室の有無は様々でした。
そんなとき、もっと手軽に全国の図書館の自習室の情報を検索できないか？と考え、なければ自分の手で作ってみようと思い立ち、このサービスを開発することを決めました。

■ ユーザー層について
決めたユーザー層：図書館の自習室を利用しているユーザー
どうしてその層を対象にしたのか：図書館が定休日の日や、自習室が混んでいる場合など、別の図書館の情報を知っていれば状況に応じて場所を選択できるから。

■ サービスの利用イメージ
1.管理者・ユーザー側が自習室の情報を投稿（自習室の情報は市のホームページ等から取得）
2.ユーザーは投稿から自習室のある図書館を見つける
3.追加したい図書館の情報があればユーザーが投稿を追加する

■ ユーザーの獲得について
サービスをtwitter（X）で宣伝することでユーザーの獲得を図る。

■ サービスの差別化ポイント・推しポイント
検索機能が充実しているところ。
都道府県別、自習室の有無別に検索できる。
また、位置情報を記載し、足を運びやすい場所に位置しているかも伏せて確認することができる。

■ 機能候補
1.ユーザー登録機能:機能確認済み（avatar未）
2.ログイン機能:機能確認済み
3.ログアウト機能:機能確認済み
4.プロフィール編集機能:機能確認済み
5.パスワードリセット機能:機能確認済み
6.投稿作成機能（画像投稿含む）
7.投稿編集機能
8.投稿閲覧機能（未ログインでも閲覧可能）
9.投稿検索機能
10.位置情報機能

■ 機能の実装方針予定
MVPリリースまでに機能候補に記載した機能1~9を満たしたサービスを開発。
その後、地図情報API（GoogleMap API等）を利用し、機能候補10の位置情報機能を追加する。

■ 画面遷移図
https://www.figma.com/file/L5U91EVX2ycd0E1gv6tJvb/%E7%84%A1%E9%A1%8C?type=design&node-id=22%3A23&mode=design&t=qXcNytzqvCZmnfOh-1

■ ER図
https://gyazo.com/2cb89aabc2a5b6df845c5c59a9b6796b

usersテーブル:
t.string "email,crypted_password,salt,name","reset_password_token"
t.datetime "created_at,updated_at","reset_password_token_expires_at,reset_password_email_sent_at"
t.index "email" name: index_users_on_email
t.integer "access_count_to_reset_password_page"

profileテーブル:
t.bigint "user_id"
t.string "name"
t.datetime "created_at,updated_at"
t.index "user_id" name: index_profiles_on_user_id

libraries"テーブル
t.string "name,prefecture"
t.integer "study_rooms"
t.float "latitude,longitude"
t.datetime "created_at,updated_at"

postsテーブル
t.string "title"
t.text "body"
t.bigint "user_id,library_id"
t.datetime "created_at,updated_at"
t.index "library_id", name: "index_posts_on_library_id"
t.index "user_id", name: "index_posts_on_user_id"
