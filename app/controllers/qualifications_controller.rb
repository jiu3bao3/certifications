class QualificationsController < ApplicationController
  def index
    @qualifications = Qualification.includes(%i[category]).all
  end

  def show
    @qualification = Qualification.includes(:category).find(params[:id])
    @grades = @qualification.grades&.includes(%i[certificater examiner]).order(:display_order)
  end

  def new
    @qualification = Qualification.new
  end

  def create
    @qualification = Qualification.new(request_params)

    if @qualification.save
      flash[:notice] = '登録しました。'
      redirect_to edit_qualification_path(@qualification)
    else
      flash.now[:notice] = @qualification.errors.first.full_message
      render :new
    end
  end

  def edit
    @qualification = Qualification.find(params[:id])
  end

  def update
    @qualification = Qualification.find(params[:id])
    if @qualification.update(request_params)
      flash[:notice] = '更新しました。'
      redirect_to edit_qualification_path(@qualification)
    else
      flash.now[:notice] = @qualification.errors.first.full_message
      render :edit
    end
  end

  def destroy
    Qualification.destroy(params[:id])

    flash[:notice] = '削除しました。'
    redirect_to qualifications_path
  end

  private

  def request_params
    params.require(:qualification).permit(%i[id name_ja name_en category_id classification description])
  end
end
