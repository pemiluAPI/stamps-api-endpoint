class AddNewFieldsOnStamps < ActiveRecord::Migration
  def change
    change_table :stamps do |t|
      t.string :url_large
      t.string :width_large
      t.string :height_large
    end
  end
end
