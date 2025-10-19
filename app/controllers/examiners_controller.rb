class ExaminersController < ApplicationController
  def index
    @examiners = Examiner.all
    respond_to do |format|
      format.html { render index: @examiners }
      format.json { render json: @examiners }
    end
  end

  def show
    @examiner = Examiner.find(params[:id])
    respond_to do |format|
      format.html { render show: @examiner }
      format.json { render json: @examiner }
    end
  end

  def new
    @examiner = Examiner.new
  end

  def create
    @examiner = Examiner.new(request_params)
    if @examiner.save
      respond_to do |format|
        format.html { redirect_to examiners_path }
        format.json { render json: @examiner }
      end
    else
      flash.now[:alert] = @examiner.errors.first.full_message
      respond_to do |format|
        format.html { render :new }
        format.json { render json: { message: @examiner.errors }, status: :unprocessable_content }
      end
    end
  end

  def edit
    @examiner = Examiner.find(params[:id])
  end

  def update
    @examiner = Examiner.find(params[:id])
    if @examiner.update(request_params)
      flash[:notice] = I18n.t('messages.updated')
      respond_to do |format|
        format.html { redirect_to examiners_path }
        format.json { render json: @examiner }
      end
    else
      flash.now[:alert] = @examiner.errors.first.full_message
      respond_to do |format|
        format.html { render :edit }
        format.json { render json: { message: @examiner.errors }, status: :unprocessable_content }
      end
    end
  end

  def destroy
    @examiner = Examiner.find(params[:id])
    if @examiner.destroy
      flash[:notice] = I18n.t('messages.destroyed')
      respond_to do |format|
        format.html { redirect_to examiners_path }
        format.json { render json: { message: 'Examiner deleted successfully' } }
      end
    else
      respond_to do |format|
        format.html { flash.now[:alert] = @examiner.errors.first.full_message }
        format.json { render json: { message: 'Failed to delete examiner' }, status: :unprocessable_content }
      end
    end
  end

  private

  def request_params
    params.require(:examiner).permit(:name, :corporate_number, :zipcode, :address, :url, :tel)
  end
end
