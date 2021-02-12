# ProtoSpaceのER図

## usersテーブル

| Column     | Type   | Options     |
| ---------- | ------ | ----------- |
| email      | string | null: false |
| password   | string | null: false |
| name       | string | null: false |
| profile    | text   | null: false |
| occupation | text   | null: false |
| position   | text   | null: false |

### Association

- has_many :prototypes
- has_many :comments

## prototypesテーブル

| Column     | Type       | Options     |
| ---------- | ---------- | ----------- |
| title      | string     | null: false |
| catch_copy | text       | null: false |
| concept    | text       | null: false |
| user_id    | references | null: false |

### Association

- belongs_to :user
- has_many   :comments

## commentsテーブル

| Column       | Type       | Options     |
| ------------ | ---------- | ----------- |
| text         | text       | null: false |
| user_id      | references | null: false |
| prototype_id | references | null: false |

### Association

- belongs_to :user
- belongs_to :prototype