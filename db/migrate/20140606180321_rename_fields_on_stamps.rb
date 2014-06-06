class RenameFieldsOnStamps < ActiveRecord::Migration
  def change
    change_table :stamps do |t|
      t.rename :url_preview, :url_small
      t.rename :width_preview, :width_small
      t.rename :height_preview, :height_small
      t.rename :url_full, :url_medium
      t.rename :width_full, :width_medium
      t.rename :height_full, :height_medium
    end
  end
end
