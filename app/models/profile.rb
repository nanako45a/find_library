class Profile < ApplicationRecord
  mount_uploader :avatar, ImageUploader

  belongs_to :user
end
