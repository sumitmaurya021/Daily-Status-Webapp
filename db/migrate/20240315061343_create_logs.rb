class CreateLogs < ActiveRecord::Migration[7.1]
  def change
    create_table :logs do |t|

      t.timestamps
    end
  end
end
