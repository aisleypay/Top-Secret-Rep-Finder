class State < ActiveRecord::Base
  has_many :senators
  has_many :political_partys, through: :senators

end
