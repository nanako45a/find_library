class AddUserPrefectureAndUserCityToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :user_prefecture, :string
    add_column :users, :user_city, :string
  end
end
