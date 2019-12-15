class RemoveNullFalseFromLabels < ActiveRecord::Migration[5.2]
  def change
    change_column :labels, :label_type, :string, null: true
  end
end