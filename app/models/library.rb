class Library < ApplicationRecord
  # 画像アップロード
  mount_uploader :img, ImageUploader

  # モデル間の関連付け
  has_many :bookmarks, dependent: :destroy
  has_many :users, through: :bookmarks
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

  # クラスメソッド
  # 検索ロジック
  def self.search(name, prefecture, study_rooms, holiday)
    libraries = all
    libraries = libraries.where("name ILIKE ?", "%#{name}%") if name.present?
    libraries = libraries.where(prefecture: prefecture) if prefecture.present?
    libraries = libraries.where(study_rooms: study_rooms.to_i) if study_rooms.present?
    libraries = libraries.where("holiday ILIKE ?", "%#{holiday}%") if holiday.present?
    libraries
  end

  # 都道府県の一意の値を取得
  def self.unique_prefectures
    select(:prefecture).distinct.map(&:prefecture)
  end

  # 図書館名の一意の値を取得
  def self.unique_library_names
    select(:name).distinct.order(:name).map(&:name)
  end
end
