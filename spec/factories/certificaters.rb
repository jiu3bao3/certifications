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

FactoryBot.define do
  factory :certificater do
    name_ja { "天皇陛下" }
    name_en { "Emperor of Japan" }
    description { "日本国および日本国民統合の象徴とされる" }
  end
end
