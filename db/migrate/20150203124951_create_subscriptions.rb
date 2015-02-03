class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.uuid :user_id, null: false
      t.json :stripe_data

      t.timestamps null: false
    end

    add_index :subscriptions, :user_id, unique: true
  end
end
