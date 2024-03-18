class Library < ApplicationRecord
  # 画像アップロード
  mount_uploader :img, ImageUploader

  # モデル間の関連付け
  # 図書館は多数のブックマークやコメントを所有でき、図書館が削除された場合ともに削除される
  has_many :bookmarks, dependent: :destroy
  has_many :comments, dependent: :destroy
  # ブックマークモデルが中間モデルとして機能し、ユーザーと図書館モデル間の多対多の関係を実現
  has_many :users, through: :bookmarks
  # 図書館は特定のuserにより作成
  belongs_to :user

  # バリデーション
  # 図書館名と都道府県名のフィールドが空でないことを確認
  validates :name, presence: true
  validates :prefecture, presence: true

  # geocoderの設定
  # 図書館の住所から緯度経度を計算
  geocoded_by :address
  after_validation :geocode

  # enum定義
  enum seats_number: {
    seats_none: 0,        # 0席
    seats_small: 1,       # 1〜20席
    seats_medium: 2,      # 21〜50席
    seats_large: 3,       # 51〜100席
    seats_extra_large: 4, # 101席〜以上
    seats_unknown: 5      # わからない
  }

  enum pc_available: {
    pc_unavailable: 0,  # PC利用不可
    pc_available: 1,    # PC利用可能
    pc_unknown: 2       # わからない
  }

  enum wifi_available: {
    wifi_unavailable: 0, # WiFi利用不可
    wifi_available: 1,   # WiFi利用可能
    wifi_unknown: 2      # わからない
  }

  enum power_available: {
    power_unavailable: 0, # 電源利用不可
    power_available: 1,   # 電源利用可能
    power_unknown: 2      # わからない
  }

  # 検索可能な属性を定義
  def self.ransackable_attributes(auth_object = nil)
    %w[name prefecture study_rooms latitude longitude created_at updated_at]
  end

  # 投稿済みの都道府県、図書館名をフィルタリング
  def self.unique_prefectures
    select(:prefecture).distinct.map(&:prefecture)
  end

  def self.unique_library_names
    select(:name).distinct.order(:name).map(&:name)
  end
end
