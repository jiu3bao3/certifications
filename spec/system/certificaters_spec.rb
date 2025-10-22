require 'rails_helper'

RSpec.describe "Certificaters", type: :system, js: true do
  let(:initial_record) { 3 }
  let!(:certificaters) { Array.new(initial_record) { |i| create(:certificater, name_ja: "資格認定機関#{i}", name_en: "Certificater#{i}", description: 'DESCRIPTION') }}

  before { driven_by(:selenium_chrome_headless) }

  describe 'GET certificaters' do
    before { visit certificaters_path }
    it '資格認定機関の一覧が表示されること' do
      expect(page).to have_title('資格')
      table = page.find(:table)
      expect(table.find_xpath('thead/tr/th').map { |h| h.all_text} ).to eq(%w[資格認定機関ID 資格認定機関名 資格認定機関名（英語） 参照 編集 削除])
      expect(table.find_xpath('tbody/tr').size).to eq(initial_record)
      expect(table.find_xpath('tbody/tr')[0].find_xpath('td').map{ |c| c.all_text } ).to eq(["#{certificaters[0].id}", "#{certificaters[0].name_ja}", "#{certificaters[0].name_en}", "参照", "編集", "削除"])
    end
    it '新規登録ボタンで登録画面へ遷移すること' do
      page.find('button', text: '新規登録', match: :first).click
      expect(page.all(:xpath, '//input[@value="保存"]').size).to eq(2)
      expect(page.current_path).to eq('/certificaters/new')
    end
    it '参照ボタンで詳細画面へ遷移すること' do
      page.find('button', text: '参照', match: :first).click
      expect(page.all(:xpath, '//div[@class="contents"]/a[@href="/certificaters"]').first&.text).to eq("一覧")
      expect(page.current_path).to match("/certificaters/\\d+")
    end
    it '編集ボタンで編集画面へ遷移すること' do
      page.find('button', text: '編集', match: :first).click
      expect(page.all(:xpath, '//input[@value="保存"]').size).to eq(2)
      expect(page.current_path).to match("/certificaters/\\d+/edit")
      expect(page.find_by_id('certificater_name_ja').value).to match('資格認定機関\\d+')
      expect(page.find_by_id('certificater_name_en').value).to match('Certificater\\d+')
      expect(page.find_by_id('certificater_description').value).to match('DESCRIPTION')
    end
  end

  describe 'POST certificaters' do
    let(:form_data) { { name_ja: '資格認定機関', name_en: 'CERTIFICATER', description: 'TEST' } }
    before { visit new_certificater_path }
    it '資格情報を登録できること' do
      form_data.each { |k,v| page.fill_in("certificater_#{k}", with: v) }
      page.all(:xpath, '//input[@type="submit"]')[0].click
      expect(Certificater.count).to eq(initial_record + 1)
    end
  end

  describe 'PATCH certificater' do
    let(:form_data) { { name_ja: '資格認定機関_更新', name_en: 'CERTIFICATER', description: 'TEST' } }
    let(:target) { certificaters.last }
    before { visit edit_certificater_path(target.id) }
    it '認定機関情報を登録できること' do
      form_data.each { |k,v| page.fill_in("certificater_#{k}", with: v) }
      page.all(:xpath, '//input[@type="submit"]')[0].click
      expect(Certificater.count).to eq(initial_record)
      target.reload
      expect(target.name_ja).to eq(form_data[:name_ja])
      expect(target.name_en).to eq(form_data[:name_en])
      expect(target.description).to eq(form_data[:description])
    end
  end

  describe 'DELETE certificater' do
    before { visit certificaters_path }
    it do
      page.find('button', text: '削除', match: :first).click
      page.accept_confirm "削除してよろしいですか？"
      expect(page.current_path).to eq("/certificaters")
      expect(page.all(:xpath, '//div[@class="notice"]').first.text).to match(/削除しました/)
      expect(Certificater.all.count).to eq(initial_record - 1)
    end
  end
end
