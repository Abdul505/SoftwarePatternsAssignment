require "AddService"
require 'Logger'
class CartsController < ApplicationController
  before_action :set_cart, only: [:show, :edit, :update, :destroy]

  # GET /carts
  # GET /carts.json
  def index
    @carts = Cart.all
    #Use of logger class to log messages into the log file
    Logger.instance.log(Time.now.to_s + ": Cart viewed by user \n")
  end

  # GET /carts/1
  # GET /carts/1.json
  def show
    @total = 0
    @cart.lineitems.each{|line|
      @total = AddService.call(@total.to_i, line.product.price * line.quantity)
    }
    #Use of logger class to log messages into the log file
    Logger.instance.log(Time.now.to_s + ": Cart viewed by user \n")
  end

  # GET /carts/new
  def new
    @cart = Cart.new
  end

  # GET /carts/1/edit
  def edit
  end

  # POST /carts
  # POST /carts.json
  def create
    @cart = Cart.new(cart_params)

    #Use of logger class to log messages into the log file
    Logger.instance.log(Time.now.to_s + ": Cart created by user \n")

    respond_to do |format|
      if @cart.save
        format.html { redirect_to @cart, success: 'Cart was successfully created.' }
        format.json { render :show, status: :created, location: @cart }
      else
        format.html { render :new }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /carts/1
  # PATCH/PUT /carts/1.json
  def update
    respond_to do |format|
      if @cart.update(cart_params)
        format.html { redirect_to @cart, success: 'Cart was successfully updated.' }
        format.json { render :show, status: :ok, location: @cart }

        #Use of logger class to log messages into the log file
        Logger.instance.log(Time.now.to_s + ": Cart updated by user \n")
      else
        format.html { render :edit }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /carts/1
  # DELETE /carts/1.json
  def destroy
    @cart.destroy if @cart.id == session[:cart_id]
    flash[:success] = "Cart was successfully empty"
    #Use of logger class to log messages into the log file
    Logger.instance.log(Time.now.to_s + ": Cart destroyed by user \n")
    redirect_to products_path
  end
# private class data pattern
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart
      @cart = Cart.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      @cart = Cart.create
      session[:cart_id] = @cart.id
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cart_params
      params.fetch(:cart, {})
    end
end
