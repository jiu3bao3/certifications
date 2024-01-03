FactoryBot.define do
  factory :examiner do
    corporate_number { rand(1000000000000) }
    name { '天皇陛下' }
    zipcode { sprintf('%03d-%04d', rand(100), rand(1000)) }
    address { '東京都千代田区千代田1-1-1' }
    url { 'https://www.kunaicho.go.jp/' }
    tel { '01-2345-6789' }
  end
end
