Taskモデル
| カラム名 | データ型 |
----|----
| id | integer |
| user_id(FK) | integer |
| label_id(FK) | integer |
| title | string |
| details | text |
| priority | string |
| status | string |
| limit | date |

user
| カラム名 | データ型 |
----|----
| id | integer |
| name | string |
| email | string |
| password_digest | string |

label
| カラム名 | データ型 |
----|----
| id | integer |
| task_id(FK) | integer |
| type | string |