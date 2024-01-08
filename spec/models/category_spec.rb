require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:name_ja) { '新カテゴリー' }
  let!(:category) { create(:category) }

  describe 'validation' do
    let(:attributes) { { name_ja:, name_en: 'new category', description: '変更テスト' } }
    it 'エラーなく更新できること' do
      expect { category.update!(**attributes) }.not_to raise_error
      expect(category.as_json.symbolize_keys).to include(attributes)
      expect(category.qualifications_count).to eq(0)
    end
    context '既存のカテゴリー名と重複' do
      before { create(:category, name_ja:) }
      it 'バリデーションエラーとなること' do
        expect { category.update!(**attributes) }.to raise_error ActiveRecord::RecordInvalid, /カテゴリー名はすでに存在します/
      end
    end
    context 'カテゴリー名がブランク' do
      let(:name_ja) { nil }
      it 'バリデーションエラーとなること' do
        expect { category.update!(**attributes) }.to raise_error ActiveRecord::RecordInvalid, /カテゴリー名を入力してください/
      end
    end
  end
end
