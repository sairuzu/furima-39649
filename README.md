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
- has_one :shippings

## items テーブル

| Column                | Type         | Options                        |
| --------------------- | ------------ | ------------------------------ |
| product_name          | string       | null: false                    |
| product_description   | text         | null: false                    |
| genre_id              | integer      | null: false                    |
| price                 | integer      | null: false                    |
| user                  | references   | null: false, foreign_key: true |
| image                 | string       | null: false                    |

### Association

- has_many :users
- has_many :comments
- belong_to :genre
- has_one :purchases
- belongs_to :shippings

## comments テーブル

| Column             | Type         | Options                        |
| ------------------ | ------------ | ------------------------------ |
| content            | text         | null: false                    |
| item               | reference    | null: false, foreign_key: true |
| user               | reference    | null: false, foreign_key: true |

### Association
- belongs_to :items
- belongs_to :user

## purchases テーブル

| Column             | Type         | Options                        |
| ------------------ | ------------ | ------------------------------ |
| item               | reference    | null: false, foreign_key: true |
| user               | reference    | null: false, foreign_key: true |

### Association
- has_one :items
- belongs_to :user
- has-one :shippings

## shippings テーブル

| Column                | Type         | Options                        |
| --------------------- | ------------ | ------------------------------ |
| post_code             | string       | null: false                    |
| genre_id              | String       | null: false                    |
| municipalities        | string       | null: false                    |
| street_address        | string       | null: false                    |
| building_name         | string       |                                |
| telephone_number      | string       | null: false                    |
| purchase              | reference    | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_many :items
- belongs_to :purchases
- belong_to :genre