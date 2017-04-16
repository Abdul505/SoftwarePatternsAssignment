class AddDiscountToCustomer < ActiveRecord::Migration
  def change
    add_column :customers, :discount, :integer
  end
end
