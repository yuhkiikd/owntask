class CreateLabels < ActiveRecord::Migration[5.2]
  def change
    create_table :labels do |t|
      t.string :type, null: false
      t.references :task, foreing_key: true

      t.timestamps
    end
  end
end