class AddImageToCars < ActiveRecord::Migration[7.1]
  def change
    add_column :cars, :image, :string
  end
end
