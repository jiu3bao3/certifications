require 'rails_helper'

RSpec.describe Examiner, type: :model do
  let!(:examiner) { create(:examiner) }

  describe 'validation' do
    let(:attributes) { { name: 'updated name', zipcode: '000-9999', url: 'https://example.com/hoge', corporate_number: 1 } }

    it 'エラーなく更新できること' do
      expect { examiner.update!(**attributes) }.not_to raise_error
      expect(examiner.as_json.symbolize_keys).to include(attributes)
    end

    context '不正な名称' do
      it { expect { examiner.update!(name: nil) }.to raise_error ActiveRecord::RecordInvalid, /試験実施機関名を入力してください/ }
      it { expect { Examiner.create!(name: examiner.name) }.to raise_error ActiveRecord::RecordInvalid, /試験実施機関名はすでに存在します/ }
    end
    context '不正な郵便番号' do
      shared_examples 'invalid_zipcode' do |zipcode|
        it { expect { examiner.update!(zipcode: zipcode) }.to raise_error ActiveRecord::RecordInvalid, /郵便番号は不正な値です/ }
      end
      it_behaves_like 'invalid_zipcode', '123-45678'
      it_behaves_like 'invalid_zipcode', '123-456'
      it_behaves_like 'invalid_zipcode', '1234567'
      it_behaves_like 'invalid_zipcode', 'ABC-DEFG'
    end
    context '不正な電話番号' do
      shared_examples 'invalid_tel' do |tel|
        it { expect { examiner.update!(tel: tel) }.to raise_error ActiveRecord::RecordInvalid, /電話番号は不正な値です/ }
      end
      it_behaves_like 'invalid_tel', 'AB-CDEF-GHIJ'
      it_behaves_like 'invalid_tel', '03+1234+5678'
      it_behaves_like 'invalid_tel', '０３－１２３４－５６７８'
    end
    context '不正な法人番号' do
      shared_examples 'invalid_corporate_number' do |corporate_number, message|
        it { expect { examiner.update!(corporate_number: corporate_number) }.to raise_error ActiveRecord::RecordInvalid, message }
      end
      it_behaves_like 'invalid_corporate_number', 123.45, /法人番号は整数で入力してください/
      it_behaves_like 'invalid_corporate_number', 'ABCDE', /法人番号は数値で入力してください/
    end
    context '不正なURL' do
      shared_examples 'invalid_url' do |url|
        it { expect { examiner.update!(url: url) }.to raise_error ActiveRecord::RecordInvalid, /URLは不正な値です/ }
      end
      it_behaves_like 'invalid_url', 'ftp://www.google.com/'
      it_behaves_like 'invalid_url', 'www.google.com/'
    end
  end
end
