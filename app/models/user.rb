class User < ApplicationRecord
  has_one :profile, dependent: :destroy

  authenticates_with_sorcery!

  # 必要に応じて、関連付けを追加します
  # 例: has_many :posts, dependent: :destroy

  # パスワードに関するバリデーション
  validates :password, length: { minimum: 6 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :reset_password_token, presence: true, uniqueness: true, allow_nil: true
  # メールアドレスの一意性と存在を検証
  validates :email, uniqueness: true, presence: true

  # その他の属性に関するバリデーション
  # 例: validates :name, presence: true, length: { maximum: 255 }

  # 列挙型の使用（必要に応じて）
  # 例: enum role: { general: 0, admin: 1 }
end
