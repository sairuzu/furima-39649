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
| genre_id(prefectures) | integer      | null: false                    |
| price                 | integer      | null: false                    |
| user                  | references   | null: false, foreign_key: true |
| commission            | integer      | null: false                    |
| sales_profit          | integer      | null: false                    |

### Association

- belongs_to :user
- has_many :comments
- belongs_to :genre
- has_one :purchase


## comments テーブル

| Column             | Type         | Options                        |
| ------------------ | ------------ | ------------------------------ |
| content            | text         | null: false                    |
| item               | reference    | null: false, foreign_key: true |
| user               | reference    | null: false, foreign_key: true |

### Association
- belongs_to :item
- belongs_to :user

## purchases テーブル

| Column             | Type         | Options                        |
| ------------------ | ------------ | ------------------------------ |
| item               | reference    | null: false, foreign_key: true |
| user               | reference    | null: false, foreign_key: true |

### Association
- belongs_to :item
- belongs_to :user
- has_one :shipping

## shippings テーブル

| Column                | Type         | Options                        |
| --------------------- | ------------ | ------------------------------ |
| post_code             | string       | null: false                    |
| genre_id(prefectures) | integer      | null: false                    |
| municipalities        | string       | null: false                    |
| street_address        | string       | null: false                    |
| building_name         | string       |                                |
| telephone_number      | string       | null: false                    |
| purchase              | reference    | null: false, foreign_key: true |

### Association

- belongs_to :purchase