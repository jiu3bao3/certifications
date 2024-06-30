# == Schema Information
#
# Table name: grades
#
#  id                       :bigint           not null, primary key
#  description(説明)        :string(255)
#  display_order(表示順)    :integer          default(0), not null
#  grade_name(グレード)     :string(255)
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  certificater_id(認定者)  :bigint           not null
#  examiner_id(試験実施者)  :bigint
#  qualification_id(資格ID) :bigint           not null
#
# Indexes
#
#  index_grades_on_certificater_id                  (certificater_id)
#  index_grades_on_examiner_id                      (examiner_id)
#  index_grades_on_qualification_id                 (qualification_id)
#  index_grades_on_qualification_id_and_grade_name  (qualification_id,grade_name) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (certificater_id => certificaters.id)
#  fk_rails_...  (examiner_id => examiners.id)
#  fk_rails_...  (qualification_id => qualifications.id)
#
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
