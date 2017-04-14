class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include ApplicationHelper
    def authorise
      unless signed_in?
        store_location
        flash[:info] = "Please Sign in to get access"
        redirect_to login_path
      end
    end

private
    def store_location
    session[:return_to] = request.fullpath
    end

    def current_cart
		@cart = Cart.find(session[:cart_id])
	rescue ActiveRecord::RecordNotFound
		@cart = Cart.create
		session[:cart_id] = @cart.id
	end
end
