class Product < ActiveRecord::Base

  has_many :lineitems

	has_many :product_categories
	has_many :categories, through: :product_categories
	has_many :comments


	validates :product_name, presence: true
	validates :description, presence: true

	validates :product_number, presence: true, length: {minimum: 3, maximum: 10}
	validates :product_number, uniqueness: { case_sensitive: false }

	validates :price, presence: true

	def self.search(query)
		where("product_name LIKE ? OR description LIKE ? OR product_number LIKE ?", "%#{query}%", "%#{query}%", "%#{query}%")
	end

	SIZES = ["None", "Small", "Medium", "Large", "X-Large"]
	#<%= f.select :size,[['none', 'none'],['small', 'small'],['medium', 'medium'],['large', 'large'],['x-large', 'x-large']] %>

	def average_stars
		comments.average(:stars)
	end
end
