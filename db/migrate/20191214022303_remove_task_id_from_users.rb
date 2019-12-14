class RemoveTaskIdFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_index :users, :task_id
    remove_column :users, :task_id, :bigint
  end
end