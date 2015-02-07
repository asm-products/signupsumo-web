class AddHiddenToSignups < ActiveRecord::Migration
  def change
    add_column :signups, :hidden, :boolean, default: true
    add_index :signups, :hidden
  end
end
