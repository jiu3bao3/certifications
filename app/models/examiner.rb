# == Schema Information
#
# Table name: examiners
#
#  id                         :bigint           not null, primary key
#  address(所在地)            :string(255)
#  corporate_number(法人番号) :bigint
#  name(試験実施者名)         :string(255)      not null
#  tel(電話番号)              :string(255)
#  url(URL)                   :string(255)
#  zipcode(郵便番号)          :string(255)
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#
class Examiner < ApplicationRecord
  has_many :grade
end
