require 'rails_helper'

RSpec.describe "Categories", type: :request do
  let(:headers) { { "Content-Type" => 'application/json', "Accept" => "application/json" } }
  let(:categories_count) { 3 }
  let!(:categories) { Array.new(categories_count) { |i| create(:category)} }

  describe 'GET categories' do
    it do
      get categories_path, headers: headers
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body).map { |item| item.deep_symbolize_keys! }
      expect(response).to have_http_status(:ok)
      expect(json.size).to eq(categories_count)
      expect(json.first[:name_ja]).to match('技術.+')
      expect(json.first[:description]).to eq('テスト用のカテゴリー')
      expect(json.first[:qualifications_count]).to eq(0)
    end
  end

  describe 'GET category' do
    it do
      get category_path(categories.first.id), headers: headers
      json = JSON.parse(response.body).deep_symbolize_keys!
      expect(response).to have_http_status(:ok)
      expect(json[:name_ja]).to eq(categories.first.name_ja)
    end
  end

  describe 'POST category' do
    let(:body) { { name_ja: 'カテゴリー名', name_en: 'category name', description: 'テスト用カテゴリー' } }
    it do 
      expect{ post categories_path, headers: headers, params: body.to_json }.to change{ Category.count }.by(1)
      expect(response).to have_http_status(:ok)
    end

    context 'Invalid parameters' do
      let(:body) { { name_ja: nil, name_en: 'category name', description: 'テスト用カテゴリー' } }
      it do
        post categories_path, headers: headers, params: body.to_json
        json = JSON.parse(response.body).deep_symbolize_keys!
        expect(response).to have_http_status(:unprocessable_content)
        expect(json[:message]).to include({name_ja: ["を入力してください"]})
      end
    end

  end

  describe 'PATCH category' do
    let(:body) { { name_ja: 'カテゴリー名', name_en: 'category name', description: 'テスト用カテゴリー' } }
    it do 
      patch category_path(categories.first), headers: headers, params: body.to_json
      json = JSON.parse(response.body).deep_symbolize_keys!
      expect(response).to have_http_status(:ok)
      expect(json[:name_ja]).to eq('カテゴリー名')
    end

    context 'Invalid parameters' do
      let(:body) { { name_ja: categories.last.name_ja, name_en: 'category name', description: 'テスト用カテゴリー' } }
      it do
        patch category_path(categories.first), headers: headers, params: body.to_json
        json = JSON.parse(response.body).deep_symbolize_keys!
        expect(response).to have_http_status(:unprocessable_content)
        expect(json[:message]).to include({name_ja: ["はすでに存在します"]})
      end
    end
  end

  describe 'DELETE examiner' do
    it do
      expect { delete category_path(categories.first.id), headers: headers }.to change{ Category.count }.by(-1)
      expect(response).to have_http_status(:ok)
    end
  end
end
