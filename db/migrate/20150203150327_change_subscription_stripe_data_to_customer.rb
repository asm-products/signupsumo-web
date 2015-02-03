class ChangeSubscriptionStripeDataToCustomer < ActiveRecord::Migration
  def change
    rename_column :subscriptions, :stripe_data, :customer
  end
end
