# == Schema Information
#
# Table name: categories
#
#  id                                                  :bigint           not null, primary key
#  name_en(カテゴリー英語名)                           :string(255)
#  name_ja(カテゴリー名)                               :string(255)      not null
#  qualifications_count(登録資格数（counter cache用）) :integer          default(0), not null
#  created_at                                          :datetime         not null
#  updated_at                                          :datetime         not null
#
class Category < ApplicationRecord
  has_many :qualifications, dependent: :destroy
end
