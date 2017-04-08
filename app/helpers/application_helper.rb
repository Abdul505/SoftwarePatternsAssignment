module ApplicationHelper

  def signed_in?
		if session[:customer_id].nil?
			return
		else
			@current_customer = Customer.find_by_id(session[:customer_id])
		end
	end

  def euro(amount)
		number_to_currency(amount, :unit => '€ ')
	end
  
  def gravatar_for(customer, options = {size: 80})
		gravatar_id = Digest::MD5::hexdigest(customer.email.downcase)
		size = options[:size]
		gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
		image_tag(gravatar_url, alt: customer.email, class: "img-circle")
	end

end
