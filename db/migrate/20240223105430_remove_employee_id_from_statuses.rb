class RemoveEmployeeIdFromStatuses < ActiveRecord::Migration[7.1]
  def change
    remove_column :statuses, :employee_id
  end
end
