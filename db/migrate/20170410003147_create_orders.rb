class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :paymethod
      t.integer :total
      t.integer :customer_id

      t.timestamps null: false
    end
  end
end
