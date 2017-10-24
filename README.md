# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
-ruby 2.3.1p112 (2016-04-26 revision 54768) [x86_64-darwin16]

* Database creation

## messages table

|Column|Type|Options|
|------|----|-------|
|body|text|null: false|
|image|string||
|user_id|integer|null: false, foreign_key: true|
|chat_group_id|integer|null: false, foreign_key: true|

### Association
- belongs_to :group
- belongs_to :user

## users table

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|email|string|null: false|
|password|string|null: false|

### Association
- has_many :messages
- has_many :groups, through: :chat_group_users
- has_many :chat_group_users

## chat_groupsテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false, unique: true|

### Association
-  has_many :messages
-  has_many :users, through: :chat_group_users
-  has_many :chat_group_users

## group_users table

|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|chat_group_id|integer|null: false, foreign_key: true|

