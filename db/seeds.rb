# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
categories = { 'ICT' => 'ICT', '設備' => 'Equipment', '工業' => 'Industory', '教養／語学' => 'Liberal Arts', '事務／法律' => 'Business and Law' }
categories.each do |k, v|
  category = Category.find_or_create_by(name_ja: k)
  category.update(name_en: v)
end

certificaters = { '経済産業大臣' => nil, '総務大臣' => nil, '総務省地域総合通信局長' => nil, '国土交通大臣' => nil, '国土地理院長' => nil, '都道府県知事' => nil }
certificaters.each do |k, v|
  certificater = Certificater.find_or_create_by(name_ja: k)
  certificater.update(name_en: v) if v.present?
end

examiners = [ 
  { name: '独立行政法人情報処理推進機構', address: '東京都文京区本駒込二丁目28番8号　文京グリーンコートセンターオフィス', url: 'https://www.ipa.go.jp/' },
  { name: '公益財団法人安全衛生技術試験協会', address: '東京都千代田区西神田3-8-1　千代田ファーストビル東館９階', url: 'https://www.exam.or.jp/' },
  { name: '公益財団法人日本無線協会', address: '東京都中央区晴海3-3-3', url: 'https://www.nichimu.or.jp/' },
  { name: '公益財団法人日本データ通信協会', address: '東京都豊島区巣鴨2-11-1　ホウライ巣鴨ビル', url: 'https://www.dekyo.or.jp/' }
]
examiners.each do |attr|
  examiner = Examiner.find_or_create_by(name: attr[:name])
  examiner.update(**attr)
end

qualifications = [
  { name_ja: '陸上無線技術士', category: 'ICT', classification: :national },
  { name_ja: '総合無線通信士', category: 'ICT', classification: :national, description: '海上、航空及び陸上の無線局の無線設備の操作を行うことができる総合的なもの' },
  { name_ja: '海上無線通信士', category: 'ICT', classification: :national },
  { name_ja: '航空無線通信士', category: 'ICT', classification: :national },
  { name_ja: '陸上特殊無線技士', category: 'ICT', classification: :national },
  { name_ja: '海上特殊無線技士', category: 'ICT', classification: :national },
  { name_ja: '航空特殊無線技士', category: 'ICT', classification: :national },
  { name_ja: 'アマチュア無線技士', category: 'ICT', classification: :national }
]
qualifications.each do |q|
  qualification = Qualification.find_or_initialize_by(name_ja: q[:name_ja])
  qualification.update(classification: q[:classification], category: Category.find_by!(name_ja: q[:category]))
end

