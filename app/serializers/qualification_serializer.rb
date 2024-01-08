class QualificationSerializer < ApplicationSerializer
  attributes %i[name_ja name_en classification category grades]

  def classification
    Qualification.human_attribute_name("classification.#{object.classification}")
  end

  def category
    object.category&.name_ja
  end

  def grades
    ActiveModelSerializers::SerializableResource.new(object.grades, each_serializer: GradeSerializer).as_json
  end
end
