class CreateRegisters < ActiveRecord::Migration
  def change
    create_table :registers do |t|
      t.boolean :is_influential
      t.boolean :is_notified
      t.references :website
      t.references :profile

      t.timestamps
    end
  end
end
