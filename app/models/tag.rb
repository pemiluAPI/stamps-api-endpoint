class Tag < ActiveRecord::Base
  belongs_to :stamp, foreign_key: :id_stamp
end
