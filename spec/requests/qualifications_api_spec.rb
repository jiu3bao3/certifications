require 'rails_helper'

RSpec.describe "Qualifications", type: :request do
  let!(:category) { create(:category) }
  let(:headers) { { "Content-Type" => 'application/json', "Accept" => "application/json" } }
  let(:params) { {} }

  xdescribe 'GET qualifications' do
    let(:qualification_count) { 3 }
    let!(:qualifications) { Array.new(qualification_count) { |i| create(:qualification, category:, name_ja: "試験#{i}")} }
    it do
      get qualifications_path, headers: { Accept: 'application/json' }
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body).map { |item| item.deep_symbolize_keys! }
      expect(json.size).to eq(qualification_count)
      expect(json.first).to include({ name_ja: "試験0", classification: "国家資格", category: category.name_ja })
    end
  end

  describe 'POST qualifications' do
    let(:params) { { name_ja: "検定試験", name_en: 'pforiciency test', category_id: category.id, classification: :vendor } }
    it do
      expect { post(qualifications_path, params: params.to_json, headers:) }.to change{ Qualification.count }.by(1)
      expect(response).to have_http_status(:found)
    end

    context '不正なパラメータ' do
      let(:params) { { name_ja: "", category_id: category.id } }
      it do
        expect { post(qualifications_path, params: params.to_json, headers:) }.not_to change{ Qualification.count }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)["errors"]).to include("資格名を入力してください")
      end
    end
  end

  describe 'PATCH qualifications' do
    let!(:qualification) { create(:qualification, category:) }
    let(:params) { { name_ja: "新検定試験", classification: :official } }
    it do
      expect { patch(qualification_path(qualification), params: params.to_json, headers:) }.not_to change{ Qualification.count }
      expect(response).to have_http_status(:found)
      expect(qualification.reload.name_ja).to eq(params[:name_ja])
    end

    context '不正なパラメータ' do
      let(:params) { { classification: :invalid } }
      it do
        expect { patch(qualification_path(qualification), params: params.to_json, headers:) }.not_to change{ Qualification.count }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)["errors"]).to include("区分は一覧にありません")
      end
    end
  end

  describe 'DELETE qualifications' do
    let!(:qualification) { create(:qualification, category:) }
    it do
      expect { delete(qualification_path(qualification), params: params.to_json, headers:) }.to change{ Qualification.count }.by(-1)
      expect(response).to have_http_status(:found)
    end

    context '削除対象が存在しない' do
      before { qualification.destroy! }
      it do 
        expect { delete(qualification_path(qualification), params: params.to_json, headers:) }.not_to change{ Qualification.count }
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end

