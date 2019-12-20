class ChangeColumnLabelTypeToLabels < ActiveRecord::Migration[5.2]
  def change
    change_column_null :labels, :label_type, false
  end
end