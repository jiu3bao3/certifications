# == Schema Information
#
# Table name: certificaters
#
#  id                    :bigint           not null, primary key
#  description(説明)     :string(255)
#  name_en(認定者英語名) :string(255)
#  name_ja(認定者名)     :string(255)      not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
# Indexes
#
#  index_certificaters_on_name_ja  (name_ja) UNIQUE
#
require 'rails_helper'

RSpec.describe Certificater, type: :model do
  let!(:certificater) { create(:certificater) }

  describe 'validation' do
    let(:name_ja) { '新認定機関' }
    let(:name_en) { 'New Name'}
    let(:attributes) { { name_ja:, name_en:, description: '変更テスト' } }

    it 'エラーなく更新できること' do
      expect{ certificater.update!(attributes) }.not_to raise_error
      expect(certificater.as_json.symbolize_keys).to include(attributes)
    end

    context '不正な認定機関名' do
      shared_examples 'invalid_name' do |new_name|
        let(:name_ja) { new_name }
        it do
          expect{ certificater.update!(attributes) }.to raise_error ActiveRecord::RecordInvalid, /資格認定機関名を入力してください/
        end
      end
      it_behaves_like 'invalid_name', nil
      it_behaves_like 'invalid_name', ''
      it '既に存在する認定機関名がバリデーションエラーとなること' do
        expect { create(:certificater, name_ja: certificater.name_ja) }.to raise_error ActiveRecord::RecordInvalid, /資格認定機関名はすでに存在します/
      end
    end

    context '不正な認定機関英語名' do
      shared_examples 'invalid_name' do |new_name|
        let(:name_en) { new_name }
        it do
          expect{ certificater.update!(attributes) }.to raise_error ActiveRecord::RecordInvalid, /資格認定機関名（英語）は不正な値です/
        end
      end
      it_behaves_like 'invalid_name', '認定機関名'
      it_behaves_like 'invalid_name', "\u0000"
    end
  end
end
