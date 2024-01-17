class PagesController < ApplicationController
  # ログイン要求をスキップ
  skip_before_action :require_login

  def terms
    # 利用規約ページ用のアクション
  end

  def privacy_policy
    # プライバシーポリシー用のアクション
  end

  def contact
    # お問い合わせページ用のアクション
  end
end
