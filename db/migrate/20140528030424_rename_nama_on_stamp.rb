class RenameNamaOnStamp < ActiveRecord::Migration
  def change
    change_table :stamps do |t|
      t.rename :nama, :text
    end
  end
end
