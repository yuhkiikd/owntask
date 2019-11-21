class RemoveLabeling < ActiveRecord::Migration[5.2]
  def change
    drop_table :labelings
  end
end