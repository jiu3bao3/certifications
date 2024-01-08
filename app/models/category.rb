# == Schema Information
#
# Table name: categories
#
#  id                                                  :bigint           not null, primary key
#  description(説明)                                   :string(255)
#  name_en(カテゴリー英語名)                           :string(255)
#  name_ja(カテゴリー名)                               :string(255)      not null
#  qualifications_count(登録資格数（counter cache用）) :integer          default(0), not null
#  created_at                                          :datetime         not null
#  updated_at                                          :datetime         not null
#
# Indexes
#
#  index_categories_on_name_ja  (name_ja) UNIQUE
#
class Category < ApplicationRecord
  has_many :qualifications, dependent: :destroy

  validates :name_ja, presence: true, uniqueness: true
end
