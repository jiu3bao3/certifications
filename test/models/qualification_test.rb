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
require "test_helper"

class QualificationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
