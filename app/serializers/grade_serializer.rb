class GradeSerializer < ApplicationSerializer
  attributes %i[grade_name display_order description examiner_name certificater_name]

  def examiner_name
    object.examiner&.name
  end

  def certificater_name
    object.certificater&.name_ja
  end
end
