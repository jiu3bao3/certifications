require 'rails_helper'

RSpec.describe "Grades", type: :request do
  let(:headers) { { "Content-Type" => 'application/json', "Accept" => "application/json" } }
  let(:grades_count) { 3 }
  let(:qualification) { create(:qualification) }
  let(:certificater) { create(:certificater)}
  let(:examiner) { create(:examiner) }
  let!(:grades) { Array.new(grades_count) { |i| create(:grade, grade_name: "grade#{i + 1}", qualification: qualification, display_order: (i + 1), certificater: certificater, examiner: examiner) } }

  describe 'GET grade' do
    it do
      get qualification_grade_path(qualification.id, grades.first.id), headers: headers
      json = JSON.parse(response.body).deep_symbolize_keys!
      expect(response).to have_http_status(:ok)
      expect(json[:qualification_id]).to eq(qualification.id)
      expect(json[:certificater_id]).to eq(certificater.id)
      expect(json[:grade_name]).to match('grade\d+')
    end
  end

  describe 'POST grade' do
    let(:body) { { grade_name: 'グレード名追加', examiner_id: examiner.id , certificater_id: certificater.id} }
    it do
      expect { post qualification_grades_path(qualification.id), headers: headers, params: body.to_json }.to change{ Grade.count }.by(1)
      json = JSON.parse(response.body).deep_symbolize_keys!
      expect(response).to have_http_status(:ok)
      expect(json[:id]).not_to be_nil
      expect(json[:name]).to eq(body[:name])
    end

    context 'Invalid display_order' do
      let(:examiner_id) { examiner.id }
      let(:certificater_id) { certificater.id }
      let(:qualification_id) { qualification.id }
      shared_examples 'invalid_parameters' do |body|
        let(:params) { { examiner_id:, certificater_id:, qualification_id: }.merge(body) }
        it do
          post qualification_grades_path(qualification.id), headers:, params: params.to_json
          expect(response).to have_http_status(:unprocessable_content)
        end
      end
      it_behaves_like 'invalid_parameters', { grade_name: 'グレード名追加', display_order: 'Invalid' }
      it_behaves_like 'invalid_parameters', { grade_name: 'grade1' }
      it_behaves_like 'invalid_parameters', { examiner_id: -1 }
      it_behaves_like 'invalid_parameters', { certificater_id: -1 }
    end
  end

  describe 'PATCH grade' do
    let(:body) { { grade_name: 'グレード名変更', examiner_id: examiner.id , certificater_id: certificater.id} }
    it do
      patch qualification_grade_path(qualification.id, grades.last.id), headers:, params: body.to_json
      json = JSON.parse(response.body).deep_symbolize_keys!
      expect(response).to have_http_status(:ok)
      expect(json[:grade_name]).to eq('グレード名変更')
    end
  end

  describe 'DELETE grade' do
    it do
      expect { delete qualification_grade_path(qualification.id, grades.last.id), headers: }.to change{ Grade.count}.by(-1)
      json = JSON.parse(response.body).deep_symbolize_keys!
      expect(response).to have_http_status(:ok)
    end
  end
end
