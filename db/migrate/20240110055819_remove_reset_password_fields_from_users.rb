class RemoveResetPasswordFieldsFromUsers < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :reset_password_token if column_exists?(:users, :reset_password_token)
    remove_column :users, :reset_password_token_expires_at if column_exists?(:users, :reset_password_token_expires_at)
    remove_column :users, :reset_password_email_sent_at if column_exists?(:users, :reset_password_email_sent_at)
    remove_column :users, :access_count_to_reset_password_page if column_exists?(:users, :access_count_to_reset_password_page)

    if index_exists?(:users, :reset_password_token)
      remove_index :users, name: "index_users_on_reset_password_token"
    end
  end
end
