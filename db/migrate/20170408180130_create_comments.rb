class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.integer :star
      t.integer :customer_id
      t.integer :product_id

      t.timestamps null: false
    end
  end
end
