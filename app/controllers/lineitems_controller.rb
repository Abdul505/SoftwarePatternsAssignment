require 'Logger'
class LineitemsController < ApplicationController
  before_action :current_cart, only: [:create]
  before_action :set_lineitem, only: [:show, :edit, :update, :destroy]

  # GET /lineitems
  # GET /lineitems.json
  def index
      @lineitems = Lineitem.all
      #Use of logger class to log messages into the log file
      Logger.instance.log(Time.now.to_s + ": Product viewed in cart by user \n")
  end

  # GET /lineitems/1
  # GET /lineitems/1.json
  def show
  end

  # GET /lineitems/new
  def new
    @lineitem = Lineitem.new
  end

  # GET /lineitems/1/edit
  def edit
  end

  # POST /lineitems
  # POST /lineitems.json
  def create
    product = Product.find (params[:product_id])
      @lineitem = @cart.add_product(product.id)
      #Use of logger class to log messages into the log file
      Logger.instance.log(Time.now.to_s + ": Product added to cart by user \n")

      respond_to do |format|
        if @lineitem.save
          format.html { redirect_to @cart}
          format.json { render action: 'show', status: :created, location: @lineitem }
        else
          format.html { render action: 'new' }
          format.json { render json: @lineitem.errors, status: :unprocessable_entity }
        end
  end
  end

  # PATCH/PUT /lineitems/1
  # PATCH/PUT /lineitems/1.json
  def update
    respond_to do |format|
      if @lineitem.update(lineitem_params)
        format.html { redirect_to @lineitem, notice: 'Lineitem was successfully updated.' }
        format.json { render :show, status: :ok, location: @lineitem }

        #Use of logger class to log messages into the log file
        Logger.instance.log(Time.now.to_s + ": Product updated in cart by user \n")
      else
        format.html { render :edit }
        format.json { render json: @lineitem.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lineitems/1
  # DELETE /lineitems/1.json
  def destroy
    @lineitem.destroy
     flash[:danger] =  'Lineitem was successfully destroyed.'
      #Use of logger class to log messages into the log file
      Logger.instance.log(Time.now.to_s + ": Product destroyed from cart by user \n")
      redirect_to lineitems_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lineitem
     @lineitem = Lineitem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lineitem_params
      params.require(:lineitem).permit(:cart_id, :product_id, :quantity)
    end
end
