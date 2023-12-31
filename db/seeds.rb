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

certificaters = { '経済産業大臣' => nil, '総務大臣' => nil, '観光庁長官' => nil, '総務省地域総合通信局長' => nil, '厚生労働省都道府県労働局長' => nil, '国土交通大臣' => nil, '国土地理院長' => nil, '独立行政法人情報処理推進機構' => nil,  '都道府県知事' => nil, '中央職業能力開発協会' => nil }
certificaters.each do |k, v|
  certificater = Certificater.find_or_create_by(name_ja: k)
  certificater.update(name_en: v) if v.present?
end

examiners = [ 
  { name: '国土交通省観光庁', address: '東京都千代田区霞が関2-1-2', url: 'https://www.mlit.go.jp/kankocho/' },
  { name: '独立行政法人情報処理推進機構', address: '東京都文京区本駒込二丁目28番8号　文京グリーンコートセンターオフィス', url: 'https://www.ipa.go.jp/' },
  { name: '公益財団法人安全衛生技術試験協会', address: '東京都千代田区西神田3-8-1　千代田ファーストビル東館９階', url: 'https://www.exam.or.jp/' },
  { name: '公益財団法人日本無線協会', address: '東京都中央区晴海3-3-3', url: 'https://www.nichimu.or.jp/' },
  { name: '公益財団法人日本データ通信協会', address: '東京都豊島区巣鴨2-11-1　ホウライ巣鴨ビル', url: 'https://www.dekyo.or.jp/' },
  { name: '一般社団法人全国旅行業協会', address: '東京都港区赤坂4丁目2-19 赤坂シャスタイーストビル3階', url: 'https://www.anta.or.jp/' },
  { name: '一般社団法人日本旅行業協会', address: '千代田区霞が関3-3-3 全日通霞が関ビル 3階', url: 'https://www.jata-net.or.jp/' },
  { name: '中央職業能力開発協会', address: '東京都新宿区西新宿七丁目５番２５号　西新宿プライムスクエア', url: 'https://www.javada.or.jp/' }
]
examiners.each do |attr|
  examiner = Examiner.find_or_create_by(name: attr[:name])
  examiner.update(**attr)
end

