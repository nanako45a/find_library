class CreateLibraries < ActiveRecord::Migration[7.1]
  def change
    create_table :libraries do |t|
      t.string :name, null: false
      t.string :prefecture, null: false
      t.integer :study_rooms
      t.float :latitude
      t.float :longitude

      t.timestamps
    end

    # インデックスの追加（必要に応じて）
    # add_index :libraries, :name
    # add_index :libraries, :prefecture
  end
end
