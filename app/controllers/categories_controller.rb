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
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(request_params)

    if @category.save
      redirect_to categories_path
    else
      flash.now[:alert] =  @category.errors.first.full_message
      render :new
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(request_params)
      flash[:notice] = I18n.t('messages.updated')
      redirect_to categories_path
    else
      flash.now[:alert] =  @category.errors.first.full_message
      render :edit
    end
  end

  def destroy
    @category = Category.find(params[:id])
    if @category.destroy
      flash[:notice] = I18n.t('messages.destroyed')
      redirect_to categories_path
    else
      flash.now[:alert] =  @category.errors.first.full_message
    end
  end

  private

  def request_params
    params.require(:category).permit(:name_ja, :name_en, :description)
  end
end
