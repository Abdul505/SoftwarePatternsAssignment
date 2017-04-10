json.extract! order, :id, :paymethod, :total, :customer_id, :created_at, :updated_at
json.url order_url(order, format: :json)
