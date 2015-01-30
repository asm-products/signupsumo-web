class CreateSignups < ActiveRecord::Migration
  def change
    enable_extension 'uuid-ossp' unless extension_enabled?('uuid-ossp')

    create_table :signups, id: :uuid, default: 'uuid_generate_v4()' do |t|
      t.uuid :user_id, null: false
      t.string :email, null: false
      t.boolean :influential, null: false, defualt: false
      t.json :data

      t.timestamps null: false
    end

    add_index :signups, [:user_id, :email], unique: true

    User.delete_all

    remove_column :users, :id
    add_column :users, :id, :uuid, default: 'uuid_generate_v4()'
    execute "ALTER TABLE users ADD PRIMARY KEY (id);"
  end
end
