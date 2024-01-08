require 'rails_helper'

RSpec.describe Grade, type: :model do
  let!(:qualification) { create(:qualification) }
  let!(:examiner) { create(:examiner) }
  let!(:certificater) { create(:certificater) }
  let!(:grade) { create(:grade, qualification:, examiner:, certificater:) }
  let(:attributes) { { grade_name: '2級', display_order: 0, description: 'テスト用'} }

  describe 'validation' do
    it 'エラーなく更新できること' do
      expect { grade.update!(**attributes) }.not_to raise_error
      expect( grade.as_json.symbolize_keys).to include(attributes)
    end

    context '同一のグレードが存在する' do
      before { (2..4).each { |i| create(:grade, grade_name: "#{i}級", qualification:, examiner:, certificater:) } }

      context '既存グレードと同一の資格' do
        it { expect { grade.update!(**attributes) }.to raise_error ActiveRecord::RecordInvalid, /グレード名はすでに存在します/ }
      end
      context '既存グレードと異なる資格' do
        before { grade.update!(qualification: create(:qualification, name_ja: '別の資格', category: qualification.category)) }
        it { expect { grade.update!(**attributes) }.not_to raise_error }
      end
    end
  end
end
