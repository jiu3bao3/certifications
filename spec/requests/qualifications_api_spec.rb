require 'rails_helper'

RSpec.describe "Qualifications", type: :request do
  let(:qualification_count) { 3 }
  let(:category) { create(:category) }
  let!(:qualifications) { Array.new(qualification_count) { |i| create(:qualification, category:, name_ja: "試験#{i}")} }

  describe 'GET qualifications' do
    it do
      get qualifications_path, headers: { Accept: 'application/json' }
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body).map { |item| item.deep_symbolize_keys! }
      expect(json.size).to eq(qualification_count)
      expect(json.first).to include({ name_ja: "試験0", classification: "国家資格", category: category.name_ja })
    end
  end
end

