require 'rails_helper'

RSpec.describe "Qualifications", type: :system, js: true do
  let(:initial_record) { 3 }
  let(:category) { create(:category) }
  let!(:qualifications) { Array.new(initial_record) { |i| create(:qualification, category:) } }

  before { driven_by(:selenium_chrome_headless) }

  describe 'GET qualifications' do
    before { visit qualifications_path }
    it '資格一覧が表示されていること' do
      expect(page).to have_title('資格')
      table = page.find_by_id('qualifications_table')
      expect(table.find_xpath('thead/tr/th').map { |h| h.all_text} ).to eq(%w[カテゴリー 区分 資格名 参照 編集 削除])
      expect(table.find_xpath('tbody/tr').size).to eq(initial_record)
      expect(table.find_xpath('tbody/tr')[0].find_xpath('td').map{ |c| c.all_text }).to eq([category.name_ja, "国家資格", "テスト検定", "参照", "編集", "削除"])
    end

    it '新規登録ボタンで登録画面へ遷移すること' do
      expect(page).to have_button(text: '新規登録')
      page.find('button', text: '新規登録', match: :first).click
      expect(page.all(:xpath, '//input[@value="保存"]').size).to eq(1)
      expect(page.current_path).to eq('/qualifications/new')
    end

    it '参照ボタンで詳細画面へ遷移すること' do
      page.find('button', text: '参照', match: :first).click
      expect(page.all(:xpath, '//div[@class="contents"]/a[@href="/qualifications"]').first&.text).to eq("一覧")
      expect(page.current_path).to match("\/qualifications\/\\d+")
    end

    it '編集ボタンで編集画面へ遷移すること' do
      page.find('button', text: '編集', match: :first).click
      expect(page.all(:xpath, '//input[@value="保存"]').size).to eq(1)
      expect(page.current_path).to match("\/qualifications\/\\d+\/edit")
    end

  end

  describe 'POST qualifications' do
    let(:form_data) { { name_ja: '資格名', name_en: 'QUALIFICATION', description: 'TEST' } }

    before { visit new_qualification_path }
    it '資格情報を登録できること' do
      form_data.each { |k,v| page.fill_in("qualification_#{k}", with: v) }
      page.select('公的資格', from: '区分')
      page.select(category.name_ja, from: 'Category')
      page.all(:xpath, '//input[@type="submit"]')[0].click
      expect(Qualification.count).to eq(initial_record + 1)
    end
  end

  describe 'DELETE qualification' do
    before { visit qualifications_path }
    it '削除ボタンで資格情報が削除されること' do
      page.find('button', text: '削除', match: :first).click
      page.accept_confirm "削除してよろしいですか？"
      expect(page.current_path).to eq("/qualifications")
      expect(page.all(:xpath, '//div[@class="notice"]').first.text).to match(/削除しました/)
      expect(Qualification.all.count).to eq(initial_record - 1)
    end
  end
end
