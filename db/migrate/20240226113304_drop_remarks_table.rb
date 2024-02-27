class DropRemarksTable < ActiveRecord::Migration[7.1]
  def change
    drop_table :remarks
  end
end
