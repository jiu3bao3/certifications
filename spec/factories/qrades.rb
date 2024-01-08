FactoryBot.define do
  factory :grade do
    qualification
    certificater
    examiner
    grade_name { "１級" }
    display_order { 1 }
    description { "１級" }
  end
end
