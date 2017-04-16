class AddLevelToCustomer < ActiveRecord::Migration
  def change
    add_column :customers, :level, :string
  end
end
