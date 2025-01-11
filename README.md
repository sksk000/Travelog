# Travelog

## サイト概要
サイトURL: https://travelog.sagglenix.com/
### サイトのテーマ
- 旅行プランのレビューサイト
- 自身の旅行プランの共有、他ユーザの投稿した旅行プランを閲覧しての情報収集、コメント機能でのユーザ間交流を主機能とする。
- 旅行プランは地図上のマーカーをベースに、画像も交えてグラフィカルに共有できるようにする。

### テーマを選んだ理由
- 友達と旅行中、計画通りに訪れたい場所に行けないこと、訪れても想定と異なることがあったため
- 実際に旅行へ行った方の旅行プランや、旅行してみて気づいたこと・注意すべき点などを共有できるサービスを作ることで
私と同じような経験をせず、楽しい旅行を行えると考えました。

### ターゲットユーザ
- 旅行計画中で、どこへ行くか・旅行プランを悩んでいる人
- 旅行先は決め、行きたい所についての情報収集したい人

### 主な利用シーン
- 旅行計画時に候補に上がった行き先を検索
- 行きたいお店や泊まりたいホテルで検索

## 設計書
### ER図
![ポートフォリオ_ER図 drawio (1)](https://github.com/user-attachments/assets/1f27061b-579e-499c-b9f8-6bac94758e1d)


### UIフロー図
![ポートフォリオ制作_UIFlows_ drawio (1)](https://github.com/user-attachments/assets/ce43c67e-e259-46c9-bdba-d0ca931ef4d7)


### アプリケーション詳細設計書
![image](https://github.com/user-attachments/assets/599514f8-5ade-4591-b95f-fc88dd4bbfad)


### テーブル定義書
https://docs.google.com/spreadsheets/d/1qXiKlpyrYHdSDIMqwMFumkS4Jl1uj7081Eztgk77d_8/edit?usp=drive_link

### AWS構成図
![Travelog_AWS構成図 drawio (1)](https://github.com/user-attachments/assets/1c3b01d9-1420-4a52-b87b-36d16f8f73d9)


## 使用技術
- フロントエンド
  - HTML,CSS,JavaScript,Bootstrap4
- バックエンド
  - Ruby
- フレームワーク
  - Ruby on Rails
- 使用Gem
  - devise, geocoder, activerecord-import, gretel, stimulus-rails, faker, factory_bot_rails
- データベース
  - MySQL(本番環境),SQLite(開発環境)
- JS ライブラリ
  - jQuery, Stimulus
- IDE
  - Cloud9
- インフラ
  - Amazon Web Services(EC2, IAM, RDS, Route53)

## 開発環境
- OS：Linux(CentOS)
- 言語：HTML,CSS,JavaScript,Ruby,SQL,
- フレームワーク：Ruby on Rails
- JS ライブラリ：jQuery
- IDE：Cloud9

## 使用素材
- Unsplash様
- ぱくたそ様
- いらすとや様<br>
他のユーザが投稿した画像については、この限りではありません。
