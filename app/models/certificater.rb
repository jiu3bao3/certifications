# == Schema Information
#
# Table name: certificaters
#
#  id                    :bigint           not null, primary key
#  description(説明)     :string(255)
#  name_en(認定者英語名) :string(255)
#  name_ja(認定者名)     :string(255)      not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
# Indexes
#
#  index_certificaters_on_name_ja  (name_ja) UNIQUE
#
class Certificater < ApplicationRecord
  has_many :grade, dependent: :destroy

  validates :name_ja, presence: true
end
