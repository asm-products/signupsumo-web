class AddFreebiesAndActiveUntilToUser < ActiveRecord::Migration
  def change
    add_column :users, :freebie_count, :integer, default: 10
    add_column :users, :active_until, :datetime
  end
end
