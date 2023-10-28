class RenamePasswordColumnInUsers < ActiveRecord::Migration[7.1]
  def change
    rename_column :users, :password, :password_digest
  end
end
