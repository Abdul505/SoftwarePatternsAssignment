require 'Logger'
class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  before_action :require_admin, except: [:index, :show]

  # GET /categories
  # GET /categories.json
  def index
    @categories = Category.paginate(page: params[:page], per_page: 10)
    #Use of logger class to log messages into the log file
    Logger.instance.log(Time.now.to_s + ": Category viewed by user \n")
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
    @category = Category.find(params[:id])
    @category_products = @category.products.paginate(page: params[:page], per_page: 10)
    #Use of logger class to log messages into the log file
    Logger.instance.log(Time.now.to_s + ": Category viewed by user \n")
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
    @category = Category.find(params[:id])
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "Category was created successfully"
      #Use of logger class to log messages into the log file
      Logger.instance.log(Time.now.to_s + ": Category created by user \n")
      redirect_to categories_path
    else
      render 'new'
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    @category = Category.find(params[:id])
      if @category.update(category_params)
        flash[:success] = "Category name was successfully updated"
        #Use of logger class to log messages into the log file
        Logger.instance.log(Time.now.to_s + ": Category updated by user \n")
        redirect_to category_path(@category)
      else
        render 'edit'
      end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to categories_url, notice: 'Category was successfully destroyed.' }
      format.json { head :no_content }
      #Use of logger class to log messages into the log file
      Logger.instance.log(Time.now.to_s + ": Category destroyed by user \n")
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:name)
    end

    def require_admin
    if !signed_in? || (signed_in? and !@current_customer.admin?)
      flash[:danger] = "Only admins can perform that action"
      redirect_to categories_path
    end
  end
end
