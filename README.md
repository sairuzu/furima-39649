# テーブル設計

## users テーブル

| Column             | Type     | Options                   |
| ------------------ | ------   |-------------------------- |
| email              | string   | null: false, unique: true |
| encrypted_password | string   | null: false               |
| nickname           | string   | null: false, unique: true |
| name               | string   | null: false               |
| name_kana          | string   | null: false               |
| birth_date         | datetime | null: false               |

### Association

- has_many :items
- has_many :comments
- has_many :purchases
- has_one :shippings

## items テーブル

| Column                | Type         | Options                        |
| --------------------- | ------------ | ------------------------------ |
| product_name          | string       | null: false                    |
| product_description   | text         | null: false                    |
| category              | string       | null: false                    |
| product_condition     | string       | null: false                    |
| delivery_charge       | string       | null: false                    |
| shipping_source       | string       | null: false                    |
| date_shipment         | datetime     | null: false                    |
| price                 | integer      | null: false                    |
| nickname              | references   | null: false, foreign_key: true |

### Association

- has_many :users
- has_many :comments
- has_one :purchases
- has_one :shippings

## comments テーブル

| Column             | Type         | Options                        |
| ------------------ | ------------ | ------------------------------ |
| content            | text         | null: false                    |
| item               | reference    | null: false, foreign_key: true |
| nickname           | reference    | null: false, foreign_key: true |

### Association
- belongs_to :items
- belongs_to :user

## purchases テーブル

| Column             | Type         | Options                        |
| ------------------ | ------------ | ------------------------------ |
| product_name       | reference    | null: false, foreign_key: true |
| nickname           | reference    | null: false, foreign_key: true |

### Association
- has_many :items
- belongs_to :user
- belongs_to :shippings

## shippings テーブル

| Column                | Type         | Options                        |
| --------------------- | ------------ | ------------------------------ |
| post_code             | integer      | null: false                    |
| prefectures           | string       | null: false                    |
| municipalities        | string       | null: false                    |
| street_address        | text         | null: false                    |
| building_name         | text         |                                |
| telephone_number      | integer      | null: false                    |
| name                  | reference    | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_many :items
- has_many :purchases