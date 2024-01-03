FactoryBot.define do
  factory :qrade do
    qualification { create(:qualification) }
    certificater { create(:certificater) }
    grade_name { "１級" }
    display_order { 1 }
    description { "１級" }
  end
end