qualifications = [
  { name_ja: '情報処理技術者試験', category: 'ICT', classification: :national },
  { name_ja: '情報処理安全確保支援士', name_en: 'Registered Information Security Specialist', category: 'ICT', classification: :national },
  { name_ja: '陸上無線技術士', name_en: 'Technical Radio Operator for On-The-Ground Services', category: 'ICT', classification: :national },
  { name_ja: '総合無線通信士', name_en: 'Radio Operator for General Services', category: 'ICT', classification: :national, description: '海上、航空及び陸上の無線局の無線設備の操作を行うことができる総合的なもの' },
  { name_ja: '海上無線通信士', category: 'ICT', classification: :national },
  { name_ja: '航空無線通信士', name_en: 'Aeronautical Radio Operator', category: 'ICT', classification: :national },
  { name_ja: '陸上特殊無線技士', name_en: 'On-The-Ground Special Radio Operator', category: 'ICT', classification: :national },
  { name_ja: '海上特殊無線技士', category: 'ICT', classification: :national },
  { name_ja: '航空特殊無線技士', category: 'ICT', classification: :national },
  { name_ja: 'アマチュア無線技士', category: 'ICT', classification: :national },
  { name_ja: '旅行業務取扱管理者', category: '事務／法律', classification: :national },
  { name_ja: 'ボイラー技士', name_en: "boiler expert\'s license", category: '設備', classification: :national, description: '級の区分に関係なく、全てのボイラーを取扱うことができますが、ボイラー取扱い作業の指揮・管理を行うボイラー取扱作業主任者になるには、ボイラーの規模により必要な免許が異なります' },
  { name_ja: 'ビジネスキャリア検定（経営情報システム）', category: '事務／法律', classification: :official, description: 'ビジネス・キャリア検定試験では、ＩＴの活用、システム化計画と設計、システムの運用・管理、業務アプリケーションの選定・活用、情報活用に関する内容が範囲となります。なお、２級では、業務の分析・評価・改善やシステムの開発等をはじめとする「情報化企画」 と、情報の活用技術、システムの運用をはじめとする「情報化活用」に分かれています' },
  { name_ja: 'ビジネスキャリア検定（生産管理）', category: '事務／法律', classification: :official, description: '「生産管理」の仕事とは、資材の購入、製品の開発・設計・製造、顧客への引渡し、工場・設備の管理など生産活動全般に関わる管理を行う仕事のことです。ビジネス・キャリア検定試験では、主に生産管理部などで、生産システムの設計・計画業務に従事している方を対象とした「生産管理プランニング」と、生産システムの統制・運用業務に従事している方を対象とした「生産管理オペレーション」に区分しています' },
  { name_ja: 'ビジネスキャリア検定（ロジスティクス）', category: '事務／法律', classification: :official, description: '「ロジスティクス」の仕事とは、物の輸送や配送、保管や荷役、包装・在庫管理等に関する仕組みづくりと管理・運営に関する仕事です。ビジネス・キャリア検定試験では、主にロジスティクス部などで、ロジスティクス企画、生産・販売計画・在庫状況等を調整する需給管理、注文状況等を把握する業務管理に従事している方を対象とした「ロジスティクス管理」と、主に物流センターなどで、荷役・保管、流通加工・包装、輸配送管理業務に従事している方を対象とした「ロジスティクス・オペレーション」に区分しています。' },
  { name_ja: 'ビジネスキャリア検定（経営戦略）', category: '事務／法律', classification: :official, description: '「経営戦略」の仕事とは、経営環境に関する社内外の情報を収集・分析し、短期及び中長期の経営計画や事業再編、事業開発の計画等を策定する経営中枢のサポートを行う仕事です。また、経営企画実行のための組織体制の整備、実行結果の評価を行う仕事も含まれる場合もあります' },
  { name_ja: 'ビジネスキャリア検定（人事・人材開発・労務管理）', category: '事務／法律', classification: :official, description: '人員計画の作成、従業員の採用、就業管理、福利厚生、安全衛生、労使関係、人材育成など、その業務は幅広い領域に及びます' },
  { name_ja: 'ビジネスキャリア検定（企業法務・総務）', category: '事務／法律', classification: :official, description: '「企業法務・総務」の仕事とは、企業内外で法律判断を必要とする事項に関する対応措置の検討や法的問題の未然防止、紛争が発生した際の処理、社内管理、社外対応、社内外における企業コミュニケーションの円滑化など、経営全体の運営を推進またはサポートする仕事です' },
  { name_ja: 'ビジネスキャリア検定（営業・マーケティング）', category: '事務／法律', classification: :official, description: '「営業・マーケティング」の仕事とは、営業活動の推進、営業管理体制の構築、製品・価格・流通経路・販売促進計画の策定、広告・宣伝など、製品・サービスを売るための仕組み作り及び販売に関する仕事です。ビジネス・キャリア検定試験の1級では、評価対象が全社戦略の実現に向けた経営資源やリスク管理を行うマネジメント能力であることを踏まえ、試験分野を基本といたしました' },
  { name_ja: 'ビジネスキャリア検定（経理・財務管理）', category: '事務／法律', classification: :official, description: '「経理・財務管理」の仕事とは、財務諸表等の会計情報の作成と発信、資金調達と資金運営に係る計画作成・管理など、資金面での経営資源を管理する仕事です。ビジネス・キャリア検定試験では、主に経理部などで、会計伝票処理、納税申告、決算関係業務に従事している方を対象とした「経理」と、主に財務部などで、企業活動に必要な資金調達や経営分析関係業務に従事している方を対象とした「財務管理」に区分 しています。' }

]
qualifications.each do |q|
  qualification = Qualification.find_or_initialize_by(name_ja: q[:name_ja])
  qualification.update(name_en: q[:name_en], description: q[:description], classification: q[:classification], category: Category.find_by!(name_ja: q[:category]))
end

