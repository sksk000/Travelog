# Travelog
![travelog_logo_white](https://github.com/user-attachments/assets/ccafd6f0-e309-4fb1-a1f5-fab9019f0917)
# 概要
URL: https://travelog.sagglenix.com/
### サイトのテーマ
- 旅行プランのレビューサイト。
- 自身の旅行プランの記録及び共有、他ユーザの投稿した旅行プランを閲覧しての情報収集、コメント機能でのユーザ間交流を主機能とする。
- 旅行プランは地図上のマーカーをベースに、画像も交えてグラフィカルに共有及び参照できるようにする。

### テーマを選んだ理由
- ある旅行の後日、当時確かに訪れた訪問地について失念してしまい、旅行の全容を追想できず心残りのある経験をしました。
- これを受けて、訪問地毎に画像やテキスト等による詳細情報や訪問順についてシステム的に管理することで、旅行当時について鮮明に思い返せるようになると考えました。
- 上記に加え、他人の旅行行程や訪問地等の投稿を閲覧することで、次回の旅行計画時の参考となるサイトを作成したいと思い、本テーマを選定しました。

### ターゲットユーザ
- 旅行後、自身の旅行を思い返す為に記録しておきたい人
  - 各訪問地について、訪問順ベースで写真やテキスト情報とともに記録を残す。
- 他人の旅行計画を参照し、次の旅行計画の参考にしたい人
  - 他人の投稿した旅行行程について、観光地や季節等の情報を交えて検索し、参照する。

# 設計書
### ER図
![ポートフォリオ_ER図 drawio (1)](https://github.com/user-attachments/assets/1f27061b-579e-499c-b9f8-6bac94758e1d)


### UIフロー図
![ポートフォリオ制作_UIFlows_ drawio](https://github.com/user-attachments/assets/158cc7cc-a922-4aed-be50-7a17318def66)


### アプリケーション詳細設計書
![image]![image](https://github.com/user-attachments/assets/1a0fb7a4-14e1-41fd-9148-199489d1bd2b)


### テーブル定義書
https://docs.google.com/spreadsheets/d/1qXiKlpyrYHdSDIMqwMFumkS4Jl1uj7081Eztgk77d_8/edit?usp=drive_link

### AWS構成図
![Travelog_AWS構成図 drawio (1)](https://github.com/user-attachments/assets/1c3b01d9-1420-4a52-b87b-36d16f8f73d9)

# 使用技術
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

# 開発環境
- OS：Linux(CentOS, AmazonLinux2)
- 言語：HTML,CSS,JavaScript,Ruby,SQL
- フレームワーク：Ruby on Rails
- JS ライブラリ：jQuery
- IDE：Cloud9

# 使用素材
- サービス内で使用している画像は、以下サイト様上のフリー素材を利用しています。
  - [Unsplash](https://unsplash.com/ja) 様
  - [ぱくたそ](https://www.pakutaso.com/) 様
  - [いらすとや](https://www.irasutoya.com/) 様
  - [写真AC](https://www.photo-ac.com/)様
- 尚、本番環境上にてユーザ様が投稿した画像については、この限りではありません。
