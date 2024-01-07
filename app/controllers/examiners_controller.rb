class ExaminersController < ApplicationController
  def index
    @examiners = Examiner.all
  end

  def show
    @examiner = Examiner.find(params[:id])
  end

  def new
    @examiner = Examiner.new
  end

  def create
    @examiner = Examiner.new(request_params)
    if @examiner.save
      redirect_to examiners_path
    else
      flash.now[:alert] = @examiner.errors.first.full_message
      render :new
    end
  end

  def edit
    @examiner = Examiner.find(params[:id])
  end

  def update
    @examiner = Examiner.find(params[:id])
    if @examiner.update(request_params)
      flash[:notice] = I18n.t('messages.updated')
      redirect_to examiners_path
    else
      flash.now[:alert] = @examiner.errors.first.full_message
      render :edit
    end
  end

  def destroy
    @examiner = Examiner.find(params[:id])
    if @examiner.destroy
      flash[:notice] = I18n.t('messages.destroyed')
      redirect_to examiners_path
    else
      flash.now[:alert] = @examiner.errors.first.full_message
    end
  end

  private

  def request_params
    params.require(:examiner).permit(:name, :corporate_number, :zipcode, :address, :url, :tel)
  end
end
