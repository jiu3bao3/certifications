# == Schema Information
#
# Table name: examiners
#
#  id                         :bigint           not null, primary key
#  address(所在地)            :string(255)
#  corporate_number(法人番号) :bigint
#  name(試験実施者名)         :string(255)      not null
#  tel(電話番号)              :string(255)
#  url(URL)                   :string(255)
#  zipcode(郵便番号)          :string(255)
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
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
