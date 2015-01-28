class AddAuthenticationTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :authentication_token, :string, length: 20

    User.find_each do |user|
      user.save
    end

    change_column :users, :authentication_token, :string, length: 20, null: false

    add_index :users, :authentication_token, unique: true
  end
end
