class RemoveUnusedTables < ActiveRecord::Migration
  def change
    drop_table :profiles
    drop_table :registers
    drop_table :websites
  end
end
