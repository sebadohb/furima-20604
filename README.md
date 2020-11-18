
# テーブル設計

## users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| nickname           | string | null: false |
| email              | string | null: false |
| encrypted_password | string | null: false |
| first_name         | string | null: false |
| last_name          | string | null: false |
| first_name_kana    | string | null: false |
| last_name_kana     | string | null: false |
| birth_date         | date   | null: false |

 ## Association
 - has_many : items
 - has_many : purchases 


## items テーブル

| Column             | Type         | Options                         |
| ------------------ | ------------ | ------------------------------- |
| user               | references   | null: false, foreign_key: true  |
| name               | string       | null: false                     |
| description        | text         | null: false                     |
| category_id        | integer      | null: false                     |
| condition_id       | integer      | null: false                     |
| price              | integer      | null: false                     |
| prefecture_id      | integer      | null: false                     |
| handling_time_id   | integer      | null: false                     |
| delivery_charge_id | integer      | null: false                     |


 ## Association
 - belongs_to :user
 - belongs_to :category
 - belongs_to :condition
 - belongs_to :prefecture
 - belongs_to :handling_time
 - belongs_to :delivery_charge
 - has_one_attached :images
 - has_one :purchase

## purchases テーブル

| Column     | Type         | Options                        |
| ---------- | ------------ | ------------------------------ |
| user       | references   | null: false, foreign_key: true |
| item       | references   | null: false, foreign_key: true |

 ## Association

- belongs_to :user
- belongs_to :item
- has_one    :order

##  orders テーブル

| Column        | Type         | Options                        |
| ------------- | ------------ | ------------------------------ |
| purchase      | references   | null: false, foreign_key: true |
| post_code     | string       | null: false                    |
| prefecture_id | integer      | null: false                    |
| city          | string       | null: false                    |
| building_name | string       |                                |
| house_number  | string       | null: false                    |
| phone_number  | string       | null: false                    |


 ## Association
- belongs_to purchase
- belongs_to prefecture