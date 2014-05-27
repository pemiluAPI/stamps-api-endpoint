class Stamp < ActiveRecord::Base
  self.primary_key  = "id"
  has_many :tags, foreign_key: :id_stamp
end
