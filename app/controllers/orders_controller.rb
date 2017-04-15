require "AddService"
require 'Logger'
class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :authorise

  # GET /orders
  # GET /orders.json
  def index
    if @current_customer.admin?
      # Show all orders to the admin
      @orders = Order.all.paginate(page: params[:page], per_page: 15)

      #Use of logger class to log messages into the log file
      Logger.instance.log(Time.now.to_s + ": Order viewed by admin \n")
    else
      # show user's order only
      @orders = Order.where(customer: @current_customer.id).paginate(page: params[:page], per_page: 15)
      #Use of logger class to log messages into the log file
      Logger.instance.log(Time.now.to_s + ": Order viewed by user \n")
    end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
    #Use of logger class to log messages into the log file
    Logger.instance.log(Time.now.to_s + ": Order creating by user \n")
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)
    @total = 0
    current_cart.lineitems.each{|line|
      @total = AddService.call(@total.to_i, line.product.price * line.quantity)
    }
    @order.add_lineitem_from_cart(current_cart)
    @order.customer_id = @current_customer.id
    @order.total = @total
    #Use of logger class to log messages into the log file
    Logger.instance.log(Time.now.to_s + ": Order created by user \n")

      if @order.save
        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil
        flash[:success] = 'Thank You for your order.'
        redirect_to root_path
      else
        @cart = current_cart
        render 'new'
      end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
      flash[:danger] = 'Order was successfully destroyed.'
      #Use of logger class to log messages into the log file
      Logger.instance.log(Time.now.to_s + ": Order destroyed by user \n")
      redirect_to root_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:paymethod, :total, :customer_id)
    end
end
