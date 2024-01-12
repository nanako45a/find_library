class AddUserIdToLibraries < ActiveRecord::Migration[7.1]
  def change
    # librariesテーブルにuser_idカラムを追加
    add_reference :libraries, :user, null: false, foreign_key: true
    # librariesテーブルに以下の情報を追加
    add_column :libraries, :body, :text
    add_column :libraries, :address, :string
    add_column :libraries, :access, :string
    add_column :libraries, :img, :string
    add_column :libraries, :holiday, :string
  end
end
