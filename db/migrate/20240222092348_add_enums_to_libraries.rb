class AddEnumsToLibraries < ActiveRecord::Migration[7.1]
  def change
    add_column :libraries, :seats_number, :integer
    add_column :libraries, :pc_available, :integer
    add_column :libraries, :wifi_available, :integer
    add_column :libraries, :power_available, :integer
  end
end
