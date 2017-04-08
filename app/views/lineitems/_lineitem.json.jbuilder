json.extract! lineitem, :id, :quantity, :cart_id, :product_id, :order_id, :created_at, :updated_at
json.url lineitem_url(lineitem, format: :json)
