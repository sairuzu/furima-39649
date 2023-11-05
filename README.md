# テーブル設計

## users テーブル

| Column             | Type     | Options                   |
| ------------------ | ------   |-------------------------- |
| email              | string   | null: false, unique: true |
| encrypted_password | string   | null: false               |
| nickname           | string   | null: false               |
| last_name          | string   | null: false               |
| first_name         | string   | null: false               |
| last_name_kana     | string   | null: false               |
| first_name_kana    | string   | null: false               |
| birth_date         | date     | null: false               |

### Association

- has_many :items
- has_many :comments
- has_many :purchases

## items テーブル

| Column                | Type         | Options                        |
| --------------------- | ------------ | ------------------------------ |
| product_name          | string       | null: false                    |
| product_description   | text         | null: false                    |
| category_id           | integer      | null: false                    |
| product_condition_id  | integer      | null: false                    |
| delivery_charge_id    | integer      | null: false                    |
| prefecture_id         | integer      | null: false                    |
| shipping_day_id       | integer      | null: false                    |
| price                 | integer      | null: false                    |
| user                  | referencess  | null: false, foreign_key: true |
| commission            | integer      | null: false                    |
| sales_profit          | integer      | null: false                    |

### Association

- belongs_to :user
- has_many :comments
  belongs_to :category
  belongs_to :product_condition
  belongs_to :delivery_charge
  belongs_to :prefecture
  belongs_to :shipping_day
- has_one :purchase


## comments テーブル

| Column             | Type         | Options                        |
| ------------------ | ------------ | ------------------------------ |
| content            | text         | null: false                    |
| item               | references   | null: false, foreign_key: true |
| user               | references   | null: false, foreign_key: true |

### Association
- belongs_to :item
- belongs_to :user

## purchases テーブル

| Column             | Type         | Options                        |
| ------------------ | ------------ | ------------------------------ |
| item               | references   | null: false, foreign_key: true |
| user               | references   | null: false, foreign_key: true |

### Association
- belongs_to :item
- belongs_to :user
- has_one :shipping

## shippings テーブル

| Column                | Type         | Options                        |
| --------------------- | ------------ | ------------------------------ |
| post_code             | string       | null: false                    |
| prefecture_id         | integer      | null: false                    |
| municipalities        | string       | null: false                    |
| street_address        | string       | null: false                    |
| building_name         | string       |                                |
| telephone_number      | string       | null: false                    |
| purchase              | reference    | null: false, foreign_key: true |

### Association
- belongs_to :purchase