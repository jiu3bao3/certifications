require 'rails_helper'

RSpec.describe "Examiners", type: :request do
  let(:headers) { { "Content-Type" => 'application/json', "Accept" => "application/json" } }

  describe 'GET examiners' do
    let(:examiners_count) { 2 }
    let!(:examiners) { Array.new(examiners_count) { |i| create(:examiner, name: "試験実施機関#{i}")} }
    it do
      get examiners_path, headers: headers
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body).map { |item| item.deep_symbolize_keys! }
      expect(json.size).to eq(examiners_count)
      expect(json.first[:name]).to match('試験実施機関\d+')
      expect(json.first[:zipcode]).to match('\d{3}\-\d{4}')
      expect(json.first[:tel]).to eq('01-2345-6789')
      expect(json.first[:address]).to eq('東京都千代田区千代田1-1-1')
    end
  end

  describe 'GET examiner' do
    let(:examiners_count) { 3 }
    let!(:examiners) { Array.new(examiners_count) { |i| create(:examiner, name: "試験実施機関#{i}")} }
    it do
      get examiner_path(examiners.first.id), headers: headers
      json = JSON.parse(response.body).deep_symbolize_keys!
      expect(response).to have_http_status(:ok)
      expect(json[:name]).to match('試験実施機関\d+')
    end
  end

  describe 'POST examiners' do
    let(:body) { { name: '検定委員会', zipcode: '000-1234', address: '大阪市西成区', tel: '06-7777-8888' } }
    it do
      post examiners_path, headers: headers, params: body.to_json
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body).deep_symbolize_keys!
      expect(json[:id]).not_to be_nil
      expect(json[:name]).to eq(body[:name])
    end

    context 'invalid parameters' do
      let(:body) { { name: '検定委員会', zipcode: 'ABC-1234', address: '大阪市西成区', tel: '06-7777-8888', url: 'example@example.com' } }
      it do
        post examiners_path, headers: headers, params: body.to_json
        json = JSON.parse(response.body).deep_symbolize_keys!
        expect(response).to have_http_status(:unprocessable_content)
        expect(json[:message].keys).to match_array([:zipcode, :url])
      end
    end
  end

  describe 'PATCH examiner' do
    let!(:examiner) { create(:examiner, name: "試験実施機関") }
    let(:body) { { name: '検定委員会', zipcode: '000-1234', address: '大阪市西成区', tel: '06-7777-8888' } }
    it do
      patch examiner_path(examiner.id), headers: headers, params: body.to_json
      json = JSON.parse(response.body).deep_symbolize_keys!
      expect(response).to have_http_status(:ok)
      expect(json[:name]).to eq('検定委員会')
    end

    context 'invalid parameters' do
      let!(:examiner) { create(:examiner, name: "試験実施機関") }
      let(:body) { { name: '検定委員会', zipcode: 'ABC-1234', address: '大阪市西成区', tel: '06-7777-8888', url: 'example@example.com' } }
      it do
        patch examiner_path(examiner.id), headers: headers, params: body.to_json
        json = JSON.parse(response.body).deep_symbolize_keys!
        expect(response).to have_http_status(:unprocessable_content)
        expect(json[:message].keys).to match_array([:zipcode, :url])
      end
    end
  end

  describe 'DELETE examiner' do
    let!(:examiner) { create(:examiner, name: "試験実施機関") }
    it do
      expect { delete examiner_path(examiner.id), headers: headers }.to change{ Examiner.count }.by(-1)
      expect(response).to have_http_status(:ok)
    end
  end
end
