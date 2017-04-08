class CreateProductCategory < ActiveRecord::Migration
  def change
    create_table :product_categories do |t|
      t.integer :prodcut_id
      t.integer :category_id
    end
  end
end
