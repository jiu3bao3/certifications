require 'rails_helper'

RSpec.describe "Certificaters", type: :request do
  let(:headers) { { "Content-Type" => 'application/json', "Accept" => "application/json" } }
  let(:certificaters_count) { 3 }
  let!(:certificaters) { Array.new(certificaters_count) { |i| create(:certificater, name_ja: "資格認定機関#{i}")} }

  describe 'GET certificaters' do
    it do
      get certificaters_path, headers: headers
      json = JSON.parse(response.body).map { |item| item.deep_symbolize_keys! }
      expect(response).to have_http_status(:ok)
      expect(json.size).to eq(certificaters_count)
      expect(json.first[:name_ja]).to match('資格認定機関\d+')
      expect(json.first[:name_en]).to eq('Emperor of Japan')
    end
  end

  describe 'GET certificater' do
    it do
      get certificater_path(certificaters.last.id), headers: headers
      json = JSON.parse(response.body).deep_symbolize_keys!
      expect(response).to have_http_status(:ok)
      expect(json[:name_ja]).to match('資格認定機関\d+')
      expect(json[:name_en]).to eq('Emperor of Japan')
    end
  end

  describe 'POST certificater' do
    let(:body) { { name_ja: '資格会社', name_en: 'certificater company', description: 'テスト' } }
    it do
      expect { post certificaters_path, headers: headers, params: body.to_json }.to change{ Certificater.count }.by(1) 
      json = JSON.parse(response.body).deep_symbolize_keys!
      expect(response).to have_http_status(:ok)
      expect(json[:name_ja]).to match('資格会社')
      expect(json[:name_en]).to eq('certificater company')
      expect(json[:id]).not_to be_nil
    end
  end

  describe 'PATCH certificater' do
    let(:body) { { name_ja: '資格会社', name_en: 'certificater company', description: 'テスト' } }
    it do
      patch certificater_path(certificaters.last.id), headers: headers, params: body.to_json
      json = JSON.parse(response.body).deep_symbolize_keys!
      expect(response).to have_http_status(:ok)
      expect(json[:name_ja]).to match('資格会社')
      expect(json[:name_en]).to eq('certificater company')
    end

    context 'invalid parameters' do
      let(:body) { { name_ja: nil, name_en: 'certificater company', description: 'テスト' } }
      it do
        patch certificater_path(certificaters.last.id), headers: headers, params: body.to_json
        json = JSON.parse(response.body).deep_symbolize_keys!
        expect(response).to have_http_status(:unprocessable_content)
        expect(json[:message]).to include({ name_ja: ["を入力してください"] })
      end
    end
  end

  describe 'DELETE examiner' do
    it do
      expect { delete certificater_path(certificaters.last.id), headers: headers }.to change{ Certificater.count }.by(-1)
      expect(response).to have_http_status(:ok)
    end
  end
end
