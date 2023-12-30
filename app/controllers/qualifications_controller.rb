class QualificationsController < ApplicationController
  def index
    @qualification_grades = Grade.includes(:certificater, { qualification: :category} ).all
  end
end
