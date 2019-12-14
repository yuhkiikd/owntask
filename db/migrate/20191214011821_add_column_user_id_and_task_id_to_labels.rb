class AddColumnUserIdAndTaskIdToLabels < ActiveRecord::Migration[5.2]
  def change
    add_column :labels, :user_id, :integer, null: false
    add_column :labels, :task_id, :integer, null: false
  end
end
