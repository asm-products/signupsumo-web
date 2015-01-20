class CreateWebsites < ActiveRecord::Migration
  def change
    create_table :websites do |t|
      t.references :user
      t.string :name
      t.string :host
      t.uuid :secret_token

      t.timestamps
    end

    add_index :websites, :secret_token,   unique: true
  end
end
