json.extract! product, :id, :product_name, :product_pic, :description, :colour, :size, :price, :product_number, :quantity, :created_at, :updated_at
json.url product_url(product, format: :json)
