require 'Logger'
class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :authorise, only: [:new, :create]
  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
    @product = Product.find params[:product_id]
		@comment = @product.comments.new(comment_params)
		@comment.customer_id = @current_customer.id
		@comment.save

    #Use of logger class to log messages into the log file
    Logger.instance.log(Time.now.to_s + ": Customer made a comment \n")
    if @comment.save
      flash[:success] = "You have just commented below"
      render "products/show"
    else
      render 'new'
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
        #Use of logger class to log messages into the log file
        Logger.instance.log(Time.now.to_s + ": admin updated a comment \n")
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to comments_url, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
      #Use of logger class to log messages into the log file
      Logger.instance.log(Time.now.to_s + ": admin destroyed a comment \n")
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:content, :star, :customer_id, :product_id)
    end
end
