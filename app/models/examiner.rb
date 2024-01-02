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

  validates :name, presence: true
  validates :zipcode, format: { with: /\d{3}\-\d{4}/ }, allow_blank: true
  validates :corporate_number, numericality: { only_integer: true }, allow_blank: true
  validates :url, format: { with: /https?:\/\/([\w\-_]+\.)+[\w]+\/.*/ }, allow_blank: true
end
