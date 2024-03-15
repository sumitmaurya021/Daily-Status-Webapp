class ChangingStatusDefault < ActiveRecord::Migration[7.1]
  def change
    change_column :statuses, :status, :string, default: "pending"
  end
end
