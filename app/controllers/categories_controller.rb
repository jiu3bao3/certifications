class CategoriesController < ApplicationController
  def index
    @categories = Category.all
    respond_to do |format|
      format.html { render index: @categories }
      format.json { render json: @categories }
    end
  end

  def show
    @category = Category.find(params[:id])
    respond_to do |format|
      format.html { render index: @category }
      format.json { render json: @category }
    end
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(request_params)

    if @category.save
      respond_to do |format|
        format.html { redirect_to categories_path }
        format.json { render json: @category }
      end
    else
      flash.now[:alert] =  @category.errors.first.full_message
      respond_to do |format|
        format.html { render :new }
        format.json { render json: @category.errors }
      end
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(request_params)
      flash[:notice] = I18n.t('messages.updated')
      respond_to do |format|
        format.html { redirect_to categories_path }
        format.json { render json: @category }
      end
    else
      flash.now[:alert] =  @category.errors.first.full_message
      respond_to do |format|
        format.html { render :edit }
        format.json { render json: { message: @category.errors } }
      end
    end
  end

  def destroy
    @category = Category.find(params[:id])
    if @category.destroy
      flash[:notice] = I18n.t('messages.destroyed')
      respond_to do |format|
        format.html { redirect_to categories_path }
        format.json { render json: { message: I18n.t('messages.destroyed') } }
      end
    else
      respond_to do |format|
        format.html { flash.now[:alert] =  @category.errors.first.full_message }
        format.json { render json: { message: @category.errors }}
      end
    end
  end

  private

  def request_params
    params.require(:category).permit(:name_ja, :name_en, :description)
  end
end
