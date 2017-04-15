require 'Logger'
class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :authorise, except: [:show, :index]
  before_action :require_admin, only: [:new, :edit, :update, :destroy]

  # GET /products
  # GET /products.json
  def index
    @products = Product.paginate(page: params[:page], per_page: 12)
    #Use of logger class to log messages into the log file
    Logger.instance.log(Time.now.to_s + ": Product viewed by user \n")
  end

  def search
      @products = Product.paginate(page: params[:page], per_page: 12).search params[:query]
      unless @products.empty?
        #Use of logger class to log messages into the log file
        Logger.instance.log(Time.now.to_s + ": Product searched by user \n")
        render 'index'
      else
        flash[:danger] = "NO Products Were Found !"
        @product = Product.all
        #Use of logger class to log messages into the log file
        Logger.instance.log(Time.now.to_s + ": Product not found to user \n")
        render 'index'

      end
  end
  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
    #Use of logger class to log messages into the log file
    Logger.instance.log(Time.now.to_s + ": new Product coming soon \n")
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)
    if  @product.save
     	flash[:success] = "Product was successfully created"

      #Use of logger class to log messages into the log file
      Logger.instance.log(Time.now.to_s + ": Product created by admin \n")

     	redirect_to  product_path(@product)
    else
      render 'new'
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    if @product.update(product_params)
      flash[:success] = "Product was successfully updated"
      #Use of logger class to log messages into the log file
      Logger.instance.log(Time.now.to_s + ": Product updated \n")
      redirect_to product_path(@product)
    else
      render 'edit'
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
 	  flash[:danger] =  "Product was successfully deleted"
    #Use of logger class to log messages into the log file
    Logger.instance.log(Time.now.to_s + ": Product destroyed \n")
 	  redirect_to products_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:product_name, :product_pic, :description, :colour, :size, :price, :product_number, :quantity, category_ids: [])
    end

    def require_admin
    	if !signed_in? || (signed_in? and !@current_customer.admin?)
      	flash[:danger] = "Only admins can perform that action"
      	redirect_to products_path
    	end
   end
end
