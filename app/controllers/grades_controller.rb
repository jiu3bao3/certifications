class GradesController < ApplicationController
  skip_forgery_protection

  def show
    @grade = Grade.find(params[:id])
    respond_to do |format|
      format.json { render json: @grade.as_json }
    end
  end

  def new
    @grade = Grade.new(qualification: Qualification.find(params[:qualification_id]))
  end

  def create
    @grade = Grade.new(request_params)
    @grade.qualification_id = params[:qualification_id]

    if @grade.save
      respond_to do |format|
        format.html { redirect_to qualification_path(params[:qualification_id]) }
        format.json { render json: { message: 'success' } }
      end
    else
      respond_to do |format|
        format.html do
          flash.now[:alert] = @grade.errors.first.full_message
          render :new
        end
        format.json { render json: @grade.errors.as_json }
      end
    end
  end

  def edit
    @grade = Grade.find(params[:id])
  end

  def update
    @grade = Grade.find(params[:id])
    if @grade.update(request_params)
      respond_to do |format|
        format.html { redirect_to qualification_path(params[:qualification_id]) }
        format.json { render json: @grade }
      end
    else
      respond_to do |format|
        format.html do 
          flash.now[:alert] = @grade.errors.first.full_message
          render :edit
        end
        format.json { render json: { message: @grade.errors } }
      end
    end
  end

  def destroy
    @grade = Grade.find(params[:id])
    if @grade.destroy
      respond_to do |format|
        format.html do
          flash[:notice] = I18n.t('messages.destroyed')
          redirect_to qualification_path(params[:qualification_id])
        end
        format.json { render json: { message: 'success' } }
      end
    else
      respond_to do |format|
        format.html { flash.now[:alert] = @grade.errors.first.full_message }
        format.json { render json: @grade.errors.as_json }
      end
    end
  end

  private

  def request_params
    params.require(:grade).permit(%i[grade_name description display_order examiner_id certificater_id qualification_id])
  end
end

