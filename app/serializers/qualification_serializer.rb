# == Schema Information
#
# Table name: qualifications
#
#  id                      :bigint           not null, primary key
#  classification(区分)    :integer          default("national"), not null
#  description(説明)       :text(65535)
#  name_en(資格英語名)     :string(255)
#  name_ja(資格名)         :string(255)      not null
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  category_id(カテゴリー) :bigint           not null
#
# Indexes
#
#  index_qualifications_on_category_id  (category_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#
class QualificationSerializer < ApplicationSerializer
  attributes %i[name_ja name_en classification category grades description category_id classification_id]

  def classification
    Qualification.human_attribute_name("classification.#{object.classification}")
  end

  def classification_id
    object.classification
  end

  def category
    object.category&.name_ja
  end

  def category_id
    object.category&.id
  end

  def grades
    ActiveModelSerializers::SerializableResource.new(object.grades.order(:display_order), each_serializer: GradeSerializer).as_json
  end
end
