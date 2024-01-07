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
class Qualification < ApplicationRecord
  enum :classification, %i[national official vendor], validate: true
  belongs_to :category, counter_cache: true
  has_many :grades, dependent: :destroy

  validates :name_ja, presence: true
end
