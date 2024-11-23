# == Schema Information
#
# Table name: examiners
#
#  id               :integer          not null, primary key
#  name             :string(255)      not null
#  corporate_number :integer
#  zipcode          :string(255)
#  address          :string(255)
#  url              :string(255)
#  tel              :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

FactoryBot.define do
  factory :examiner do
    corporate_number { rand(1000000000000) }
    name { "宮内庁#{SecureRandom.uuid}" }
    zipcode { sprintf('%03d-%04d', rand(100), rand(1000)) }
    address { '東京都千代田区千代田1-1-1' }
    url { 'https://www.kunaicho.go.jp/' }
    tel { '01-2345-6789' }
  end
end
