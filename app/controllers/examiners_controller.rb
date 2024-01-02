class ExaminersController < ApplicationController
  def index
    @examiners = Examiner.all
  end
end
