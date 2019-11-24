## Taskモデル
| カラム名 | データ型 |
---|---
| id | integer |
| user_id(FK) | integer |
| label_id(FK) | integer |
| title | string |
| details | text |
| priority | string |
| status | string |
| limit | date |

## user
| カラム名 | データ型 |
---|---
| id | integer |
| name | string |
| email | string |
| password_digest | string |

## label
| カラム名 | データ型 |
---|---
| id | integer |
| task_id(FK) | integer |
| type | string |

## versions
- Ruby 2.6.5
- PosgreSQL 12.1
- Ruby on rails 5.2.3

## How to deploy
### カレントブランチのファイルをステージング領域へ
1.git add -A

### 作業内容のメッセージを記載してコミット
2.git commit -m "hogehoge"

### herokuにログイン
3.heroku login --interactive
※パスワード入力する

### heroku上にアプリを作成
4.heroku create アプリ名

### herokuにデプロイする
5.git push heroku master

### herokuのデータベース実行
6.heroku run rails db:migrate

### urlを確認し、アクセス
7.heroku config
※表示されるurlへアクセス
https://アプリ名.herokuapp.com/
