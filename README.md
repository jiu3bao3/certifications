# README

## 概要
資格情報を管理するRuby on Railsサンプルアプリケーション

Docker上で起動し，ブラウザで [http://localhost:3000/](http://localhost:3000/) にアクセスする

<details>
<summary>画面の例</summary>

* 資格一覧画面
![資格一覧画面](public/images/qualifications.jpg)

* 資格詳細画面
![資格詳細画面](public/images/detail.jpg)

* 試験実施機関情報更新画面
![試験実施機関情報更新画面](public/images/examiner.jpg)

</details>

<details>
<summary>RSpec</summary>

```
root@fee6deda187a:/app# bundle exec rspec

Examiner
  validation
    エラーなく更新できること
    不正な名称
      is expected to raise ActiveRecord::RecordInvalid with message matching /試験実施機関名を入力してください/
      is expected to raise ActiveRecord::RecordInvalid with message matching /試験実施機関名はすでに存在します/
    不正な郵便番号
      behaves like invalid_zipcode
        is expected to raise ActiveRecord::RecordInvalid with message matching /郵便番号は不正な値です/
      behaves like invalid_zipcode
        is expected to raise ActiveRecord::RecordInvalid with message matching /郵便番号は不正な値です/
      behaves like invalid_zipcode
        is expected to raise ActiveRecord::RecordInvalid with message matching /郵便番号は不正な値です/
      behaves like invalid_zipcode
        is expected to raise ActiveRecord::RecordInvalid with message matching /郵便番号は不正な値です/
    不正な電話番号
      behaves like invalid_tel
        is expected to raise ActiveRecord::RecordInvalid with message matching /電話番号は不正な値です/
      behaves like invalid_tel
        is expected to raise ActiveRecord::RecordInvalid with message matching /電話番号は不正な値です/
      behaves like invalid_tel
        is expected to raise ActiveRecord::RecordInvalid with message matching /電話番号は不正な値です/
    不正な法人番号
      behaves like invalid_corporate_number
        is expected to raise ActiveRecord::RecordInvalid with message matching /法人番号は整数で入力してください/
      behaves like invalid_corporate_number
        is expected to raise ActiveRecord::RecordInvalid with message matching /法人番号は数値で入力してください/
    不正なURL
      behaves like invalid_url
        is expected to raise ActiveRecord::RecordInvalid with message matching /URLは不正な値です/
      behaves like invalid_url
        is expected to raise ActiveRecord::RecordInvalid with message matching /URLは不正な値です/

Finished in 3.68 seconds (files took 16.08 seconds to load)
14 examples, 0 failures

root@fee6deda187a:/app# 
```
</details>

## 環境
* Ruby: 3.3
* Rails: 7.1.2
* MySQL: 8.0

## 更新履歴
* 2023.12.30 新規作成
