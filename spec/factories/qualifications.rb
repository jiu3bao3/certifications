FactoryBot.define do
  factory :qualification do
    name_ja { "テスト検定" }
    name_en { "Test Proficiency Examination" }
    description { 'Test' }
    classification { :national }
    category { create(:category, name_ja: 'テスト用', name_en: 'test' ) }
  end
end
