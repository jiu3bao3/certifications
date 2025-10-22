class QualificationsController < ApplicationController
  def index
    @qualifications = search
    respond_to do |format|
      format.html { render index: @qualifications }
      format.json { render json: ActiveModel::Serializer::CollectionSerializer.new(@qualifications, serializer: QualificationSerializer).as_json }
    end
  end

  def show
    @qualification = Qualification.includes(:category, { grades: %i[certificater examiner] }).find(params[:id])
    respond_to do |format|
      format.html { render show: @qualification }
      format.json { render json: @qualification, serializer: QualificationSerializer }
    end
  end

  def new
    @qualification = Qualification.new
  end

  def create
    @qualification = Qualification.new(request_params)

    if @qualification.save
      flash[:notice] = I18n.t('messages.registered')
      respond_to do |format|
        format.html { redirect_to edit_qualification_path(@qualification) }
        format.json { render json: @qualification }
      end
    else
      flash.now[:alert] = @qualification.errors.first.full_message
      respond_to do |format|
        format.html { render :new }
        format.json { render json: { errors: @qualification.errors.full_messages.as_json }, status: :unprocessable_content }
      end
    end
  end

  def edit
    @qualification = Qualification.find(params[:id])
  end

  def update
    @qualification = Qualification.find(params[:id])
    if @qualification.update(request_params)
      flash[:notice] = I18n.t('messages.updated')
      respond_to do |format|
        format.html { redirect_to edit_qualification_path(@qualification) }
        format.json { render json: @qualification }
      end
    else
      flash.now[:alert] = @qualification.errors.first.full_message
      respond_to do |format|
        format.html { render :edit }
        format.json { render json: { errors: @qualification.errors.full_messages.as_json }, status: :unprocessable_content }
      end
    end
  end

  def destroy
    Qualification.destroy(params[:id])
    flash[:notice] = I18n.t('messages.destroyed')
    respond_to do |format|
      format.html { redirect_to qualifications_path }
      format.json { render json: { message: 'success' } }
    end
  end

  private

  def search
    query = Qualification.includes(:category)
    query = query.where("name_ja LIKE ?", "%#{search_params[:qualification_name]}%") if search_params[:qualification_name].present?
    if search_params.key?(:classifications)
      selected_classifications = search_params[:classifications].select { |k, v| v == '1' }
      query = query.where(classification: selected_classifications.keys)
    end
    query = query.where(category_id: search_params[:category_id]) if search_params[:category_id].present?
    query.all
  end

  def request_params
    params.require(:qualification).permit(%i[id name_ja name_en category_id classification description])
  end

  def search_params
    params.permit(:commit, :qualification_name, :category_id, classifications: %i[national official vendor]).to_hash.symbolize_keys
  end
end
