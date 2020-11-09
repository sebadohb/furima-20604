
# テーブル設計

## users テーブル

| Column          | Type   | Options     |
| --------------- | ------ | ----------- |
| nickname        | string | null: false |
| email           | string | null: false |
| password        | string | null: false |
| first_name      | string | null: false |
| last_name       | string | null: false |
| first_name_kana | string | null: false |
| last_name_kana  | string | null: false |
| birth_date      | date   | null: false |

 ## Association
 - has_many : items
 - has_many : purchases 


## items テーブル

| Column             | Type         | Options                         |
| ------------------ | ------------ | ------------------------------- |
| user_id            | string       | null: false                     |
| name               | string       | null: false                     |
| description        | string       | null: false                     |
| category_id        | integer      | null: false, foreign_key: true  |
| condition_id       | integer      | null: false, foreign_key: true  |
| price              | integer      | null: false                     |
| prefecture_id      | integer      | null: false, foreign_key: true  |
| handling_time_id   | integer      | null: false, foreign_key: true  |
| delivery_charge_id | integer      | null: false, foreign_key: true  |
| brand_id           | integer      | null: false, foreign_key: true  |


 ## Association
 - belongs_to :user
 - belongs_to :category
 - belongs_to :condition
 - belongs_to :prefecture
 - belongs_to :handling_time
 - belongs_to :delivery_charge
 - belongs_to :brand
 - has_one_attached :images


## purchases テーブル

| Column     | Type         | Options                        |
| ---------- | ------------ | ------------------------------ |
| user_id    | reference    | null: false, foreign_key: true |
| item_id    | reference    | null: false, foreign_key: true |

 ## Association

- belongs_to :user
- belongs_to :item 
- has_one    : destination

##  destination テーブル

| Column        | Type         | Options                        |
| ------------- | ------------ | ------------------------------ |
| purchase_id   | reference    | null: false, foreign_key: true |
| post_code     | string       | null: false                    |
| prefecture_id | integer      | null: false, foreign_key: true |
| city          | string       | null: false                    |
| building_name | string       |                                |
| phone_number  | string       | null: false, uniqueness: true  |

 ## Association
- belongs_to purchase
- belongs_to prefecture