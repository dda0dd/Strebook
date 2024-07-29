# Strebook

## サイト概要
### サイトテーマ
お客様の要望やアイデアを書店に届けるレビューサイト

​
### テーマを選んだ理由
現在、全国で書店が減少しています。<br>
昨年では閉店や廃業した書店が600店以上にのぼりました。<br>
私はその現状を危惧したため、書店の魅力を向上させるアイデアを得ることができるアプリを考案しました。<br>
普段から書店を利用されるお客様から要望やアイデアなどをリクエストという形で全国の書店に送ることができます。
その結果、お客様目線からしか得ることができない情報を書店は知ることができます。<br>
そして、書店を普段から利用されない新規のお客様からはリクエストを通して書店を利用されない理由を知ることができます。
また、リクエストをいただくことで短期的に集客の見込みを立てることができたり、書店の魅力を向上するアイデアの糸口に繋がるのではと思っております。<br>
上記の理由から、このアプリが書店の現状に変化をもたらすことができればと思っています。

### ターゲットユーザ
- 普段から書店を利用されるお客様
- 書店を利用したい新規のお客様
- 存続を望んでいる書店

### 主な利用シーン
- 書店に直接的には伝えられないことがある時
- 書店に対して要望やアイデアを届けたい時
- 集客に繋がるアイデアが欲しい時

​
## 設計書
[書店_ワイヤーフレーム](https://docs.google.com/presentation/d/1eYAUZ9uFlkgzJsFpPh0HIg0Frkn_GJxfAG5s8sgDygE/edit?usp=sharing)<br>
[お客様_ワイヤーフレーム](https://docs.google.com/presentation/d/1nGnmMtsehMaxWCP29ULespJ3JSMVoqNGhO13G0cjCFY/edit?usp=sharing)<br>
[管理者_ワイヤーフレーム](https://docs.google.com/presentation/d/17AFjSaSlMKYYr6koW9bqfGLSvcR0mzx0v87Y3D390lQ/edit?usp=sharing)<br>
[ER図](https://drive.google.com/file/d/1gBCmwvh7WyQyYyYRJJuEPNUjIKLnK1yW/view?usp=sharing)<br>
[テーブル定義書](https://docs.google.com/spreadsheets/d/1kVTP7P_jZhXfljEi1gblqYP3oigrRlMr/edit?usp=sharing&ouid=106064071708209530349&rtpof=true&sd=true)<br>
[アプリケーション詳細設計書](https://docs.google.com/spreadsheets/d/19hodQoZWf1QiyHk25_sqQ3rzxAR-35hV3RODUHIME3U/edit?usp=sharing)


## 実装機能
1. 会員機能<br>
お客様(customer)<br>
書店(book_store)はタグ機能も実装
2. ゲストログイン<br>
お客様(guestcustomer), 書店(guestbook_store)
3. 投稿機能<br>
書店(book_store)
4. 投稿検索機能(キーワード検索)<br>
お客様(customer), 管理者(admin)
5. コメント機能(星でレビュー機能も実装)<br>
お客様(customer)
6. タグ検索機能<br>
お客様(customer), 管理者(admin)
7. ユーザ管理機能<br>
管理者(admin)
8. ユーザ検索機能<br>
管理者(admin)

## 開発環境
- OS：Linux(CentOS)
- 言語：HTML,CSS,JavaScript,Ruby,SQL
- フレームワーク：Ruby on Rails
- JSライブラリ：jQuery
- IDE：Cloud9

## 使用素材
使用している画像はChatGPTで作成したものです。

なお今後、実在するデータを利用する際には、事前に著作権保持者と契約を結んだ上で利用します。
