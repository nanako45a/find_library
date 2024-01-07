Rails.application.routes.draw do
  # リクエストがloginに送信されるとUserSessionsControllerのアクションを呼び出す(ルート名:login_path)
  get 'login', to: 'user_sessions#new', as: :login
  post 'login', to: 'user_sessions#create'

  # deleteリクエストがlogoutに送信されるとUserSessionsControllerのdestroyアクションを呼び出す(ルート名:logout_path)
  delete 'logout', to: 'user_sessions#destroy', as: :logout

  # パスワードリセット機能用のルート
  resources :password_resets, only: %i[new create edit update]

  # ユーザー登録機能用のルート（ルート名:new_user_path,users_path）
  resources :users, only: [:new, :create]

  # ルートパスの定義
  root "top#index"

  # 他のルート設定...
end
