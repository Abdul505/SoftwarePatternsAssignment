class SessionsController < ApplicationController
  def new
  end

  def create
	  customer = Customer.find_by(email: params[:session][:email].downcase)
	  if customer && customer.authenticate(params[:session][:password])
		  session[:customer_id] = customer.id
		  flash[:success] = "Welcome back"
		  redirect_to root_path
	  else
		  flash[:danger] = "Invalid email / password "
		  render'new'
	  end
  end

  def destroy
    flash[:info] = "See you soon, Looking forward having you back"

	  if signed_in?
		  session[:customer_id] = nil
	  else
		  flash[:info] = "You need to sign in"
	  end
	  redirect_to root_path
  end
end
