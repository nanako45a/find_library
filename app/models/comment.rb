class Comment < ApplicationRecord
  # commentモデルをuserモデルとlibraryモデルへ関連付け
  belongs_to :user
  belongs_to :library
end