grades = [
  { grade_name: '第一級', qualification: 'アマチュア無線技士', certificater: '総務大臣', examiner: '公益財団法人日本無線協会', description: 'アマチュア局のすべての無線設備の操作' },
  { grade_name: '第二級', qualification: 'アマチュア無線技士', certificater: '総務大臣', examiner: '公益財団法人日本無線協会', description: 'アマチュア局の無線設備（空中線電力２００Ｗ以下のもの）の操作' },
  { grade_name: '第三級', qualification: 'アマチュア無線技士', certificater: '総務省地域総合通信局長', examiner: '公益財団法人日本無線協会', description: 'アマチュア局の無線設備（空中線電力５０Ｗ以下であって、周波数が１８ＭＨｚ以上のもの又は８ＭＨｚ以下のもの）の操作' },
  { grade_name: '第四級', qualification: 'アマチュア無線技士', certificater: '総務省地域総合通信局長', examiner: '公益財団法人日本無線協会', description: "アマチュア局の無線設備でモールス符号による通信を除く次のものの操作\n\n空中線電力１０Ｗ以下であって周波数が２１ＭＨｚから３０ＭＨｚまで又は８ＭＨｚ以下の無線設備\n空中線電力２０Ｗ以下であって周波数が３０ＭＨｚを超える無線設備" },
  { grade_name: '第一級', qualification: '陸上特殊無線技士', certificater: '総務省地域総合通信局長', examiner: '公益財団法人日本無線協会', description: "電気通信業務用、公共業務用等の多重無線設備の固定局、基地局等の技術的操作（３０ＭＨｚ以上の電波を使用する空中線電力５００Ｗ以下のもの）\n第二級及び第三級の陸上特殊無線技士の操作の範囲に属するものの操作" },
  { grade_name: '第二級', qualification: '陸上特殊無線技士', certificater: '総務省地域総合通信局長', examiner: '公益財団法人日本無線協会', description: "電気通信業務用の多重無線設備のＶＳＡＴ等小型の地球局の無線設備の技術的な操作（空中線電力５０Ｗ以下のもので外部の転換装置で電波の質に影響を及ぼさないもの等）\n多重無線設備を除く固定局、基地局、陸上移動局等の無線設備の技術的な操作（１,６０５ｋＨｚ～４,０００ｋＨｚの電波を使用する空中線電力１０Ｗ以下のもの）" },
  { grade_name: '第三級', qualification: '陸上特殊無線技士', certificater: '総務省地域総合通信局長', examiner: '公益財団法人日本無線協会', description: "固定局、基地局、陸上移動局等の次の無線設備の技術的な操作\n２５,０１０ｋＨｚ～９６０ＭＨｚの電波を使用する空中線電力５０Ｗ以下のもの\n１，２１５ＭＨｚ以上の電波を使用する空中線電力１００Ｗ以下のもの" },
  { grade_name: '国内電信級', qualification: '陸上特殊無線技士', certificater: '総務省地域総合通信局長', examiner: '公益財団法人日本無線協会', description: "固定局、基地局、陸上移動局等の無線電信で国内通信のための通信操作" },
  { grade_name: '第一級', qualification: '陸上無線技術士', certificater: '総務大臣', examiner: '公益財団法人日本無線協会', description: "放送局、電気通信業務用等の固定局、無線測位局等すべての無線局の無線設備の技術的な操作" },
  { grade_name: '第二級', qualification: '陸上無線技術士', certificater: '総務大臣', examiner: '公益財団法人日本無線協会', description: "放送局、電気通信業務用等の固定局、無線測位局等すべての無線局の無線設備の技術的な操作（テレビジョン放送局を除く無線局の空中線電力２ｋＷ以下のもの，テレビジョン放送局の空中線電力５００Ｗ以下のもの）" },
  { grade_name: '第一級', qualification: '海上特殊無線技士', certificater: '総務省地域総合通信局長', examiner: '公益財団法人日本無線協会', description: "船舶局の無線電話とデジタル選択呼出装置で１,６０５ｋＨｚ～４,０００ｋＨｚの電波を使用する空中線電力７５Ｗ以下のものの操作\n船舶局の無線電話とデジタル選択呼出装置で２５,０１０ｋＨｚ以上の電波（国際ＶＨＦ等）を使用する空中線電力５０Ｗ以下のものの操作\n第二級海上特殊無線技士の操作の範囲のもの" },
  { grade_name: '第二級', qualification: '海上特殊無線技士', certificater: '総務省地域総合通信局長', examiner: '公益財団法人日本無線協会', description: "海岸局及び船舶局の次の無線設備の国内通信のための操作\nア）１,６０５ｋＨｚ～４,０００ｋＨｚの電波を使用する空中線電力１０Ｗ以下のもの\nイ）２５,０１０ｋＨｚ以上の電波を使用する空中線電力５０Ｗ以下のもの\n海岸局及び船舶局のレーダーの操作" },
  { grade_name: '第三級', qualification: '海上特殊無線技士', certificater: '総務省地域総合通信局長', examiner: '公益財団法人日本無線協会', description: "船舶局の次の無線設備の国内通信のための操作\n２５，０１０ｋＨｚ以上の電波を使用する空中線電力５Ｗ以下の無線電話\n船舶局の5kW以下のレーダーの操作" },
  { grade_name: 'レーダー級', qualification: '海上特殊無線技士', certificater: '総務省地域総合通信局長', examiner: '公益財団法人日本無線協会', description: "船舶局のレーダーの操作" },
  { grade_name: '', qualification: '航空特殊無線技士', certificater: '総務省地域総合通信局長', examiner: '公益財団法人日本無線協会', description: "航空機（航空運送事業の用に供する航空機を除きます。）に施設する無線設備の国内通信のための操作\n航空局（航空交通管制の用に供する航空局を除きます。）の無線設備の国内通信のための操作" },
  { grade_name: '', qualification: '航空無線通信士', certificater: '総務大臣', examiner: '公益財団法人日本無線協会', description: "航空運送事業の用に供する航空機を含むすべての航空機に施設する無線設備の操作\n航空交通管制の用に供する航空局を含むすべての航空局や航空地球局の無線設備の操作\n航空機のための無線航行局の操作" },
  { grade_name: '第一級', qualification: '海上無線通信士', certificater: '総務大臣', examiner: '公益財団法人日本無線協会', description: "船舶に施設する無線設備・海岸局や海岸地球局の無線設備（モールス電信を除く。）の操作" },
  { grade_name: '第二級', qualification: '海上無線通信士', certificater: '総務大臣', examiner: '公益財団法人日本無線協会', description: "船舶に施設する無線設備・海岸局や海岸地球局の無線設備（モールス電信を除く。）の操作" },
  { grade_name: '第三級', qualification: '海上無線通信士', certificater: '総務大臣', examiner: '公益財団法人日本無線協会', description: "船舶に施設する無線設備・海岸局や海岸地球局の無線設備（モールス電信を除く。）の操作" },
  { grade_name: '第四級', qualification: '海上無線通信士', certificater: '総務大臣', examiner: '公益財団法人日本無線協会', description: "海岸局や漁船等の船舶に施設する無線設備（船舶地球局のものを除く。）の国内通信のための操作\n船舶のレーダーの外部の転換装置で電波の質に影響を及ぼさないものの操作" },
  { grade_name: '第一級', qualification: '総合無線通信士', certificater: '総務大臣', examiner: '公益財団法人日本無線協会', description: "船舶と航空機に施設する無線設備（モールス電信を含む。）の操作\n海上と航空関係の無線局（海岸局、海岸地球局、航空局、航空地球局等）の無線設備（モールス電信を含む。）の操作\n陸上の無線局（固定局、陸上局、移動局、無線測位局、放送局等）の無線設備の操作" },
  { grade_name: '第二級', qualification: '総合無線通信士', certificater: '総務大臣', examiner: '公益財団法人日本無線協会', description: "航空関係の無線局（航空局、航空地球局、航空機局、航空機地球局）の無線設備の操作\n船舶に施設する無線設備、海岸局の無線設備等（モールス電信を含みます。）の国内通信のための操作\n船舶に施設する無線設備（モールス電信を含みます。）の国際通信のための操作\n放送局を除く固定局、基地局、無線測位局等の無線設備の技術的な操作" },
  { grade_name: '第三級', qualification: '総合無線通信士', certificater: '総務大臣', examiner: '公益財団法人日本無線協会', description: "漁船に施設する無線設備（モールス電信を含み、無線電話を除きます。）の国内通信と国際通信（電気通信業務の通信を除きます。）の操作\n漁船に施設する無線設備の国内通信の操作\n船舶（漁船を除く。）に施設する無線設備の国内通信の操作\n漁業用海岸局の無線設備（モールス電信を含みます。）の操作\n放送局を除く固定局、基地局等の無線設備の国内通信のための操作" },
]
grades.each do |g|
  grade = Grade.find_or_initialize_by(grade_name: g[:grade_name], qualification: Qualification.find_by!(name_ja: g[:qualification]))
  grade.update(examiner: Examiner.find_by!(name: g[:examiner]), certificater: Certificater.find_by!(name_ja: g[:certificater]), description: g[:description])
end