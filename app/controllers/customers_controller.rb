require 'Logger'
class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]
  before_action :authorise, only: [:update, :edit, :show]
  before_action :require_admin, only: [:destroy, :index]

  # GET /customers
  # GET /customers.json
  def index
    @customers = Customer.paginate(page: params[:page], per_page: 10)
    #Use of logger class to log messages into the log file
    Logger.instance.log(Time.now.to_s + ": Customers viewed by Admin \n")
  end

  # GET /customers/1
  # GET /customers/1.json
  def show
    # decoreted the user name by using the decorate pattern
     @customer = Customer.find(params[:id]).decorate
     #Use of logger class to log messages into the log file
     Logger.instance.log(Time.now.to_s + ": Customer viewed by user and admin \n")
     #@user = User.find(params[:id]).decorate
    #  @cinemas = Cinema.near(@customer.address, 10, :order => :distance, :units => :km)
  end

  # GET /customers/new
  def new
    @customer = Customer.new
    #Use of logger class to log messages into the log file
    Logger.instance.log(Time.now.to_s + ": Customer about to sign up \n")
  end

  # GET /customers/1/edit
  def edit
  end

  # POST /customers
  # POST /customers.json
  def create
    @customer = Customer.new(customer_params)
      if @customer.save
        flash[:success] = "Customer was successfully created"
        #Use of logger class to log messages into the log file
        Logger.instance.log(Time.now.to_s + ": Customer created \n")
        render'show'
      else
        render'new'
      end
  end

  # PATCH/PUT /customers/1
  # PATCH/PUT /customers/1.json
  def update
      if @customer.update(customer_params)
          flash[:success] = "Customer was successfully updated"

          #Use of logger class to log messages into the log file
          Logger.instance.log(Time.now.to_s + ": Customer was updated \n")
          render 'show'
      else
        render 'new'
      end
  end

  # DELETE /customers/1
  # DELETE /customers/1.json
  def destroy
    @customer.destroy
    flash[:danger] = "Customer was successfully deleted"
    #Use of logger class to log messages into the log file
    Logger.instance.log(Time.now.to_s + ": Customer has been destroyed \n")
    redirect_to root_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_params
      params.require(:customer).permit(:l_name, :f_name, :email, :address, :city, :country, :password, :password_confirmation, :admin, :latitude, :longitude)
    end

    def require_admin
	  if !signed_in? || (signed_in? and !@current_customer.admin?)
		  flash[:danger] = "Only admins can perform that action"
		  redirect_to products_path
	  end
  end
end
