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
require 'rails_helper'

RSpec.describe Qualification, type: :model do
  let!(:qualification) { create(:qualification) }

  describe 'validation' do
    let(:classification) { :vendor }
    let(:name_ja) { '例' }
    let(:new_attr) { { name_en: 'example', name_ja:, classification:, description: 'RSpecテスト' } }
    it 'エラーなく更新できること' do
      expect { qualification.update!(new_attr) }.not_to raise_error
    end

    context '不正な区分' do
      shared_examples 'invalid_classification' do |new_classification|
        let(:classification) { new_classification } 
        it { expect { qualification.update!(new_attr) }.to raise_error ActiveRecord::RecordInvalid, /区分は一覧にありません/ }
      end
      it_behaves_like 'invalid_classification', :invalid
      it_behaves_like 'invalid_classification', nil
      it_behaves_like 'invalid_classification', 999
    end

    context '不正な名称' do
      shared_examples 'invalid_name_ja' do |new_name|
        let(:name_ja) { new_name } 
        it { expect { qualification.update!(new_attr) }.to raise_error ActiveRecord::RecordInvalid, /資格名を入力してください/ }
      end
      it_behaves_like 'invalid_name_ja', ''
      it_behaves_like 'invalid_name_ja', nil
    end
  end

  describe 'counter_cache' do
    before { (1..5).each { |i| create(:category, name_ja: "カテゴリー#{i}")} }

    it '資格情報を作成した場合に当該カテゴリーのqualifications_countがインクリメントされること' do
      category = Category.first
      expect{ create(:qualification, category: ) }.to change { category.qualifications_count }.by(1)
    end
    it '資格情報を削除した場合に当該カテゴリーのqualifications_countがデクリメントされること' do
      expect{ qualification.destroy }.to change { qualification.category.qualifications_count }.by(-1)
    end
  end
end
