Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  # ユーザー登録機能（ルート名:new_user_path, users_path）
  resources :users, only: [:new, :create]

  # ログイン・ログアウト機能（UserSessionControllerのnew,create,destroyメソッド呼び出し）
  get 'login', to: 'user_sessions#new', as: :login
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  # パスワードリセット機能
  resources :password_resets, only: %i[new create edit update]

  # マイページ画面（getメソッド：show,editアクション,patchメソッド：updateアクション）（profile_path：showアクション、edit_profile_path：editアクションに対応）
  resource :profile, only: [:show, :edit, :update]

  # 図書館投稿機能
  resources :libraries do
    collection do
      get :search
    end
    resources :bookmarks, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end

  # 投稿機能用のルート（削除予定）
  resources :posts, only: [:index, :show, :new, :create, :edit, :update, :destroy]

  # ルートパスの定義
  root "top#index"

  # 利用規約ページ
  get 'terms', to: 'pages#terms', as: :terms

  # プライバシーポリシーページ
  get 'privacy_policy', to: 'pages#privacy_policy', as: :privacy_policy

  # お問い合わせページ
  get 'contact', to: 'pages#contact', as: :contact

end
