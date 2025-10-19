class CertificatersController < ApplicationController
  def index
    @certificaters = Certificater.all
    respond_to do |format|
      format.html { render index: @certificaters }
      format.json { render json: @certificaters }
    end
  end

  def show
    @certificater = Certificater.find(params[:id])
    respond_to do |format|
      format.html { render show: @certificater }
      format.json { render json: @certificater }
    end
  end

  def new
    @certificater = Certificater.new
  end

  def create
    @certificater = Certificater.new(request_params)
    if @certificater.save
      redirect_to certificaters_path
    else
      flash.now[:alert] = @certificater.errors.first.full_message
      render :new
    end
  end

  def edit
    @certificater = Certificater.find(params[:id])
  end

  def update
    @certificater = Certificater.find(params[:id])
    if @certificater.update(request_params)
      flash[:notice] = I18n.t('messages.updated')
      respond_to do |format|
        format.html { redirect_to certificaters_path }
        format.json { render json: @certificater }
      end
    else
      flash.now[:alert] = @certificater.errors.first.full_message
      respond_to do |format|
        format.html { render :edit }
        format.json { render json: { message: @certificater.errors } }
      end
    end
  end

  def destroy
    @certificater = Certificater.find(params[:id])
    if @certificater.destroy
      flash[:notice] = I18n.t('messages.destroyed')
      redirect_to certificaters_path
    else
      flash.now[:alert] = @certificater.errors.first.full_message
    end
  end

  private

  def request_params
    params.require(:certificater).permit(:name_ja, :name_en, :description)
  end
end
