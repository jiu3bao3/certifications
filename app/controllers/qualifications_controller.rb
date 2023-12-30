class QualificationsController < ApplicationController
  def index
    @qualification_grades = Grade.includes(:certificater, { qualification: :category} ).all
  end

  def create
  end

  def edit

  end

  def destroy
    Grade.destroy(params[:id])

    redirect_to qualifications_path
  end
end
