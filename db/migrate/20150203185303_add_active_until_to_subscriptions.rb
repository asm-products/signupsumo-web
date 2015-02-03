class AddActiveUntilToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :active_until, :datetime
  end
end
