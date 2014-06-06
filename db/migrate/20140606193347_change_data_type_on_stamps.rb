class ChangeDataTypeOnStamps < ActiveRecord::Migration
  def change
    change_table :stamps do |t|
      t.change :width_large, :integer
      t.change :height_large, :integer      
    end
  end
end
