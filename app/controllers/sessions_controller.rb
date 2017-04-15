require 'Logger'
class SessionsController < ApplicationController
  def new
  end

  def create
	  customer = Customer.find_by(email: params[:session][:email].downcase)
	  if customer && customer.authenticate(params[:session][:password])
		  session[:customer_id] = customer.id

      #Use of logger class to log messages into the log file
      Logger.instance.log(Time.now.to_s + ": Customer logged in \n")

      flash[:success] = "Welcome back"
		  redirect_to root_path
	  else
		  flash[:danger] = "Invalid email / password "

      #Use of logger class to log messages into the log file
      Logger.instance.log(Time.now.to_s + ": Customer could not log in \n")
		  render'new'
	  end
  end

  def destroy
    flash[:info] = "See you soon, Looking forward having you back"
    #Use of logger class to log messages into the log file
    Logger.instance.log(Time.now.to_s + ": Customer logged out \n")
	  if signed_in?
		  session[:customer_id] = nil
	  else
		  flash[:info] = "You need to sign in"
	  end
	  redirect_to root_path
  end
end
