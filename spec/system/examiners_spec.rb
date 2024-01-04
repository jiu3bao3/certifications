require 'rails_helper'

RSpec.describe "Examiners", type: :system, js: true do
  let!(:examiners) { Array.new(3) { |i| create(:examiner, name: "試験実施機関#{i}") }}

  before { driven_by(:rack_test) }

  describe 'GET examiners' do
    before { visit examiners_path }
    it '資格認定機関一覧が表示されていること' do
      expect(page).to have_title('資格')
      table = page.find_by_id('examiners_table')
      expect(table.all('thead/tr/th').map { |h| h.text} ).to eq(%w[試験実施機関ID 試験実施機関名 所在地 参照 編集 削除])
      expect(table.all('tbody/tr').size).to eq(examiners.size)
      expect(table.all('tbody/tr')[0].all('td').map{ |c| c.text } ).to eq(["#{examiners[0].id}", "#{examiners[0].name}", "#{examiners[0].address}", "参照", "編集", "削除"])
    end
    it '新規登録ボタンで登録画面へ遷移すること' do
      expect(page).to have_button('new_examiner_button')
      new_examiner_button = page.all('new_examiner_button')
      page.all('button').filter { |b| b.text == '新規登録' }[0].click
      expect(page.current_path).to eq('/examiners/new')
    end
    it '参照ボタンで詳細画面へ遷移すること' do
      show_examiner_button = page.find_by_id('examiners_table').all('tbody/tr')[0].all('td')[3].find('button')
      expect(show_examiner_button.text).to eq("参照")
      show_examiner_button.click
      expect(page.current_path).to eq("/examiners/#{examiners[0].id}")
    end
    it '編集ボタンで編集画面へ遷移すること' do
      edit_examiner_button = page.find_by_id('examiners_table').all('tbody/tr')[0].all('td')[4].find('button')
      expect(edit_examiner_button.text).to eq("編集")
      edit_examiner_button.click
      expect(page.current_path).to eq("/examiners/#{examiners[0].id}/edit")
    end
    xit '削除ボタンで試験実施機関情報が削除されること' do
      destroy_examiner_button = page.find_by_id('examiners_table').all('tbody/tr')[0].all('td')[5].find('button')
      expect(destroy_examiner_button.text).to eq("削除")
      destroy_examiner_button.click
      accept_alert do
        click_link 'OK'
      end
      expect(page.current_path).to eq("/examiners")
    end
  end
end
