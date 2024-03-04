class CreateComments < ActiveRecord::Migration[7.1]
  def change
    create_table :comments do |t|
      t.timestamps
      t.text :comments_body
      t.integer :comments_seats_number
      t.integer :comments_pc_available
      t.integer :comments_wifi_available
      t.integer :comments_power_available
      t.references :library, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
    end
  end
end
