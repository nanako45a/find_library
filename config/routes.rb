Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  # ユーザー登録機能用のルート（ルート名:new_user_path, users_path）
  resources :users, only: [:new, :create]

  # ログイン・ログアウト機能用のルート（ルート名:login_path, logout_path）
  get 'login', to: 'user_sessions#new', as: :login
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  # パスワードリセット機能用のルート
  resources :password_resets, only: %i[new create edit update]

  # プロフィール画面用のルート
  resource :profile, only: [:show, :edit, :update]

  # 図書館ごとにブックマークやコメントを作成・削除するためのルート
  resources :libraries do
    resources :bookmarks, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end

  # 投稿機能用のルート（削除予定）
  resources :posts, only: [:index, :show, :new, :create, :edit, :update, :destroy]

  # ルートパスの定義
  root "top#index"

  # 利用規約ページ用のルート
  get 'terms', to: 'pages#terms', as: :terms

  # プライバシーポリシーページ用のルート
  get 'privacy_policy', to: 'pages#privacy_policy', as: :privacy_policy

  # お問い合わせページ用のルート
  get 'contact', to: 'pages#contact', as: :contact
end
