class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :l_name
      t.string :f_name
      t.string :email
      t.string :address
      t.string :city
      t.string :country
      t.string :password_digest
      t.boolean :admin

      t.timestamps null: false
    end
  end
end
