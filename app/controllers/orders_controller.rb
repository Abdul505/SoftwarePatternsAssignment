class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :authorise

  # GET /orders
  # GET /orders.json
  def index
    if @current_customer.admin?
      # Show all orders to the admin
      @orders = Order.all.paginate(page: params[:page], per_page: 15)
    else
      # show user's order only
      @orders = Order.where(customer: @current_customer.id).paginate(page: params[:page], per_page: 15)
    end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)
    @order.add_lineitem_from_cart(current_cart)
    @order.customer_id = @current_customer.id
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
