class CreateWebsites < ActiveRecord::Migration
  def change
    create_table :websites do |t|
      t.references :user
      t.string :name
      t.string :host
      t.string :secret_token

      t.timestamps
    end
  end
end
