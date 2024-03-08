class User < ApplicationRecord
  authenticates_with_sorcery!

  # CarrierWaveによる画像アップロード機能
  mount_uploader :avatar, ImageUploader

  # ユーザーは1つのプロフィールを所有し、ユーザーが削除された場合は同時に削除
  has_one :profile, dependent: :destroy
  # ユーザーは複数のコメントを所有でき、ユーザーが削除された場合は同時に削除
  has_many :comments, dependent: :destroy
  # 削除予定
  has_many :posts, dependent: :destroy
  # ユーザーは複数のブックマークを所有でき、ユーザーと図書館モデル間の多対多の関係を中間モデルを通じて実現
  has_many :bookmarks, dependent: :destroy
  # ユーザーとブックマークした図書館と関連付け（ブックマーク一覧表示のため）
  has_many :bookmark_libraries, through: :bookmarks, source: :library

  # パスワードに関するバリデーション
  validates :password, length: { minimum: 6 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :reset_password_token, presence: true, uniqueness: true, allow_nil: true

  validates :email, uniqueness: true, presence: true
  validates :name, presence: true, length: { maximum: 255 }

  # ユーザーがブックマークした図書館のリストを返す
  def bookmarked_libraries
    bookmarks.includes(:library).map(&:library)
  end

  # 特定のlibraryをユーザーのブックマークリストに追加
  def bookmark(library)
    bookmark_libraries << library
  end

  # 特定のlibraryをユーザーのブックマークリストから削除
  def unbookmark(library)
    bookmark_libraries.delete(library)
  end

  # 特定のlibraryがユーザーにブックマークされているか判断
  def bookmark?(library)
    bookmark_libraries.include?(library)
  end
end
