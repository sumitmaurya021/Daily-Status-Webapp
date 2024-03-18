class AddlogsUserIdAction < ActiveRecord::Migration[7.1]
  def change
    add_column :logs, :user_id, :integer
    add_column :logs, :action, :string
    add_column :logs, :timestamp, :datetime
  end
end
