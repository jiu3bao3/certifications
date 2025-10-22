require 'rails_helper'

RSpec.describe "Categories", type: :system, js: true do
  let(:initial_record) { 5 }
  let!(:categories) { Array.new(initial_record) { |i| create(:category, name_ja: "カテゴリー#{i}", name_en: "Category#{i}", description: 'DESCRIPTION') }}

  before { driven_by(:selenium_chrome_headless) }

  describe 'GET categories' do
    before { visit categories_path }
    it 'カテゴリーの一覧が表示されること' do
      expect(page).to have_title('資格')
      table = page.find(:table)
      expect(table.find_xpath('thead/tr/th').map { |h| h.all_text} ).to eq(%w[カテゴリーID カテゴリー名 カテゴリー名（英語） 資格数 参照 編集 削除])
      expect(table.find_xpath('tbody/tr').size).to eq(initial_record)
      expect(table.find_xpath('tbody/tr')[0].find_xpath('td').map{ |c| c.all_text } ).to eq(["#{categories[0].id}", "#{categories[0].name_ja}", "#{categories[0].name_en}", "0", "参照", "編集", "削除"])
    end
    it '新規登録ボタンで登録画面へ遷移すること' do
      page.find('button', text: '新規登録', match: :first).click
      expect(page.all(:xpath, '//input[@value="保存"]').size).to eq(1)
      expect(page.current_path).to eq('/categories/new')
    end
    it '参照ボタンで詳細画面へ遷移すること' do
      page.find('button', text: '参照', match: :first).click
      expect(page.all(:xpath, '//div[@class="contents"]/a[@href="/categories"]').first&.text).to eq("一覧")
      expect(page.current_path).to match("/categories/\\d+")
    end
    it '編集ボタンで編集画面へ遷移すること' do
      page.find('button', text: '編集', match: :first).click
      expect(page.all(:xpath, '//input[@value="保存"]').size).to eq(1)
      expect(page.current_path).to match("/categories/\\d+/edit")
      expect(page.find_by_id('category_name_ja').value).to match('カテゴリー\\d+')
      expect(page.find_by_id('category_name_en').value).to match('Category\\d+')
      expect(page.find_by_id('category_description').value).to match('DESCRIPTION')
    end
  end

  describe 'POST categories' do
    let(:form_data) { { name_ja: 'カテゴリー', name_en: 'CATEGORY', description: 'TEST' } }
    before { visit new_category_path }
    it 'カテゴリーを登録できること' do
      form_data.each { |k,v| page.fill_in("category_#{k}", with: v) }
      page.all(:xpath, '//input[@type="submit"]')[0].click
      expect(Category.count).to eq(initial_record + 1)
    end
  end

  describe 'PATCH category' do
    let(:form_data) { { name_ja: 'カテゴリー_更新', name_en: 'CATEGORY', description: 'TEST' } }
    let(:target) { categories.last }
    before { visit edit_category_path(target.id) }
    it '認定機関情報を登録できること' do
      form_data.each { |k,v| page.fill_in("category_#{k}", with: v) }
      page.all(:xpath, '//input[@type="submit"]')[0].click
      expect(Category.count).to eq(initial_record)
      target.reload
      expect(target.name_ja).to eq(form_data[:name_ja])
      expect(target.name_en).to eq(form_data[:name_en])
      expect(target.description).to eq(form_data[:description])
    end
  end

  describe 'DELETE category' do
    before { visit categories_path }
    it do
      page.find('button', text: '削除', match: :first).click
      page.accept_confirm "削除してよろしいですか？"
      expect(page.current_path).to eq("/categories")
      expect(page.all(:xpath, '//div[@class="notice"]').first.text).to match(/削除しました/)
      expect(Category.all.count).to eq(initial_record - 1)
    end
  end
end
