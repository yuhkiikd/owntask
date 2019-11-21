class RemoveTaskIdFromLabels < ActiveRecord::Migration[5.2]
  def change
    remove_index :labels, :task_id
    remove_column :labels, :task_id, :bigint
  end
end
