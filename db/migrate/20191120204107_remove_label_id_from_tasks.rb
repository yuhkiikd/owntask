class RemoveLabelIdFromTasks < ActiveRecord::Migration[5.2]
  def change
    remove_index :tasks, :label_id
    remove_column :tasks, :label_id, :bigint
  end
end