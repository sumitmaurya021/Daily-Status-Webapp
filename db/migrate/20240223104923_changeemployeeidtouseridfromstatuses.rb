class Changeemployeeidtouseridfromstatuses < ActiveRecord::Migration[7.1]
  def up
    change_table :statuses do |t|
      t.change :user_id, :integer
    end
  end

  def down
    change_table :statuses do |t|
      t.change :employee_id
    end
  end
end
