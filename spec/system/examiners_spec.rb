require 'rails_helper'

RSpec.describe "Examiners", type: :system, js: true do
  let!(:examiners) { Array.new(3) { |i| create(:examiner, name: "試験実施機関#{i}") }}

  before { driven_by(:selenium_chrome_headless) }

  describe 'GET examiners' do
    before { visit examiners_path }
    it '資格認定機関一覧が表示されていること' do
      expect(page).to have_title('資格')
      table = page.find_by_id('examiners_table')
      expect(table.find_xpath('thead/tr/th').map { |h| h.all_text} ).to eq(%w[試験実施機関ID 試験実施機関名 所在地 参照 編集 削除])
      expect(table.find_xpath('tbody/tr').size).to eq(examiners.size)
      expect(table.find_xpath('tbody/tr')[0].find_xpath('td').map{ |c| c.all_text } ).to eq(["#{examiners[0].id}", "#{examiners[0].name}", "#{examiners[0].address}", "参照", "編集", "削除"])
    end
    it '新規登録ボタンで登録画面へ遷移すること' do
      expect(page).to have_button('new_examiner_button')
      new_examiner_button = page.all('new_examiner_button')
      page.all('button').filter { |b| b.text == '新規登録' }[0].click
      expect(page.has_button?('保存', wait: 3))
      expect(page.current_path).to eq('/examiners/new')
    end
    it '参照ボタンで詳細画面へ遷移すること' do
      show_examiner_button = page.find_by_id('examiners_table').find_xpath('tbody/tr')[0].find_xpath('td')[3]
      expect(show_examiner_button.all_text).to eq("参照")
      show_examiner_button.click
      expect(page.has_link?('一覧', wait: 3))
      expect(page.current_path).to eq("/examiners/#{examiners[0].id}")
    end
    it '編集ボタンで編集画面へ遷移すること' do
      edit_examiner_button = page.find_by_id('examiners_table').find_xpath('tbody/tr')[0].find_xpath('td')[4]
      expect(edit_examiner_button.all_text).to eq("編集")
      edit_examiner_button.click
      expect(page.has_button?('保存', wait: 3))
      expect(page.current_path).to eq("/examiners/#{examiners[0].id}/edit")
    end
    it '削除ボタンで試験実施機関情報が削除されること' do
      destroy_examiner_button = page.find_by_id('examiners_table').find_xpath('tbody/tr')[0].find_xpath('td')[5]
      expect(destroy_examiner_button.all_text).to eq("削除")
      destroy_examiner_button.click
      page.accept_confirm "削除してよろしいですか？"
      expect(page.current_path).to eq("/examiners")
      expect(page.has_text?('削除しました', wait: 3))
      expect(Examiner.all.count).to eq(2)
    end
  end

  describe 'POST examiners' do
    let(:examiner_name) { "試験実施団体" }
    let(:form_data) { { examiner_name:, examiner_corporate_number: 1234567890, examiner_zipcode: '123-4567', examiner_address: '北海道国後郡泊村', examiner_tel: '0123-45-6789', examiner_url: 'https://www.example.com/' } }
    before { visit new_examiner_path }

    it '正常に登録できること' do
      form_data.each { |k,v| page.fill_in(k, with: v) }
      page.all(:xpath, '//input[@type="submit"]')[0].click
      expect(page.current_path).to eq("/examiners")
      expect(Examiner.count).to eq(4)
      expect(Examiner.last.as_json).to include(form_data.map { |k,v| [k.to_s.gsub(/examiner_/, ''), v] }.to_h)
    end

    context '既に同じ名称が登録済' do
      let(:examiner_name) { "試験実施機関0" }
      it '登録できないこと' do
        form_data.each { |k,v| page.fill_in(k, with: v) }
        page.all(:xpath, '//input[@type="submit"]')[0].click
        expect(page.has_text?("試験実施機関名はすでに存在します", wait: 3))
        expect(Examiner.count).to eq(3)
      end
    end
  end
end
