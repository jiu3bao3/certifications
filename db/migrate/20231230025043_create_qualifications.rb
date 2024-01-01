class CreateQualifications < ActiveRecord::Migration[7.1]
  def change
    create_table :categories, comment: 'カテゴリー' do |t|
      t.string :name_ja, null: false, comment: 'カテゴリー名'
      t.string :name_en, null: true, comment: 'カテゴリー英語名'
      t.integer :qualifications_count, null: false, default: 0, comment: '登録資格数（counter cache用）'
      t.timestamps
    end

    create_table :certificaters, comment: '認定者' do |t|
      t.string :name_ja, null: false, comment: '認定者名'
      t.string :name_en, null: true, comment: '認定者英語名'
      t.timestamps
    end

    create_table :examiners, comment: '試験実施者' do |t|
      t.string :name, null: false, comment: '試験実施者名'
      t.bigint :corporate_number, null: true, comment: '法人番号'
      t.string :zipcode, null: true, comment: '郵便番号'
      t.string :address, null: true, comment: '所在地'
      t.string :url, null: true, comment: 'URL'
      t.string :tel, null: true, comment: '電話番号'
      t.timestamps
    end

    create_table :qualifications, comment: '資格' do |t|
      t.string :name_ja, null: false, comment: '資格名'
      t.string :name_en, null: true, comment: '資格英語名'
      t.integer :classification, null: false, default: 0, comment: '区分'
      t.text :description, null: true, comment: '説明'
      t.references :category, null: false, foreign_key: true, comment: 'カテゴリー'
      t.timestamps
    end

    create_table :grades, comment: 'グレード' do |t|
      t.references :qualification, null: false, foreign_key: true, comment: '資格ID'
      t.string :grade_name, null: true, comment: 'グレード'
      t.integer :display_order, null: false, default: 0, comment: '表示順'
      t.string :description, null: true, comment: '説明'
      t.references :certificater, null: false, foreign_key: true, comment: '認定者'
      t.references :examiner, null: true, foreign_key: true, comment: '試験実施者'
      t.timestamps
    end

    add_index :grades, %i[qualification_id grade_name], unique: true
  end
end
