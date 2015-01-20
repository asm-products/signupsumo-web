class ChangeDataFormatInProfile < ActiveRecord::Migration
  def change
    change_column :profiles, :data, :text
  end
end
