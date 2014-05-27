class CreateStamp < ActiveRecord::Migration
  def change
    create_table :stamps, :id => false, :primary_key => :id  do |t|
      t.string :id, null: false
      t.string :nama
      t.string :url_preview
      t.integer :width_preview
      t.integer :height_preview
      t.string :url_full
      t.integer :width_full
      t.integer :height_full
    end
  end
end
