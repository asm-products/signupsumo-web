class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :email
      t.text :data
      t.boolean :is_influential, :default => false
      t.string :score

      t.timestamps
    end
  end
end
