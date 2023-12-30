# == Schema Information
#
# Table name: grades
#
#  id                       :bigint           not null, primary key
#  description(説明)        :string(255)
#  grade_name(グレード)     :string(255)
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  certificater_id(認定者)  :bigint           not null
#  examiner_id(試験実施者)  :bigint
#  qualification_id(資格ID) :bigint           not null
#
# Indexes
#
#  index_grades_on_certificater_id   (certificater_id)
#  index_grades_on_examiner_id       (examiner_id)
#  index_grades_on_qualification_id  (qualification_id)
#
# Foreign Keys
#
#  fk_rails_...  (certificater_id => certificaters.id)
#  fk_rails_...  (examiner_id => examiners.id)
#  fk_rails_...  (qualification_id => qualifications.id)
#
class Grade < ApplicationRecord
  belongs_to :qualification
  belongs_to :examiner
  belongs_to :certificater
end
