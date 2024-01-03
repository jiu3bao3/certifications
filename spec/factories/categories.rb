FactoryBot.define do
  factory :category do
    name_ja { "技術#{SecureRandom.uuid}" }
    name_en { "technology#{SecureRandom.uuid}" }
    description { "テスト用のカテゴリー" }
  end
end
