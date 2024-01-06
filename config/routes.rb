Rails.application.routes.draw do
  # セッション管理用のルート
  get 'login', to: 'user_sessions#new', as: :login
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy', as: :logout

  # パスワードリセット機能用のルート
  resources :password_resets, only: %i[new create edit update]

  # ユーザー登録機能用のルート
  resources :users, only: [:new, :create]

  # ルートパスの定義
  root "top#index"

  # 他のルート設定...
end
