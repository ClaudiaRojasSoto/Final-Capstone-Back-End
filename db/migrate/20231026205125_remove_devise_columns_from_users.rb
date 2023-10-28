class RemoveDeviseColumnsFromUsers < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :email
    remove_column :users, :encrypted_password
    remove_column :users, :reset_password_token
    remove_column :users, :reset_password_sent_at
    remove_column :users, :remember_created_at

  end
end
