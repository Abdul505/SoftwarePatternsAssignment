class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :product_name
      t.string :product_pic
      t.text :description
      t.string :colour
      t.string :size
      t.integer :price
      t.string :product_number
      t.integer :quantity

      t.timestamps null: false
    end
  end
end