grades = [
  { grade_name: '国内', display_order: 2, qualification: '旅行業務取扱管理者', certificater: '観光庁長官', examiner: '一般社団法人全国旅行業協会', description: '国内旅行業務のみを取り扱うことができる' },
  { grade_name: '総合', display_order: 1, qualification: '旅行業務取扱管理者', certificater: '観光庁長官', examiner: '一般社団法人日本旅行業協会', description: '海外及び国内の旅行業務を取り扱うことができる' },
  { grade_name: '地域限定', display_order: 3, qualification: '旅行業務取扱管理者', certificater: '観光庁長官', examiner: '国土交通省観光庁' },
  { grade_name: '特級', display_order: 1, qualification: 'ボイラー技士', certificater: '厚生労働省都道府県労働局長', examiner: '公益財団法人安全衛生技術試験協会', description: '全ての規模のボイラー取扱作業主任者となることができる' },
  { grade_name: '一級', display_order: 2, qualification: 'ボイラー技士', certificater: '厚生労働省都道府県労働局長', examiner: '公益財団法人安全衛生技術試験協会', description: '伝熱面積の合計が500m2未満のボイラー取扱作業主任者となることができる' },
  { grade_name: '二級', display_order: 3, qualification: 'ボイラー技士', certificater: '厚生労働省都道府県労働局長', examiner: '公益財団法人安全衛生技術試験協会', description: '伝熱面積の合計が25m2未満のボイラー取扱作業主任者となることができる' },
  { grade_name: '第一級', display_order: 1, qualification: 'アマチュア無線技士', certificater: '総務大臣', examiner: '公益財団法人日本無線協会', description: 'アマチュア局のすべての無線設備の操作' },
  { grade_name: '第二級', display_order: 2, qualification: 'アマチュア無線技士', certificater: '総務大臣', examiner: '公益財団法人日本無線協会', description: 'アマチュア局の無線設備（空中線電力２００Ｗ以下のもの）の操作' },
  { grade_name: '第三級', display_order: 3, qualification: 'アマチュア無線技士', certificater: '総務省地域総合通信局長', examiner: '公益財団法人日本無線協会', description: 'アマチュア局の無線設備（空中線電力５０Ｗ以下であって、周波数が１８ＭＨｚ以上のもの又は８ＭＨｚ以下のもの）の操作' },
  { grade_name: '第四級', display_order: 4, qualification: 'アマチュア無線技士', certificater: '総務省地域総合通信局長', examiner: '公益財団法人日本無線協会', description: "アマチュア局の無線設備でモールス符号による通信を除く次のものの操作\n\n空中線電力１０Ｗ以下であって周波数が２１ＭＨｚから３０ＭＨｚまで又は８ＭＨｚ以下の無線設備\n空中線電力２０Ｗ以下であって周波数が３０ＭＨｚを超える無線設備" },
  { grade_name: '第一級', display_order: 1, qualification: '陸上特殊無線技士', certificater: '総務省地域総合通信局長', examiner: '公益財団法人日本無線協会', description: "電気通信業務用、公共業務用等の多重無線設備の固定局、基地局等の技術的操作（３０ＭＨｚ以上の電波を使用する空中線電力５００Ｗ以下のもの）\n第二級及び第三級の陸上特殊無線技士の操作の範囲に属するものの操作" },
  { grade_name: '第二級', display_order: 2, qualification: '陸上特殊無線技士', certificater: '総務省地域総合通信局長', examiner: '公益財団法人日本無線協会', description: "電気通信業務用の多重無線設備のＶＳＡＴ等小型の地球局の無線設備の技術的な操作（空中線電力５０Ｗ以下のもので外部の転換装置で電波の質に影響を及ぼさないもの等）\n多重無線設備を除く固定局、基地局、陸上移動局等の無線設備の技術的な操作（１,６０５ｋＨｚ～４,０００ｋＨｚの電波を使用する空中線電力１０Ｗ以下のもの）" },
  { grade_name: '第三級', display_order: 3, qualification: '陸上特殊無線技士', certificater: '総務省地域総合通信局長', examiner: '公益財団法人日本無線協会', description: "固定局、基地局、陸上移動局等の次の無線設備の技術的な操作\n２５,０１０ｋＨｚ～９６０ＭＨｚの電波を使用する空中線電力５０Ｗ以下のもの\n１，２１５ＭＨｚ以上の電波を使用する空中線電力１００Ｗ以下のもの" },
  { grade_name: '国内電信級', display_order: 4, qualification: '陸上特殊無線技士', certificater: '総務省地域総合通信局長', examiner: '公益財団法人日本無線協会', description: "固定局、基地局、陸上移動局等の無線電信で国内通信のための通信操作" },
  { grade_name: '第一級', display_order: 1, qualification: '陸上無線技術士', certificater: '総務大臣', examiner: '公益財団法人日本無線協会', description: "放送局、電気通信業務用等の固定局、無線測位局等すべての無線局の無線設備の技術的な操作" },
  { grade_name: '第二級', display_order: 2, qualification: '陸上無線技術士', certificater: '総務大臣', examiner: '公益財団法人日本無線協会', description: "放送局、電気通信業務用等の固定局、無線測位局等すべての無線局の無線設備の技術的な操作（テレビジョン放送局を除く無線局の空中線電力２ｋＷ以下のもの，テレビジョン放送局の空中線電力５００Ｗ以下のもの）" },
  { grade_name: '第一級', display_order: 1, qualification: '海上特殊無線技士', certificater: '総務省地域総合通信局長', examiner: '公益財団法人日本無線協会', description: "船舶局の無線電話とデジタル選択呼出装置で１,６０５ｋＨｚ～４,０００ｋＨｚの電波を使用する空中線電力７５Ｗ以下のものの操作\n船舶局の無線電話とデジタル選択呼出装置で２５,０１０ｋＨｚ以上の電波（国際ＶＨＦ等）を使用する空中線電力５０Ｗ以下のものの操作\n第二級海上特殊無線技士の操作の範囲のもの" },
  { grade_name: '第二級', display_order: 2, qualification: '海上特殊無線技士', certificater: '総務省地域総合通信局長', examiner: '公益財団法人日本無線協会', description: "海岸局及び船舶局の次の無線設備の国内通信のための操作\nア）１,６０５ｋＨｚ～４,０００ｋＨｚの電波を使用する空中線電力１０Ｗ以下のもの\nイ）２５,０１０ｋＨｚ以上の電波を使用する空中線電力５０Ｗ以下のもの\n海岸局及び船舶局のレーダーの操作" },
  { grade_name: '第三級', display_order: 3, qualification: '海上特殊無線技士', certificater: '総務省地域総合通信局長', examiner: '公益財団法人日本無線協会', description: "船舶局の次の無線設備の国内通信のための操作\n２５，０１０ｋＨｚ以上の電波を使用する空中線電力５Ｗ以下の無線電話\n船舶局の5kW以下のレーダーの操作" },
  { grade_name: 'レーダー級', display_order: 4, qualification: '海上特殊無線技士', certificater: '総務省地域総合通信局長', examiner: '公益財団法人日本無線協会', description: "船舶局のレーダーの操作" },
  { grade_name: nil, qualification: '航空特殊無線技士', certificater: '総務省地域総合通信局長', examiner: '公益財団法人日本無線協会', description: "航空機（航空運送事業の用に供する航空機を除きます。）に施設する無線設備の国内通信のための操作\n航空局（航空交通管制の用に供する航空局を除きます。）の無線設備の国内通信のための操作" },
  { grade_name: nil, qualification: '航空無線通信士', certificater: '総務大臣', examiner: '公益財団法人日本無線協会', description: "航空運送事業の用に供する航空機を含むすべての航空機に施設する無線設備の操作\n航空交通管制の用に供する航空局を含むすべての航空局や航空地球局の無線設備の操作\n航空機のための無線航行局の操作" },
  { grade_name: '第一級', display_order: 1, qualification: '海上無線通信士', certificater: '総務大臣', examiner: '公益財団法人日本無線協会', description: "船舶に施設する無線設備・海岸局や海岸地球局の無線設備（モールス電信を除く。）の操作" },
  { grade_name: '第二級', display_order: 2, qualification: '海上無線通信士', certificater: '総務大臣', examiner: '公益財団法人日本無線協会', description: "船舶に施設する無線設備・海岸局や海岸地球局の無線設備（モールス電信を除く。）の操作" },
  { grade_name: '第三級', display_order: 3, qualification: '海上無線通信士', certificater: '総務大臣', examiner: '公益財団法人日本無線協会', description: "船舶に施設する無線設備・海岸局や海岸地球局の無線設備（モールス電信を除く。）の操作" },
  { grade_name: '第四級', display_order: 4, qualification: '海上無線通信士', certificater: '総務大臣', examiner: '公益財団法人日本無線協会', description: "海岸局や漁船等の船舶に施設する無線設備（船舶地球局のものを除く。）の国内通信のための操作\n船舶のレーダーの外部の転換装置で電波の質に影響を及ぼさないものの操作" },
  { grade_name: '第一級', display_order: 1, qualification: '総合無線通信士', certificater: '総務大臣', examiner: '公益財団法人日本無線協会', description: "船舶と航空機に施設する無線設備（モールス電信を含む。）の操作\n海上と航空関係の無線局（海岸局、海岸地球局、航空局、航空地球局等）の無線設備（モールス電信を含む。）の操作\n陸上の無線局（固定局、陸上局、移動局、無線測位局、放送局等）の無線設備の操作" },
  { grade_name: '第二級', display_order: 2, qualification: '総合無線通信士', certificater: '総務大臣', examiner: '公益財団法人日本無線協会', description: "航空関係の無線局（航空局、航空地球局、航空機局、航空機地球局）の無線設備の操作\n船舶に施設する無線設備、海岸局の無線設備等（モールス電信を含みます。）の国内通信のための操作\n船舶に施設する無線設備（モールス電信を含みます。）の国際通信のための操作\n放送局を除く固定局、基地局、無線測位局等の無線設備の技術的な操作" },
  { grade_name: '第三級', display_order: 3, qualification: '総合無線通信士', certificater: '総務大臣', examiner: '公益財団法人日本無線協会', description: "漁船に施設する無線設備（モールス電信を含み、無線電話を除きます。）の国内通信と国際通信（電気通信業務の通信を除きます。）の操作\n漁船に施設する無線設備の国内通信の操作\n船舶（漁船を除く。）に施設する無線設備の国内通信の操作\n漁業用海岸局の無線設備（モールス電信を含みます。）の操作\n放送局を除く固定局、基地局等の無線設備の国内通信のための操作" },
  { grade_name: '基本情報技術者', qualification: '情報処理技術者試験', certificater: '経済産業大臣', examiner: '独立行政法人情報処理推進機構' },
  { grade_name: '応用情報技術者', qualification: '情報処理技術者試験', certificater: '経済産業大臣', examiner: '独立行政法人情報処理推進機構' },
  { grade_name: 'システムアーキテクト', qualification: '情報処理技術者試験', certificater: '経済産業大臣', examiner: '独立行政法人情報処理推進機構' },
  { grade_name: 'ネットワークスペシャリスト', qualification: '情報処理技術者試験', certificater: '経済産業大臣', examiner: '独立行政法人情報処理推進機構' },
  { grade_name: 'エンベデッドシステムスペシャリスト', qualification: '情報処理技術者試験', certificater: '経済産業大臣', examiner: '独立行政法人情報処理推進機構' },
  { grade_name: 'データベースアーキテクト', qualification: '情報処理技術者試験', certificater: '経済産業大臣', examiner: '独立行政法人情報処理推進機構' },
  { grade_name: 'ＩＴパスポート', qualification: '情報処理技術者試験', certificater: '経済産業大臣', examiner: '独立行政法人情報処理推進機構' },
  { grade_name: 'ＩＴストラテジスト', qualification: '情報処理技術者試験', certificater: '経済産業大臣', examiner: '独立行政法人情報処理推進機構' },
  { grade_name: 'ＩＴサービスマネージャ', qualification: '情報処理技術者試験', certificater: '経済産業大臣', examiner: '独立行政法人情報処理推進機構' },
  { grade_name: 'システム監査技術者', qualification: '情報処理技術者試験', certificater: '経済産業大臣', examiner: '独立行政法人情報処理推進機構' },
  { grade_name: '情報セキュリティマネジメント', qualification: '情報処理技術者試験', certificater: '経済産業大臣', examiner: '独立行政法人情報処理推進機構' },
  { grade_name: 'プロジェクトマネージャ', qualification: '情報処理技術者試験', certificater: '経済産業大臣', examiner: '独立行政法人情報処理推進機構' },
  { grade_name: nil, qualification: '情報処理安全確保支援士', certificater: '経済産業大臣', examiner: '独立行政法人情報処理推進機構', description: '情報セキュリティマネジメントに関する業務、情報システムの企画・設計・開発・運用におけるセキュリティ確保に関する業務、情報及び情報システムの利用におけるセキュリティ対策の適用に関する業務、情報セキュリティインシデント管理に関する業務に従事し、次の役割を主導的に果たすとともに、下位者を指導する' },
  { grade_name: '１級', display_order: 1, qualification: 'ビジネスキャリア検定（経営情報システム）', certificater: '中央職業能力開発協会', examiner: '中央職業能力開発協会' },
  { grade_name: '２級（情報化企画）', display_order: 2, qualification: 'ビジネスキャリア検定（経営情報システム）', certificater: '中央職業能力開発協会', examiner: '中央職業能力開発協会' },
  { grade_name: '２級（情報化活用）', display_order: 2, qualification: 'ビジネスキャリア検定（経営情報システム）', certificater: '中央職業能力開発協会', examiner: '中央職業能力開発協会' },
  { grade_name: '３級', display_order: 3, qualification: 'ビジネスキャリア検定（経営情報システム）', certificater: '中央職業能力開発協会', examiner: '中央職業能力開発協会' },
]
grades.each do |g|
  grade = Grade.find_or_initialize_by(grade_name: g[:grade_name], qualification: Qualification.find_by!(name_ja: g[:qualification]))
  grade.update(examiner: Examiner.find_by!(name: g[:examiner]), certificater: Certificater.find_by!(name_ja: g[:certificater]), display_order: g[:display_order] || 0, description: g[:description])
end