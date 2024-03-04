class Comment < ApplicationRecord
  # commentモデルをuserモデルとlibraryモデルへ関連付け
  belongs_to :user
  belongs_to :library

  # enum定義
  enum comments_seats_number: {
    comments_seats_none: 0,        # 0席
    comments_seats_small: 1,       # 1〜20席
    comments_seats_medium: 2,      # 21〜50席
    comments_seats_large: 3,       # 51〜100席
    comments_seats_extra_large: 4, # 101席〜以上
    comments_seats_unknown: 5      # わからない
  }

  enum comments_pc_available: {
    comments_pc_unavailable: 0,  # PC利用不可
    comments_pc_available: 1,    # PC利用可能
    comments_pc_unknown: 2       # わからない
  }

  enum comments_wifi_available: {
    comments_wifi_unavailable: 0, # WiFi利用不可
    comments_wifi_available: 1,   # WiFi利用可能
    comments_wifi_unknown: 2      # わからない
  }

  enum comments_power_available: {
    comments_power_unavailable: 0, # 電源利用不可
    comments_power_available: 1,   # 電源利用可能
    comments_power_unknown: 2      # わからない
  }
end
