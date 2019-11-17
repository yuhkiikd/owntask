- task
  - id integer
  - user_id integer
  - label_id integer
  - title string
  - details text
  - priority string
  - status string
  - limit date

- user
  - id integer
  - name string
  - email string
  - password_digest string

- label
  - id integer
  - user_id integer
  - type string