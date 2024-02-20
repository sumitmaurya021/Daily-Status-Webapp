class AddRemarksToStatus < ActiveRecord::Migration[7.1]
  def change
    add_column :statuses, :remarks, :text
  end
end
