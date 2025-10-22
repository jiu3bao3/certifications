# == Schema Information
#
# Table name: certificaters
#
#  id          :integer          not null, primary key
#  name_ja     :string(255)      not null
#  name_en     :string(255)
#  description :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_certificaters_on_name_ja  (name_ja) UNIQUE
#

class Certificater < ApplicationRecord
  validates :name_ja, presence: true, uniqueness: true
  validates :name_en, format: { with: /\A[ -~\w]+\z/ }, allow_blank: true
end
