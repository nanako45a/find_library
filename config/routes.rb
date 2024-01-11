Rails.application.routes.draw do
  get 'libraries/index'
  get 'libraries/show'
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  get 'password_resets/create'
  get 'password_resets/edit'
  get 'password_resets/update'
  get 'profiles/show'
  get 'profiles/edit'
  get 'profiles/update'
  # リクエストがloginに送信されるとUserSessionsControllerのアクションを呼び出す(ルート名:login_path)
  get 'login', to: 'user_sessions#new', as: :login
  post 'login', to: 'user_sessions#create'

  # リクエストがlogoutに送信されるとUserSessionsControllerのアクションを呼び出す(ルート名:logout_path)
  delete 'logout', to: 'user_sessions#destroy'

  # パスワードリセット機能用のルート
  resources :password_resets, only: %i[new create edit update]

  # ユーザー登録機能用のルート（ルート名:new_user_path,users_path）
  resources :users, only: [:new, :create]

  # プロフィール画面用のルート
  resource :profile, only: [:show, :edit, :update]

  # 図書館一覧画面のルート
  resources :libraries, only: [:index, :show]

  # ルートパスの定義
  root "top#index"

  # 他のルート設定...
end
