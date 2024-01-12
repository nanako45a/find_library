class Library < ApplicationRecord
  # 図書館名と都道府県名のフィールドが空でないことを確認
  validates :name, presence: true
  validates :prefecture, presence: true

  # Userモデルとの関連付けを追加
  belongs_to :user
end
