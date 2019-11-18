Taskモデル
| id | integer |
| user_id(FK) | integer |
| label_id(FK) | integer |
| title | string |
| details | text |
| priority | string |
| status | string |
| limit | date |

user
| id | integer |
| name | string |
| email | string |
| password_digest | string |

label
| id | integer |
| task_id(FK) | integer |
| type | string |