class CreateCars < ActiveRecord::Migration[7.1]
  def change
    create_table :cars do |t|
      t.string :name
      t.text :description
      t.integer :deposit
      t.integer :finance_fee
      t.integer :option_to_purchase_fee
      t.integer :total_amount_payable
      t.integer :duration
      t.boolean :removed

      t.timestamps
    end
  end
end
