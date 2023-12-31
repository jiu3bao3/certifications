class GradesController < ApplicationController
  def new
    @grade = Grade.new(qualification: Qualification.find(params[:qualification_id]))
  end

  def create
    @grade = Grade.new(request_params)
    @grade.qualification_id = params[:qualification_id]

    if @grade.save
      redirect_to qualification_path(params[:qualification_id])
    else
      flash.now[:error] = @grade.errors.first.full_message
      render :new
    end
  end

  def edit
    @grade = Grade.find(params[:id])
  end

  def update
    @grade = Grade.find(params[:id])
    if @grade.update(request_params)
      redirect_to qualification_path(params[:qualification_id])
    else
      flash.now[:error] = @grade.errors.first.full_message
      render :edit
    end
  end

  def destroy
    @grade = Grade.find(params[:id])
    if @grade.destroy
      flash[:notice] = '削除しました。'
      redirect_to qualification_path(params[:qualification_id])
    else
      flash.now[:error] = @grade.errors.first.full_message
    end
  end

  private

  def request_params
    params.require(:grade).permit(%i[grade_name description display_order examiner_id certificater_id qualification_id])
  end
end

