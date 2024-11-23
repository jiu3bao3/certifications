# == Schema Information
#
# Table name: examiners
#
#  id               :integer          not null, primary key
#  name             :string(255)      not null
#  corporate_number :integer
#  zipcode          :string(255)
#  address          :string(255)
#  url              :string(255)
#  tel              :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Examiner < ApplicationRecord
  has_many :grade

  validates :name, presence: true, uniqueness: true
  validates :zipcode, format: { with: /\A\d{3}\-\d{4}\z/ }, allow_blank: true
  validates :corporate_number, numericality: { only_integer: true }, allow_blank: true
  validates :url, format: { with: /\Ahttps?:\/\/([\w\-_]+\.)+[\w]+\/.*\z/ }, allow_blank: true
  validates :tel, format: { with: /\A[\d\-]+\z/ }, allow_blank: true
end
