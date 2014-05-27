class CreateTag < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :id_stamp
      t.string :tag
    end
  end
end
