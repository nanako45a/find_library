class Library < ApplicationRecord
  mount_uploader :img, ImageUploader

  # 図書館名と都道府県名のフィールドが空でないことを確認
  validates :name, presence: true
  validates :prefecture, presence: true

  # Userモデルとの関連付けを追加
  belongs_to :user

  def self.search(name, prefecture, study_rooms, holiday)
    libraries = all
    libraries = libraries.where("name ILIKE ?", "%#{name}%") if name.present?
    libraries = libraries.where(prefecture: prefecture) if prefecture.present?
    libraries = libraries.where(study_rooms: study_rooms) unless study_rooms.blank?
    libraries = libraries.where("holiday ILIKE ?", "%#{holiday}%") if holiday.present?
    libraries
  end

  def self.unique_prefectures
    select(:prefecture).distinct.map(&:prefecture)
  end

  def self.unique_library_names
    select(:name).distinct.order(:name).map(&:name)
  end
end
