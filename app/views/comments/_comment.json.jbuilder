json.extract! comment, :id, :content, :star, :customer_id, :product_id, :created_at, :updated_at
json.url comment_url(comment, format: :json)
