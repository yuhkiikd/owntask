class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :title, null: false
      t.text :details, null: false
      t.string :priority, null: false
      t.string :status, null: false
      t.date :limit, null: false
      t.references :user, foreing_key: true
      t.references :label, foreing_key: true

      t.timestamps
    end
  end
end