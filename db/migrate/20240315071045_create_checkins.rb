class CreateCheckins < ActiveRecord::Migration[7.1]
  def change
    create_table :checkins do |t|
      t.integer :user_id, null: false
      t.datetime :check_in_at, null: false
      t.datetime :checked_out_at
      t.integer :duration

      t.timestamps
    end
  end
end
