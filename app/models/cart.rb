class Cart < ActiveRecord::Base

  has_many :lineitems
  
  def add_product(product_id)
		current_item = lineitems.find_by_product_id(product_id)
		if current_item
			current_item.quantity += 1
		else
			current_item = lineitems.new(product_id: product_id)
			current_item.quantity = 1
		end
		current_item
	end
end
